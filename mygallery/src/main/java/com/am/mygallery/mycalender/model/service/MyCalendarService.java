package com.am.mygallery.mycalender.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.am.mygallery.common.SearchCalendar;
import com.am.mygallery.mycalender.model.vo.MyCalendar;

public interface MyCalendarService {
		ArrayList<MyCalendar> searchMonth(SearchCalendar startDay);
		int insertMyCalendar(MyCalendar mycalendar); //원글 등록
		MyCalendar serchMyCalendar(SearchCalendar mycalendar);
		int deleteCalendar(SearchCalendar mycalendar);
		int updateCalendar(MyCalendar mycalendar);
}
