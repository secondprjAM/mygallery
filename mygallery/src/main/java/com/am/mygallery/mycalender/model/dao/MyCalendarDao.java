package com.am.mygallery.mycalender.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.am.mygallery.common.SearchCalendar;
import com.am.mygallery.mycalender.model.vo.MyCalendar;

@Repository("calendarDao")  //xml 자동 등록됨 (id지정함)
public class MyCalendarDao {
	@Autowired
	private SqlSessionTemplate session;

	public ArrayList<MyCalendar> searchMonth(SearchCalendar startDay) {
		
		List<MyCalendar> list = session.selectList("mycalendarMapper.searchMonth",startDay);
		return (ArrayList<MyCalendar>)list;
	}
	
	public int insertMyCalendar(MyCalendar mycalendar) {
		return session.insert("mycalendarMapper.insertMyCalendar", mycalendar);
	}

	public MyCalendar serchMyCalendar(SearchCalendar mycalendar) {
		
		return session.selectOne("mycalendarMapper.serchMyCalendar",mycalendar);
	}

	public int deleteCalendar(SearchCalendar mycalendar) {
		return session.delete("mycalendarMapper.deleteCalendar",mycalendar);
	}

	public int updateCalendar(MyCalendar mycalendar) {
		return session.update("mycalendarMapper.updateCalendar",mycalendar);
	}
}








