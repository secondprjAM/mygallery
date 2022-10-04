package com.am.mygallery.mycalender.model.vo;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

public class MyCalendar {

	String year = "";
	String month = "";
	String date = "";
	String value = "";
	String schedule = "";
	String schedule_detail="";
	
	public MyCalendar() {}

	public MyCalendar(String year, String month, String date, String value, String schedule, String schedule_detail) {
		super();
		this.year = year;
		this.month = month;
		this.date = date;
		this.value = value;
		this.schedule = schedule;
		this.schedule_detail = schedule_detail;
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

	public String getSchedule() {
		return schedule;
	}

	public void setSchedule(String schedule) {
		this.schedule = schedule;
	}

	public String getSchedule_detail() {
		return schedule_detail;
	}

	public void setSchedule_detail(String schedule_detail) {
		this.schedule_detail = schedule_detail;
	}

	@Override
	public String toString() {
		return "MyCalendar [year=" + year + ", month=" + month + ", date=" + date + ", value=" + value + ", schedule="
				+ schedule + ", schedule_detail=" + schedule_detail + "]";
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
