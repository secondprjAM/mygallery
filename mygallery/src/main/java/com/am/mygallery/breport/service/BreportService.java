package com.am.mygallery.breport.service;

import java.util.ArrayList;

import com.am.mygallery.breport.model.vo.Breport;
import com.am.mygallery.common.Paging;
import com.am.mygallery.common.SearchDate;
import com.am.mygallery.common.SearchPaging;


public interface BreportService {
	
	int selectListCount();  //총 게시글 갯수 조회용(페이지 수 계산용)
	ArrayList<Breport> selectList(Paging paging);  //한 페이지 출력할 게시글 조회용
	Breport selectBreport(int b_no); //해당 번호에 대한 게시글 상세 조회용
	int updateAddReadcount(int b_no); //상세보기시에 조회수 1증가 처리용
	int insertOriginBreport(Breport breport); //원글 등록용
	int insertReply(Breport reply); //댓글 등록용 (대댓글 등록 포함)
	ArrayList<Breport> selectSearchTitle(SearchPaging searchpaging);
	ArrayList<Breport> selectSearchDate(SearchPaging searchpaging);
	int updateReplySeq(Breport reply); //댓글 등록시 기존 댓글 순번을 1증가 처리(최신글이 1이 되게 함)
	int updateOrigin(Breport breport);  //원글 수정용
	int updateReply(Breport reply);  //댓글 수정용
	int deleteBreport(Breport breport);  //게시글 삭제용
	
}
