package com.am.mygallery.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

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
import org.springframework.web.servlet.ModelAndView;

import com.am.mygallery.common.Paging;
import com.am.mygallery.common.SearchPaging;
import com.am.mygallery.member.model.service.MailSendService;
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
	private MailSendService mailService;
	
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
	
	// 아이디 찾기 페이지 이동
	@RequestMapping("findIDPage.do")
	public String findIDPage() {
		return "member/findIDPage";
	}
	
	// 비밀번호 찾기 페이지 이동
	@RequestMapping("pw_find.do")
	public String pw_find() {
		return "member/pw_find";
	}
	
	// 회원정보 변경을 위한 본인 인증 페이지로 이동
	@RequestMapping("moveup.do")
	public String checkselfPage(
			@RequestParam("userid") String userid, 
			Model model) {
		Member member = memberService.selectMember(userid);
		if(member != null) {
			model.addAttribute("member", member);
			return "member/checkself";
		}else {
			model.addAttribute("message", userid + " : 회원 조회 실패!");
			return "common/error";
		}
	}
	
	// 본인 인증 후 회원 정보 수정 페이지로 이동
	@RequestMapping("updatePage.do")
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
		String tempPWD = (String) loginSession.getAttribute("tempPWD");
		if(loginMember != null && tempPWD != null) {
			if(userpassword.equals(tempPWD)) {
				model.addAttribute("member", loginMember);
				return "member/pw_new";
			}
		}
		
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
	
	// 이메일 인증
	@GetMapping("mailCheck.do")
	@ResponseBody
	public String mailCheck(String email) {
		System.out.println("이메일 인증 요청이 들어옴!");
		System.out.println("이메일 인증 이메일 : " + email);
		return mailService.joinEmail(email);
		
	}
	
	// 비밀번호 이메일 인증
	@RequestMapping("PWDmailCheck.do")
	public String pwdmailCheck(@RequestParam("useremail") String email, HttpSession session, Model model) {
		System.out.println("이메일 인증 요청이 들어옴!");
		System.out.println("이메일 인증 이메일 : " + email);
		String tempPWD = mailService.pwdEmail(email);
		logger.info("tempPWD", tempPWD);
		if(tempPWD != null) {
			session.setAttribute("tempPWD", tempPWD);
			model.addAttribute("message", "임시 비밀번호로 사용 가능한 이메일을 전송하였습니다 이메일을 확인해주세요.");
			return "member/loginPage";
		}else {
			model.addAttribute("message", 
					"비밀번호 찾기 메일 전송 실패.");
			return "common/error";
		}
	}
	//리턴 타입으로 String, ModelAndView 를 사용할 수 있음
	@RequestMapping("myinfo.do")
	//public String myinfoMethod() {  return "폴더명/뷰파일명"; }
	public ModelAndView myinfoMethod(
			@RequestParam("userid") String userid, 
			ModelAndView mv) {
		//서비스로 전송온 값 전달해서, 실행 결과 받기
		Member member = memberService.selectMember(userid);
		logger.info("멤버 : " + member);
		if(member != null) {
			mv.addObject("member", member);
			mv.setViewName("member/myinfoPage");
		}else {
			mv.addObject("message", userid + " : 회원 정보 조회 실패!");
			mv.setViewName("common/error");
		}
		
		return mv;		
	}
	
	//아이디 찾기 
	@RequestMapping(value = "find_id.do", method = RequestMethod.POST)
	@ResponseBody
	public String find_id(Member member) {
		String result = memberService.find_id(member);
	return result;
	}

	//회원 정보 수정용 : 수정 성공시 myinfoPage.jsp 로 이동함
	@RequestMapping(value="mupdate.do", method=RequestMethod.POST)
	public String memberUpdateMethod(Member member, Model model, 
			@RequestParam("origin_userpassword") String originUserpassword, HttpServletRequest request) {
		logger.info("mupdate.do : " + member);
		logger.info("origin_userpassword : " + originUserpassword);
		
		//새로운 암호가 전송이 왔다면, 패스워드 암호화 처리함
		String userpwd = member.getUserpassword().trim();
		if(userpwd != null && userpwd.length() > 0) {
			//기존 암호와 다른 값이면
			if(!this.bcryptPasswordEncoder.matches(userpwd, originUserpassword)) {
				//member 에 새로운 패스워드를 암호화해서 기록함
				member.setUserpassword(this.bcryptPasswordEncoder.encode(userpwd));
			}
		}else {
			//새로운 패스워드 값이 없다면, member 에 원래 패스워드 기록
			member.setUserpassword(originUserpassword);
		}
		
		logger.info("after : " + member);
		
		if(memberService.updateMember(member) > 0) {
			//수정이 성공했다면, 컨트롤러의 메소드를 직접 호출할 수도 있음
			//즉, 컨트롤러 안에서 다른 컨트롤러를 실행할 수도 있음
			//내정보보기 페이지에 수정된 회원정보를 다시 조회해서 내보냄
			//쿼리스트링 : ?이름=값&이름=값
			HttpSession session = request.getSession(false);
			session.invalidate(); //세션 객체를 없앰
			System.out.println("세션 삭제됨");
			return "redirect:main.do";
		}else {
			model.addAttribute("message", 
					member.getUserid() + " : 회원 정보 수정 실패!");
			return "common/error";
		}
		
	}
	
	//회원 탈퇴 처리용 : 회원 정보 삭제함
	//삭제되면 자동 로그아웃함
	@RequestMapping("mdel.do")
	public String memberDeleteMethod(
			@RequestParam("userid") String userid, Model model) {
		logger.info(userid);
		if(memberService.deleteMember(userid) > 0) {
			return "redirect:logout.do";
		}else {
			model.addAttribute("message", userid + " : 회원 삭제 실패!");
			return "common/error";
		}
	}
	
	// 임시 로그인 후 새로운 비밀번호 설정
	@RequestMapping(value="resetpwd.do", method=RequestMethod.POST)
	public String resetpwdMethod(Member member, Model model, HttpServletRequest request){
		logger.info("resetpwd.do : " + member);
		
		//새로운 암호가 전송이 왔다면, 패스워드 암호화 처리함
		String userpwd = member.getUserpassword().trim();
		if(userpwd != null && userpwd.length() > 0) {
			//member 에 새로운 패스워드를 암호화해서 기록함
			member.setUserpassword(this.bcryptPasswordEncoder.encode(userpwd));
			logger.info("userpwd : " + userpwd);
		}
		
		if(memberService.pwUpdate(member) > 0) {
			//수정이 성공했다면, 컨트롤러의 메소드를 직접 호출할 수도 있음
			//즉, 컨트롤러 안에서 다른 컨트롤러를 실행할 수도 있음
			//내정보보기 페이지에 수정된 회원정보를 다시 조회해서 내보냄
			//쿼리스트링 : ?이름=값&이름=값
			HttpSession session = request.getSession(false);
			session.invalidate(); //세션 객체를 없앰
			return "redirect:main.do";
		}else {
			model.addAttribute("message", 
					member.getUserid() + " : 회원 정보 수정 실패!");
			return "common/error";
		}
		
	}
	
	// 비밀번호 변경 전 본인 확인
	@RequestMapping(value="checkself.do", method=RequestMethod.POST)
	public String checkself(Member member, @RequestParam("userid") String userid, Model model) {
		System.out.println(member.getUserid());
		Member loginMember = memberService.selectMember(userid);
		logger.info("member.pass " + member.getUserpassword());
		logger.info("loginmember.pass " + loginMember.getUserpassword());
		
		String viewName = null;
		if(loginMember != null && 
				this.bcryptPasswordEncoder.matches(member.getUserpassword(), loginMember.getUserpassword())) {
			//로그인 상태 관리 방법 (상태 관리 매커니즘) : 기본 세션 사용
			//logger.info("sessionID : " + loginSession.getId());
			
			//로그인 성공시 내보낼 뷰파일명 지정
			viewName = "redirect:updatePage.do?userid=" + userid;
		}else {  //로그인 실패
			model.addAttribute("message", 
					"본인 인증 실패 : 암호를 확인하세요.");
			viewName = "common/error";
		}
		
		return viewName;
	}
	
	//Admin Info 보기
	@RequestMapping("admininfo.do")
	//public String myinfoMethod() {  return "폴더명/뷰파일명"; }
	public ModelAndView admininfoMethod(
			@RequestParam("userid") String userid, 
			ModelAndView mv) {
		//서비스로 전송온 값 전달해서, 실행 결과 받기
		Member member = memberService.selectMember(userid);
		if(member != null) {
			mv.addObject("member", member);
			mv.setViewName("member/adminInfoPage");
		}else {
			mv.addObject("message", userid + " : 관리자 정보 조회 실패!");
			mv.setViewName("common/error");
		}
		
		return mv;		
	}
	
	//게시글 페이지 단위로 목록보기 요청 처리용
	@RequestMapping("mlist.do")
	public ModelAndView memberListMethod(
			@RequestParam(name="page", required=false) String page,
			ModelAndView mv) {
	
	int currentPage = 1;
	if(page != null) {
		currentPage = Integer.parseInt(page);
	}
	
	//한 페이지에 게시글 10개씩 출력되게 하는 경우
	//페이징 계산 처리 -- 별도의 클래스로 작성해도 됨 ---------------
	//별도의 클래스의 메소드에서 Paging 을 리턴하면 됨
	int limit = 5;  //한 페이지에 출력할 목록 갯수
	//전체 페이지 갯수 계산을 위해 총 목록 갯수 조회해 옴
	int listCount = memberService.selectListCount();
	//페이지 수 계산
	//주의 : 목록이 11개이면 페이지 수는 2페이지가 됨
	// 나머지 목록 1개도 1페이지가 필요함
	int maxPage = (int)((double)listCount / limit + 0.9);
	//현재 페이지가 포함된 페이지 그룹의 시작값 지정
	// => 뷰 아래쪽에 표시할 페이지 수를 10개로 하는 경우
	int startPage = (currentPage / 5) * 5 + 1;
	//현재 페이지가 포함된 페이지 그룹의 끝값 지정
	int endPage = startPage + 5 - 1;
	
	if(maxPage < endPage) {
		endPage = maxPage;
	}
	
	//쿼리문에 전달할 현재 페이지에 적용할 목록의 시작행과 끝행 계산
	int startRow = (currentPage - 1) * limit + 1;
	int endRow = startRow + limit - 1;
	Paging paging = new Paging(startRow, endRow);
	
	//페이징 계산 처리 끝 ---------------------------------------
	
	ArrayList<Member> list = memberService.selectList2(paging);
	
	if(list != null && list.size() > 0) {
		mv.addObject("list", list);
		mv.addObject("listCount", listCount);
		mv.addObject("maxPage", maxPage);
		mv.addObject("currentPage", currentPage);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("limit", limit);
		
		mv.setViewName("member/memberListView");
	}else {
		mv.addObject("message", 
				currentPage + " 페이지 목록 조회 실패.");
		mv.setViewName("common/error");
	}
	
	return mv;
}



