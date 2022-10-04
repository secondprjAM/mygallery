package com.am.mygallery.member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import com.am.mygallery.member.model.service.MemberService;
import com.am.mygallery.member.model.vo.Member;

@Controller  //xml 에 자동 등록됨
public class MemberController {
	//이 컨트롤러 안의 메소드들에 구동 상태에 대한 로그 출력용 객체 생성
	//classpath 에 log4j.xml 에 설정된 내용으로 출력 적용됨
	private static final Logger logger = 
			LoggerFactory.getLogger(MemberController.class);
	
	
	@Autowired  //자동 의존성주입(DI) (자동 객체 생성됨)
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	//뷰 페이지 이동 처리용 ----------------------------------------------
	@RequestMapping("enrollPage.do")
	public String moveEnrollPage() {
		return "member/enrollPage";
	}
	
	@RequestMapping("loginPage.do")
	public String moveLoginPage() {
		return "member/loginPage";
	}
	
	@RequestMapping("moveup.do")
	public String moveUpdatePage(
			@RequestParam("userid") String userid, 
			Model model) {
		Member member = memberService.selectMember(userid);
		if(member != null) {
			model.addAttribute("member", member);
			return "member/updatePage";
		}else {
			model.addAttribute("message", userid + " : 회원 조회 실패!");
			return "common/error";
		}
	}
	
	// ----------------------------------------------------------

	//회원 가입 처리용
	@RequestMapping(value="enroll.do", method=RequestMethod.POST)
	public String memberInsertMethod(Member member, Model model) {
		//메소드 매개변수에 vo 를 지정하면, 자동 객체 생성되면서
		//뷰페이지 form 태그 input 의 name 과 vo 의 필드명이 같으면
		//자동으로 전송온 값(parameter)이 꺼내져서 객체에 옮겨 저장됨
		//커맨드 객체(command object) 라고 함
		//logger.info("enroll.do : " + member);
		
		//패스워드 암호화 처리
		member.setUserpassword(this.bcryptPasswordEncoder.encode(
				member.getUserpassword()));
		logger.info("after encode : " + member);
		logger.info("length : " + member.getUserpassword().length());
		
		if(memberService.insertMember(member) > 0) {
			//회원 가입 성공
			return "common/main";
		}else {
			//회원 가입 실패
			model.addAttribute("message", "회원 가입 실패!");
			return "common/error";
		}
	}
	
	//===============================================
	// ajax 통신으로 처리하는 요청 메소드 -------------------------
	@RequestMapping(value="idchk.do", method=RequestMethod.POST)
	public void dupIdCheckMethod(
			@RequestParam("userid") String userid, 
			HttpServletResponse response) throws IOException {
		
		int idCount = memberService.selectDupCheckId(userid);
		
		String returnValue = null;
		if(idCount == 0) {
			returnValue = "ok";
		}else {
			returnValue = "dup";
		}
		
		//response 를 이용해서 클라이언트로 출력스트림을 만들고 값 보내기
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.append(returnValue);
		out.flush();
		out.close();
	}
	
	// 로그인 처리용 메소드 : 커맨드 객체(command object) 사용
	// 서버로 전송온 parameter 값을 저장한 객체(vo)를 command 객체라고 함
	// 작성 요령 : input name 과 vo 객체의 필드명이 같아야 함
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public String loginMethod(@RequestParam("userid") String userid, @RequestParam("userpassword") String userpassword, 
			HttpSession loginSession, SessionStatus status,
			Model model) { 
//		logger.info("login.do : " + userid + ", userpassword : " + userpassword);
		
		//암호화 처리된 패스워드 일치 조회는 select 해 온 값으로 비교함
		//전달온 회원 아이디로 먼저 회원정보 조회해 옴
		Member loginMember = memberService.selectMember(
										userid);
		
		//2. 서비스 모델로 전달하고 결과 받기
		//Member loginMember = memberService.selectLogin(member);
		
		//3. 로그인 성공 여부에 따라서 결과 처리
		//암호화된 패스워드와 전달된 글자타입 패스워드를 비교함
		//matches(글자타입패스워드, 암호화된패스워드)
		String viewName = null;
		if(loginMember != null && 
				this.bcryptPasswordEncoder.matches(
					userpassword, loginMember.getUserpassword())
				&& loginMember.getUserloginok().equals("Y")) {  //로그인 성공
			//로그인 상태 관리 방법 (상태 관리 매커니즘) : 기본 세션 사용
			//logger.info("sessionID : " + loginSession.getId());
			
			//필요할 경우 생성된 세션 객체 안에 정보를 저장할 수 있음
			//맵 구조로 저장함 : 키(String), 값(Object)
			loginSession.setAttribute("loginMember", loginMember);
			status.setComplete();  //로그인 요청 성공, 200 전송함
			
			//로그인 성공시 내보낼 뷰파일명 지정
			viewName = "common/main";
		}else {  //로그인 실패
			model.addAttribute("titleMsg","로그인 실패");
			model.addAttribute("message", 
					"로그인 실패 : 아이디나 암호 확인하세요.<br>"
					+ "또는 로그인 제한 회원인지 관리자에게 문의하세요.");
			viewName = "common/error";
		}
		
		return viewName;
	}
	
	//로그아웃 처리용
	@RequestMapping("logout.do")
	public String logoutMethod(HttpServletRequest request, 
			Model model) {
		//로그인할 때 생성된 세션객체를 찾아서 없앰
		HttpSession session = request.getSession(false);
		//request 가 가진 세션id 에 대한 세션객체가 있으면 리턴
		//없으면 null 리턴
		
		if(session != null) {
			session.invalidate(); //세션 객체를 없앰
			return "common/main";
		}else {
			model.addAttribute("message", 
					"로그인 세션이 존재하지 않습니다.");
			return "common/error";
		}
	}
	

	
}

