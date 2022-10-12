package com.am.mygallery.mycalender.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.am.mygallery.common.SearchCalendar;
import com.am.mygallery.common.SearchDate;
import com.am.mygallery.gallery.controller.GalleryController;
import com.am.mygallery.gallery.model.service.GalleryService;
import com.am.mygallery.gallery.model.vo.Gallery;
import com.am.mygallery.mycalender.model.service.MyCalendarService;
import com.am.mygallery.mycalender.model.vo.MyCalendar;

@Controller
public class MyCalendarController {
	private static final Logger logger = LoggerFactory.getLogger(MyCalendarController.class);
	@Autowired
	private MyCalendarService mycalendarService;
	
	@Autowired
	private GalleryService galleryService;

	@RequestMapping(value = "mycalendar.do", method = RequestMethod.GET)
	public String calendar(Model model, HttpServletRequest request, MyCalendar dateData){
		String g_userid="";
		Calendar cal = Calendar.getInstance();
		MyCalendar calendarData = null;
		//검색 날짜
		if(dateData.getDate().equals("")&&dateData.getMonth().equals("")){
			dateData = new MyCalendar(String.valueOf(cal.get(Calendar.YEAR)),String.valueOf(cal.get(Calendar.MONTH)),String.valueOf(cal.get(Calendar.DATE)),null);
		}
		//검색 날짜 end
		Map<String, Integer> today_info =  dateData.today_info(dateData);
		List<MyCalendar> dateList = new ArrayList<MyCalendar>();
		
		//DB 검색
		if(request.getParameter("userid")!=null){
			g_userid = request.getParameter("userid");
		}
		String dateFormat = String.valueOf(today_info.get("search_year"))+String.valueOf(today_info.get("search_month"))+"00";
		String endDate = String.valueOf(today_info.get("search_year"))+String.valueOf(today_info.get("search_month"))+today_info.get("endDay");
		SearchCalendar searchAllCalendar = new SearchCalendar(dateFormat,g_userid,endDate);
		ArrayList<MyCalendar>list = mycalendarService.searchMonth(searchAllCalendar);
		int list_size = list.size();
		int dateNum=0;


		for(int i=1; i<today_info.get("start"); i++){
			calendarData= new MyCalendar("", null, null, null);
			dateList.add(calendarData);
		}
		//날짜 삽입
		for (int i = today_info.get("startDay"); i <= today_info.get("endDay"); i++) {
			if(dateNum<list_size && i ==Integer.parseInt(list.get(dateNum).getCalendar_date().toString().substring(list.get(dateNum).getCalendar_date().toString().length()-2, list.get(dateNum).getCalendar_date().toString().length())) ) {
				String d = list.get(dateNum).getCalendar_date().toString();
				list.get(dateNum).setDate(i+"");
				list.get(dateNum).setSchedule_date(d);
				list.get(dateNum).setCalendar_date(null);
				list.get(dateNum).setSchedule_detail(list.get(dateNum).getCalendar_content());
				list.get(dateNum).setImgName(list.get(dateNum).getFilename());
				if(i==today_info.get("today")) {
					list.get(dateNum).setValue("today");
				}
				calendarData = list.get(dateNum);
				dateNum++;
			}else {
				if(i==today_info.get("today")){
					calendarData= new MyCalendar(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "today");
				}else{
					calendarData= new MyCalendar(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "normal_date");
				}
			}
			dateList.add(calendarData);
		}
		//달력 빈곳 빈 데이터로 삽입
		int index = 7-dateList.size()%7;

		if(dateList.size()%7!=0){

			for (int i = 0; i < index; i++) {
				calendarData= new MyCalendar("", null, null, null);
				dateList.add(calendarData);
			}
		}
		System.out.print(dateList.size());
		//배열에 담음
		model.addAttribute("dateList", dateList);		//날짜 데이터 배열
		model.addAttribute("today_info", today_info);
		return "mycalendar/mycalendar";
	}

	//글쓰기 버튼 
	@RequestMapping("calmovewrite.do")
	public String moveInsertView(@RequestParam("userid") String userid, Model model) {
		ArrayList<Gallery> list = galleryService.selectImgList(userid);
		logger.info("갤러리 정보 : " + list);
		if(list.size()>0) {
			model.addAttribute("imgList", list);
		}
		return "mycalendar/mycalendarWriteForm";
	}

	//날짜 저장(이미지 정보는 갤러리에 저장되어 있는 rename 이름 가져다 사용)
	@RequestMapping(value="minsert.do", method=RequestMethod.POST)
	public String insertMycalendar (MyCalendar mycalendar, Model model
			, HttpServletRequest request) {
		String filename = request.getParameter("filename");
		mycalendar.setFilename(filename);
		//해당 날짜에 저장된 데이터가 있는지 확인용 
		String date = mycalendar.getCalendar_date().toString();
		date = date.replace("-", "");
		SearchCalendar cal = new SearchCalendar();
		cal.setDateFormat(date);
		cal.setId(mycalendar.getUserid());
		MyCalendar list = mycalendarService.serchMyCalendar(cal);
		
		if(list == null) {
			System.out.println(mycalendar);
			if(mycalendarService.insertMyCalendar(mycalendar) > 0) {
				return "redirect:mycalendar.do?userid="+mycalendar.getUserid();
			}else {
				model.addAttribute("message", "새 캘린더 등록 실패");
				return "common/error";
			}
		}
		else {
			model.addAttribute("titleMsg","등록 날짜 중복!");
			model.addAttribute("message", "이미 등록된 데이터가 있습니다.");
			return "common/error";
		}
	}

	//수정페이지 이동
	@RequestMapping("calmoveup.do")
	public String updatePage(HttpServletRequest request, Model model) {
		String date = request.getParameter("date");
		date = date.replace("-", "");
		SearchCalendar cal = new SearchCalendar();
		cal.setDateFormat(date);
		cal.setId(request.getParameter("userid"));
		MyCalendar list = mycalendarService.serchMyCalendar(cal);
		ArrayList<Gallery> imglist = galleryService.selectImgList(request.getParameter("userid"));
		model.addAttribute("mycalendar", list);
		model.addAttribute("imgList", imglist);
		return "mycalendar/mycalendarUpdateForm";
	}
	
	//수정된 정보 갱신
	@RequestMapping("calupdate.do")
	public String updateCalendar(MyCalendar mycalendar, Model model) {
		if(mycalendarService.updateCalendar(mycalendar)>0) {
			return "redirect:mycalendar.do?userid="+mycalendar.getUserid();
		}else {
			model.addAttribute("titleMsg","내용 수정 실패");
			model.addAttribute("message", "내용 변경 실패하였습니다.");
			return "common/error";
		}
	}
	//삭제
	@RequestMapping("deleteCal.do")
	public String deleteCalendar(HttpServletRequest request, Model model) {
		SearchCalendar mycalendar = new SearchCalendar();
		String date = request.getParameter("date");
		date = date.replace("-", "");
		mycalendar.setId(request.getParameter("userid"));
		mycalendar.setDateFormat(date);
		if(mycalendarService.deleteCalendar(mycalendar)>0) {
			return "redirect:mycalendar.do?userid="+request.getParameter("userid");
		}else{
			model.addAttribute("titleMsg", request.getParameter("date")+" 삭제 실패");
			model.addAttribute("message","삭제하는데 실패 하였습니다. 다시 확인해 주세요");
			return "common/error";
		}
	}
	
}