//로그인 제한/가능 변경 처리용
@RequestMapping("loginok.do")
public String changeLoginOKMethod(Member member, Model model) {
	logger.info("loginok.do : " + member.getUserid() + ", " + member.getUserloginok());
	
	if(memberService.updateLoginOK(member) > 0) {
		return "redirect:mlist.do";
	}else {
		return "member/memberListView";
	}
}

//회원 검색 처리용 
@RequestMapping(value="msearch.do", method= {RequestMethod.POST, RequestMethod.GET})
public String memberSearchMethod(
      HttpServletRequest request, Model model) {
   String action = request.getParameter("action");
   String keyword = request.getParameter("keyword");
   String page = request.getParameter("page");
   
      
   //서비스 메소드 리턴값 받을 리스트 준비
   ArrayList<Member> list = null;
   
   switch(action) {
   
      case "userid":    list = memberService.selectSearchUserid(keyword);
            break;
   
      case "userloginok": list = memberService.selectSearchLoginOK(keyword);
            break;
            
      case "0" : list = memberService.selectList2(null);
            break;
      
   }
   
   int currentPage = 1;
   if(page != null) {
      currentPage = Integer.parseInt(page);
   }
   
   //한 페이지에 게시글 10개씩 출력되게 하는 경우
   //페이징 계산 처리 -- 별도의 클래스로 작성해도 됨 ---------------
   //별도의 클래스의 메소드에서 Paging 을 리턴하면 됨
   int limit = 10;  //한 페이지에 출력할 목록 갯수
   //전체 검색 키워드 갯수 계산을 위해 총 목록 갯수 조회해 옴
   int listCount = list.size();
   //페이지 수 계산
   //주의 : 목록이 11개이면 페이지 수는 2페이지가 됨
   // 나머지 목록 1개도 1페이지가 필요함
   int maxPage = (int)((double)listCount / limit + 0.9);
   //현재 페이지가 포함된 페이지 그룹의 시작값 지정
   // => 뷰 아래쪽에 표시할 페이지 수를 10개로 하는 경우
   int startPage = (currentPage / 10) * 10 + 1;
   //현재 페이지가 포함된 페이지 그룹의 끝값 지정
   int endPage = startPage + 10 - 1;
   
   if(maxPage < endPage) {
      endPage = maxPage;
   }
   
   //쿼리문에 전달할 현재 페이지에 적용할 목록의 시작행과 끝행 계산
   int startRow = (currentPage - 1) * limit + 1;
   int endRow = startRow + limit - 1;
   
   //페이징 계산 처리 끝 ---------------------------------------
   SearchPaging searchpaging = new SearchPaging(keyword, startRow, endRow);
   
   switch(action) {
   
   case "userid":    list = memberService.selectSearchUseridP(searchpaging);
         break;

   case "userloginok": list = memberService.selectSearchLoginOKP(searchpaging);
         break;
         
   case "0" : list = memberService.selectList2(null);
         break;
   
}

   
   if(list.size() > 0) {
      model.addAttribute("list", list);
      model.addAttribute("action", action);
      model.addAttribute("keyword", keyword);
      
      model.addAttribute("listCount", listCount);
      model.addAttribute("maxPage", maxPage);
      model.addAttribute("currentPage", currentPage);
      model.addAttribute("startPage", startPage);
      model.addAttribute("endPage", endPage);
      model.addAttribute("limit", limit);
      
      return "member/memberListView";
   }else {
      return "member/memberListView";
   }
}

} //controller 끝