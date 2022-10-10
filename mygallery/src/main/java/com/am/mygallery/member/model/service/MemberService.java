package com.am.mygallery.member.model.service;

import java.util.ArrayList;

import com.am.mygallery.common.Paging;
import com.am.mygallery.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member member);

	Member selectMember(String userid);

	int selectDupCheckId(String userid);
	// 회원 정보 수정(비밀번호만 변경가능)
	int updateMember(Member member);
	// 회원 탈퇴
	int deleteMember(String userid);
	// 아이디 찾기
	String find_id(Member member);
	// 비밀번호 찾기 후 비밀번호 변경
	int pwUpdate(Member member);

	//관리자 관련
	Member selectLogin(Member member);
	int updateLoginOK(Member member);
	int selectListCount();
	ArrayList<Member> selectList();
	ArrayList<Member> selectList2(Paging page);
	ArrayList<Member> selectSearchUserid(String keyword);
	ArrayList<Member> selectSearchLoginOK(String keyword);

}
