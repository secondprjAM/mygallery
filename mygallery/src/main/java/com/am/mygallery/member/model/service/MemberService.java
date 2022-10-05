package com.am.mygallery.member.model.service;

import java.util.ArrayList;

import com.am.mygallery.common.Paging;
import com.am.mygallery.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member member);

	Member selectMember(String userid);

	int selectDupCheckId(String userid);

	//관리자 관련
		Member selectLogin(Member member);
		int updateLoginOK(Member member);
		int selectListCount();
		ArrayList<Member> selectList();
		ArrayList<Member> selectList2(Paging page);
		ArrayList<Member> selectSearchUserid(String keyword);
		ArrayList<Member> selectSearchLoginOK(String keyword);

}
