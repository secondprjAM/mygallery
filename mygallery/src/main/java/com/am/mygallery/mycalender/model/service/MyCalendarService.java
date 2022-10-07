package com.am.mygallery.mycalender.model.service;

import java.util.ArrayList;

import com.am.mygallery.common.SearchCalendar;
import com.am.mygallery.mycalender.model.vo.MyCalendar;

public interface MyCalendarService {
		ArrayList<MyCalendar> searchMonth(SearchCalendar startDay);
}
