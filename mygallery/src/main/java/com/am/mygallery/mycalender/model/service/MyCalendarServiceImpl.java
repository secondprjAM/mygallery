package com.am.mygallery.mycalender.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.am.mygallery.common.SearchCalendar;
import com.am.mygallery.mycalender.model.dao.MyCalendarDao;
import com.am.mygallery.mycalender.model.vo.MyCalendar;

@Service("calendarService")
public class MyCalendarServiceImpl implements MyCalendarService{
	
	@Autowired
	private MyCalendarDao calendarDao;

	@Override
	public ArrayList<MyCalendar> searchMonth(SearchCalendar startDay) {
		return calendarDao.searchMonth(startDay);
	}

	@Override
	public int insertMyCalendar(MyCalendar mycalendar) {
		return calendarDao.insertMyCalendar(mycalendar);
	}

	@Override
	public MyCalendar serchMyCalendar(SearchCalendar mycalendar) {
		return calendarDao.serchMyCalendar(mycalendar);
	}

	@Override
	public int deleteCalendar(SearchCalendar mycalendar) {
		return calendarDao.deleteCalendar(mycalendar);
	}

	@Override
	public int updateCalendar(MyCalendar mycalendar) {
		return calendarDao.updateCalendar(mycalendar);
	}

}
