package com.am.mygallery.notice.model.service;

import java.util.ArrayList;

import com.am.mygallery.notice.model.vo.Notice;
import com.am.mygallery.common.Paging;
import com.am.mygallery.common.SearchDate;

public interface NoticeService {
	ArrayList<Notice> selectAll();
	Notice selectNotice(int notice_no);
	int insertNotice(Notice notice);
	int updateNotice(Notice notice);
	int deleteNotice(int notice_no);
	int updateAddReadcount(int notice_no);
	ArrayList<Notice> selectSearchTitle(String keyword);
	ArrayList<Notice> selectSearchWriter(String keyword);
	ArrayList<Notice> selectSearchDate(SearchDate date);
	int selectListCount();
	ArrayList<Notice> selectList(Paging page);
	
	
}
