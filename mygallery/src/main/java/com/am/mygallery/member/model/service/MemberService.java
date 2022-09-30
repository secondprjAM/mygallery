package com.am.mygallery.member.model.service;

import com.am.mygallery.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member member);

	Member selectMember(String userid);

	int selectDupCheckId(String userid);

	Member selectLogin(Member member);
	
	



}
