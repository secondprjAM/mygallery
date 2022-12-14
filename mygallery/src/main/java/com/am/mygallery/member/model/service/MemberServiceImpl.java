package com.am.mygallery.member.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.am.mygallery.common.Paging;
import com.am.mygallery.common.SearchPaging;
import com.am.mygallery.member.model.dao.MemberDao;
import com.am.mygallery.member.model.vo.Member;



@Service("memberService") //xml 자동 등록됨 (id 지정함)
public class MemberServiceImpl implements MemberService {
	@Autowired  //자동 의존성 주입 처리됨 (자동 객체 생성됨)
	private MemberDao memberDao; 

	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}
	 
	@Override
	public Member selectMember(String userid) {
		return memberDao.selectMember(userid);
	}

	@Override
	public int selectDupCheckId(String userid) {
		return memberDao.selectDupCheckId(userid);
	}
	
	@Override
	public Member selectLogin(Member member) {
		return memberDao.selectLogin(member);
	}
	
	// 아이디 찾기
	@Override
	public String find_id(Member member) {
		String result = "";
		try {
		 result= memberDao.find_id(member);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result ;
	}
	@Override
	public int selectListCount() {
		return memberDao.selectListCount();
	}
	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

	@Override
	public int deleteMember(String userid) {
		return memberDao.deleteMember(userid);
	}
	
	@Override
	public int pwUpdate(Member member) {
		return memberDao.pwUpdate(member);
	}

	@Override
	public ArrayList<Member> selectList() {
		return memberDao.selectList();
	}

	@Override
	public ArrayList<Member> selectSearchUserid(String keyword) {
		return memberDao.selectSearchUserid(keyword);
	}

	@Override
	public ArrayList<Member> selectSearchLoginOK(String keyword) {
		return memberDao.selectSearchLoginOK(keyword);
	}

	@Override
	public int updateLoginOK(Member member) {
		return memberDao.updateLoginOK(member);
	}

	@Override
	public ArrayList<Member> selectList2(Paging page) {
		return memberDao.selectList2(page);
	}

	@Override
	public ArrayList<Member> selectSearchUseridP(SearchPaging searchpaging) {
		return memberDao.selectSearchUseridP(searchpaging);
	}

	@Override
	public ArrayList<Member> selectSearchLoginOKP(SearchPaging searchpaging) {
		return memberDao.selectSearchLoginOKP(searchpaging);
	}	
}
