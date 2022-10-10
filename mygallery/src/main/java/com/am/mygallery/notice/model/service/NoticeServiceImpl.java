package com.am.mygallery.notice.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.am.mygallery.common.Paging;
import com.am.mygallery.common.SearchDate;
import com.am.mygallery.notice.model.dao.NoticeDao;
import com.am.mygallery.notice.model.vo.Notice;
import com.am.mygallery.common.SearchPaging;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Override
	public ArrayList<Notice> selectAll() {  
		return noticeDao.selectList();
	}

	@Override
	public Notice selectNotice(int notice_no) {	   
		return noticeDao.selectOne(notice_no);
	}

	@Override
	public int insertNotice(Notice notice) {  
		return noticeDao.insertNotice(notice);
	}

	@Override
	public int updateNotice(Notice notice) {   
		return noticeDao.updateNotice(notice);
	}

	@Override
	public int deleteNotice(int notice_no) {   
		return noticeDao.delectNotice(notice_no);
	}

	@Override
	public ArrayList<Notice> selectSearchTitle(SearchPaging searchpaging) {
		return noticeDao.selectSearchTitle(searchpaging);
	}

	@Override
	public ArrayList<Notice> selectSearchDate(SearchPaging searchpaging) {
		return noticeDao.selectSearchDate(searchpaging);
	}

	@Override
	public int updateAddReadcount(int notice_no) {
		return noticeDao.updateAddReadcount(notice_no);
	}

	@Override
	public int selectListCount() {
		return noticeDao.selectListCount();
	}

	@Override
	public ArrayList<Notice> selectList(Paging page) {
		return noticeDao.selectList(page);
	}

	@Override
	public int selectSearchTListCount(String keyword) {
		return noticeDao.selectSearchTListCount(keyword);
	}

	@Override
	public int selectSearchDListCount(SearchDate date) {
		return noticeDao.selectSearchWListCount(date);
	}

}
