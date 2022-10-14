package com.am.mygallery.member.model.service;

import java.util.ArrayList;

import com.am.mygallery.common.Paging;
import com.am.mygallery.common.SearchPaging;
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
	int updateLoginOK(Member member); //로그인제한유무설정
	int selectListCount(); //총 회원수 조회용
	ArrayList<Member> selectList(); // 회원정보 상세조회용
	ArrayList<Member> selectList2(Paging page); // 페이징 처리된 회원정보 상세조회용 (관리자제외)
	ArrayList<Member> selectSearchUserid(String keyword); // 회원아이디로 검색
	ArrayList<Member> selectSearchLoginOK(String keyword); // 로그인제한유무로 검색

	ArrayList<Member> selectSearchUseridP(SearchPaging searchpaging);

	ArrayList<Member> selectSearchLoginOKP(SearchPaging searchpaging);

}
