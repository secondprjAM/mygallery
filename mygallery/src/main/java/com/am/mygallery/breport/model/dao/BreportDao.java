package com.am.mygallery.breport.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.am.mygallery.breport.model.vo.Breport;
import com.am.mygallery.common.Paging;
import com.am.mygallery.common.SearchDate;
import com.am.mygallery.common.SearchPaging;


@Repository("breportDao")
public class BreportDao {
	
	@Autowired
	private SqlSessionTemplate session;

	public int selectListCount() {
		return session.selectOne("breportMapper.getListCount");
	}

	public ArrayList<Breport> selectList(Paging page) {
		List<Breport> list = session.selectList("breportMapper.selectList", page);
		return (ArrayList<Breport>)list;
	}

	public Breport selectBreport(int b_no) {
		return session.selectOne("breportMapper.selectBreport", b_no);
	}

	public int updateAddReadcount(int b_no) {
		return session.update("breportMapper.addReadCount", b_no);
	}

	public int insertOriginBreport(Breport breport) {
		return session.insert("breportMapper.insertOrigin", breport);
	}

	public int insertReply(Breport reply) {
		int result = 0;
		
		if(reply.getB_lev() == 2) { //댓글이면
			result = session.insert("breportMapper.insertReply1", reply);
		}
		if(reply.getB_lev() == 3) { //대댓글이면
			result = session.insert("breportMapper.insertReply2", reply);
		}
		
		return result;
	}

	public int updateReplySeq(Breport reply) {
		int result = 0;
		
		if(reply.getB_lev() == 2) { //댓글이면
			result = session.update("breportMapper.updateReplySeq1", reply);
		}
		if(reply.getB_lev() == 3) { //대댓글이면
			result = session.update("breportMapper.updateReplySeq2", reply);
		}
		
		return result;
	}

	public int updateOrigin(Breport breport) {
		return session.update("breportMapper.updateOrigin", breport);
	}

	public int updateReply(Breport reply) {
		return session.update("breportMapper.updateReply", reply);
	}

	public int deleteBreport(Breport breport) {
		return session.delete("breportMapper.deleteBreport", breport);
	}

		public ArrayList<Breport> selectSearchTitle(SearchPaging searchpaging) {
		List<Breport> list = session.selectList("breportMapper.searchTitle", searchpaging);
		return (ArrayList<Breport>)list;
	}

	public ArrayList<Breport> selectSearchDate(SearchPaging searchpaging) {
		List<Breport> list = session.selectList("breportMapper.searchDate", searchpaging);
		return (ArrayList<Breport>)list;
	}

	public int selectSearchTListCount(String keyword) {
		return session.selectOne("breportMapper.getSearchTListCount", keyword);
	}

	public int selectSearchDListCount(SearchDate date) {
		return session.selectOne("breportMapper.getSearchDListCount", date);
	}

	public Breport selectReply(int b_no) {
		return session.selectOne("breportMapper.selectReply", b_no);
	}

	

	
	
}
