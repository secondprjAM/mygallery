package com.am.mygallery.mycalender.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.am.mygallery.common.SearchCalendar;
import com.am.mygallery.mycalender.model.service.MyCalendarService;
import com.am.mygallery.mycalender.model.vo.MyCalendar;

@Controller
public class MyCalendarController {
	private String g_userid="";
	@Autowired
	private MyCalendarService service;

	@RequestMapping(value = "mycalendar.do", method = RequestMethod.GET)
	public String calendar(Model model, HttpServletRequest request, MyCalendar dateData){

		Calendar cal = Calendar.getInstance();
		MyCalendar calendarData = null;
		//검색 날짜
		if(dateData.getDate().equals("")&&dateData.getMonth().equals("")){
			dateData = new MyCalendar(String.valueOf(cal.get(Calendar.YEAR)),String.valueOf(cal.get(Calendar.MONTH)),String.valueOf(cal.get(Calendar.DATE)),null);
		}
		//검색 날짜 end
		
		Map<String, Integer> today_info =  dateData.today_info(dateData);
		List<MyCalendar> dateList = new ArrayList<MyCalendar>();
		///테스트 구간
		if(request.getParameter("userid")!=null){
			this.g_userid = request.getParameter("userid");
		}
		String dateFormat = String.valueOf(today_info.get("search_year"))+String.valueOf(today_info.get("search_month"))+"01";
		SearchCalendar searchAllCalendar = new SearchCalendar(dateFormat,this.g_userid);
		ArrayList<MyCalendar>list = service.searchMonth(searchAllCalendar);
		int list_size = list.size();
		int dateNum=0;
		if(list.size()>0)
		{
			for (MyCalendar myCalendar : list) {
				String da = myCalendar.getCalendar_date().toString();
				System.out.println(myCalendar.getCalendar_date().toString().substring(myCalendar.getCalendar_date().toString().length()-2, myCalendar.getCalendar_date().toString().length()));
			}
		}

		///테스트 종료
		//실질적인 달력 데이터 리스트에 데이터 삽입 시작.
		//일단 시작 인덱스까지 아무것도 없는 데이터 삽입
		for(int i=1; i<today_info.get("start"); i++){
			calendarData= new MyCalendar(null, null, null, null,0);
			dateList.add(calendarData);
		}
		//날짜 삽입
		for (int i = today_info.get("startDay"); i <= today_info.get("endDay"); i++) {
			if(dateNum<list_size && i ==Integer.parseInt(list.get(dateNum).getCalendar_date().toString().substring(list.get(dateNum).getCalendar_date().toString().length()-2, list.get(dateNum).getCalendar_date().toString().length())) ) {
				
				String d = list.get(dateNum).getCalendar_date().toString();
				list.get(dateNum).setDate(d);
				list.get(dateNum).setCalendar_date(null);
				list.get(dateNum).setSchedule_detail(list.get(dateNum).getCalendar_content());
				list.get(dateNum).setImgName(list.get(dateNum).getFilename());
				if(i==today_info.get("today")) {
					list.get(dateNum).setValue("today");
				}
				calendarData = list.get(dateNum);
				dateNum++;
				System.out.println("들어감");
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
				calendarData= new MyCalendar(null, null, null, null);
				dateList.add(calendarData);
			}
		}
		System.out.print(dateList.size());
		//배열에 담음
		model.addAttribute("dateList", dateList);		//날짜 데이터 배열
		model.addAttribute("today_info", today_info);
		return "mycalendar/mycalendar";
	}
}
