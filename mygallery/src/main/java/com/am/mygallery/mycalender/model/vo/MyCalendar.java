package com.am.mygallery.mycalender.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

public class MyCalendar  implements Serializable {
 
   private static final long serialVersionUID = -7300271109542510089L;
   
   String year = "";
   String month = "";
   String date = "";
   String value = "";
   String schedule_date = "";
   String schedule_detail="";		//content 내용 저장할 곳
   String imgName = "";			//이미지 파일명 저장할 곳
   
   private Date calendar_date;
   private String userid;
   private String filename;
   private String calendar_content;
   
   public MyCalendar() {}


   public MyCalendar(Date calendar_date, String userid, String filename, String calendar_content) {
      super();
      this.calendar_date = calendar_date;
      this.userid = userid;
      this.filename = filename;
      this.calendar_content = calendar_content;
   }




   public Date getCalendar_date() {
      return calendar_date;
   }


   public void setCalendar_date(Date calendar_date) {
      this.calendar_date = calendar_date;
   }


   public String getUserid() {
      return userid;
   }


   public void setUserid(String userid) {
      this.userid = userid;
   }


   public String getFilename() {
	   return filename;
   }


	public void setFilename(String filename) {
		this.filename = filename;
	}



   public String getCalendar_content() {
      return calendar_content;
   }


   public void setCalendar_content(String calender_content) {
      this.calendar_content = calender_content;
   }


   public String getYear() {
      return year;
   }

   public void setYear(String year) {
      this.year = year;
   }

   public String getMonth() {
      return month;
   }

   public void setMonth(String month) {
      this.month = month;
   }

   public String getDate() {
      return date;
   }

   public void setDate(String date) {
      this.date = date;
   }

   public String getValue() {
      return value;
   }

   public void setValue(String value) {
      this.value = value;
   }

   public String getSchedule_date() {
      return schedule_date;
   }

   public void setSchedule_date(String schedule) {
      this.schedule_date = schedule;
   }

   public String getSchedule_detail() {
      return schedule_detail;
   }

   public String getImgName() {
	return imgName;
	}


	public void setImgName(String imgName) {
		this.imgName = imgName;
	}


	public void setSchedule_detail(String schedule_detail) {
      this.schedule_detail = schedule_detail;
   }

   
  


   @Override
   public String toString() {
      return "MyCalendar [calendar_date=" + calendar_date + ", userid=" + userid + ", filename=" + filename
            + ", calender_content=" + calendar_content + "]";
   }


   //날짜에 관련된 달력정보를 가지는 메서드
   public Map<String, Integer> today_info(MyCalendar my){
      //날짜 캘린더 함수에 삽임.
      Map<String, Integer> today_Calendar = new HashMap<String, Integer>();
      Calendar cal = Calendar.getInstance();
      cal.set(Integer.parseInt(my.getYear()), Integer.parseInt(my.getMonth()), 1);
      
      int startDay = cal.getMinimum(java.util.Calendar.DATE);
      int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
      int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
      
      Calendar todayCal = Calendar.getInstance();
      SimpleDateFormat ysdf = new SimpleDateFormat("yyyy");
      SimpleDateFormat msdf = new SimpleDateFormat("M");
      
      int today_year = Integer.parseInt(ysdf.format(todayCal.getTime()));
      int today_month = Integer.parseInt(msdf.format(todayCal.getTime()));

      int search_year = Integer.parseInt(my.getYear());
      int search_month = Integer.parseInt(my.getMonth()) + 1;

      int today = -1;
      if (today_year == search_year && today_month == search_month) {
         SimpleDateFormat dsdf = new SimpleDateFormat("dd");
         today = Integer.parseInt(dsdf.format(todayCal.getTime()));
      }
   
      search_month = search_month-1; 
      
      Map<String, Integer> before_after_calendar = before_after_calendar(search_year,search_month);
      
      //날짜 관련
      System.out.println("search_month : " + search_month);
      // 캘린더 함수 end
      today_Calendar.put("start", start);
      today_Calendar.put("startDay", startDay);
      today_Calendar.put("endDay", endDay);
      today_Calendar.put("today", today);
      today_Calendar.put("search_year", search_year);
      today_Calendar.put("search_month", search_month+1);
      today_Calendar.put("before_year", before_after_calendar.get("before_year"));
      today_Calendar.put("before_month", before_after_calendar.get("before_month"));
      today_Calendar.put("after_year", before_after_calendar.get("after_year"));
      today_Calendar.put("after_month", before_after_calendar.get("after_month"));
      return today_Calendar;
   }
   
   //이전달 다음달 및 이전년도 다음년도
   private Map<String, Integer> before_after_calendar(int search_year, int search_month) {
      Map<String, Integer> before_after_data = new HashMap<String, Integer>();
      int before_year = search_year;
      int before_month = search_month-1;
      int after_year = search_year;
      int after_month = search_month+1;
      
      if(before_month<0){
         before_month=11;
         before_year=search_year-1;
      }
      
      if(after_month>11){
         after_month=0;
         after_year=search_year+1;
      }
      
      before_after_data.put("before_year", before_year);
      before_after_data.put("before_month", before_month);
      before_after_data.put("after_year", after_year);
      before_after_data.put("after_month", after_month);
      
      return before_after_data;
   }
   
   //달력만 사용시 사용될 생성자
   public MyCalendar(String year, String month, String date, String value) {
      if ((month != null && month != "") && (date != null && date != "")) {
         this.year = year;
         this.month = month;
         this.date = date;
         this.value = value;
      }
   }
}