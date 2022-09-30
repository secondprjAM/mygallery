//package com.am.mygallery.mycalender.model.service;
//
//import java.util.ArrayList;
//import java.util.Calendar;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import com.test.first.common.Paging;
//
//@Service("calendarService")
//public class MyCalendarServiceImpl implements MyCalendarService{
//	
//	@Autowired
//	private MyCalendarDao boardDao;
//
//	@Override
//	public ArrayList<Calendar> selectTop3() {
//		return calendarDao.selectTop3();
//	}
//
//	@Override
//	public int selectListCount() {
//		// TODO Auto-generated method stub
//		return calendarDao.selectListCount();
//	}
//
//	@Override
//	public ArrayList<Calendar> selectList(Paging page) {
//		// TODO Auto-generated method stub
//		return calendarDao.selectList(page);
//	}
//
//	@Override
//	public Calendar selectBoard(int board_num) {
//		// TODO Auto-generated method stub
//		return null;
//	}
//
//	@Override
//	public int updateAddReadcount(int calendar_num) {
//		// TODO Auto-generated method stub
//		return 0;
//	}
//
//	@Override
//	public int insertOriginBoard(Calendar board) {
//		// TODO Auto-generated method stub
//		return 0;
//	}
//
//	@Override
//	public int insertReply(Calendar reply) {
//		// TODO Auto-generated method stub
//		return 0;
//	}
//
//	@Override
//	public int updateReplySeq(Calendar reply) {
//		// TODO Auto-generated method stub
//		return 0;
//	}
//
//	@Override
//	public int updateOrigin(Calendar board) {
//		// TODO Auto-generated method stub
//		return 0;
//	}
//
//	@Override
//	public int updateReply(Calendar reply) {
//		// TODO Auto-generated method stub
//		return 0;
//	}
//
//	@Override
//	public int deleteBoard(Calendar board) {
//		// TODO Auto-generated method stub
//		return 0;
//	}
//
//}
