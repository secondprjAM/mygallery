package com.am.mygallery.member.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.am.mygallery.member.model.vo.Member;
 
@Repository("memberDao")  //xml 자동 등록됨 (id지정함)
public class MemberDao {
	//마이바티스 매퍼파일의 쿼리문 실행
	//root-context.xml 에 생성된 객체를 연결하여 사용함
	@Autowired
	private SqlSessionTemplate session;

	public int insertMember(Member member) {
		int result= session.insert("memberMapper.insertMember", member);
		return result;
	}
	
	public Member selectMember(String userid) {
		return session.selectOne("memberMapper.selectMember", userid);
	}

	public int selectDupCheckId(String userid) {
		return session.selectOne("memberMapper.selectCheckId", userid);
	}

	public Member selectLogin(Member member) {
		return session.selectOne("memberMapper.selectLogin", member);
	}

	public ArrayList<Member> selectList() {
		List<Member> list = session.selectList("memberMapper.selectList");
		return (ArrayList<Member>)list;
	}

	
	// 검색 처리용 ---------------------------------
	public ArrayList<Member> selectSearchUserid(String keyword){
		List<Member> list = session.selectList(
				"memberMapper.selectSearchUserid", keyword);
		return (ArrayList<Member>)list;
	}
	
	public ArrayList<Member> selectSearchLoginOK(String keyword){
		List<Member> list = session.selectList(
				"memberMapper.selectSearchLoginOK", keyword);
		return (ArrayList<Member>)list;
	}

	public int selectListCount() {
		return session.selectOne("memberMapper.getListCount");
	}

	public int updateLoginOK(Member member) {
		return session.update("memberMapper.updateLoginOK", member);
	}

	public ArrayList<Member> selectList2() {
		List<Member> list = session.selectList("memberMapper.selectList2");
		return (ArrayList<Member>)list;
	}

}
