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

	
}
