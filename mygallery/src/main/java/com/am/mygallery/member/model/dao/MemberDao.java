package com.am.mygallery.member.model.dao;

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

}
