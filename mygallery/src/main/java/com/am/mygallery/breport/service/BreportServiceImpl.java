package com.am.mygallery.breport.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.am.mygallery.breport.model.dao.BreportDao;
import com.am.mygallery.breport.model.vo.Breport;
import com.am.mygallery.common.Paging;
import com.am.mygallery.common.SearchDate;
import com.am.mygallery.common.SearchPaging;

@Service("breportService")
public class BreportServiceImpl implements BreportService{

	@Autowired
	private BreportDao breportDao;

	@Override
	public int selectListCount() {
		return breportDao.selectListCount();
	}

	@Override
	public ArrayList<Breport> selectList(Paging page) {
		return breportDao.selectList(page);
	}

	@Override
	public Breport selectBreport(int b_no) {
		return breportDao.selectBreport(b_no);
	}

	@Override
	public int updateAddReadcount(int b_no) {
		return breportDao.updateAddReadcount(b_no);
	}

	@Override
	public int insertOriginBreport(Breport breport) {
		return breportDao.insertOriginBreport(breport);
	}

	@Override
	public int insertReply(Breport reply) {
		return breportDao.insertReply(reply);
	}

	@Override
	public int updateReplySeq(Breport reply) {
		return breportDao.updateReplySeq(reply);
	}

	@Override
	public int updateOrigin(Breport breport) {
		return breportDao.updateOrigin(breport);
	}

	@Override
	public int updateReply(Breport reply) {
		return breportDao.updateReply(reply);
	}

	@Override
	public int deleteBreport(Breport breport) {
		return breportDao.deleteBreport(breport);
	}

	@Override
	public ArrayList<Breport> selectSearchTitle(SearchPaging searchpaging) {
		return breportDao.selectSearchTitle(searchpaging);
	}

	@Override
	public ArrayList<Breport> selectSearchDate(SearchPaging searchpaging) {
		return breportDao.selectSearchDate(searchpaging);
	}

	@Override
	public int selectSearchTListCount(String keyword) {
		return breportDao.selectSearchTListCount(keyword);
	}

	@Override
	public int selectSearchDListCount(SearchDate date) {
		return breportDao.selectSearchDListCount(date);
	}

	@Override
	public Breport selectReply(int b_no) {
		return breportDao.selectReply(b_no);
	}
	
}
