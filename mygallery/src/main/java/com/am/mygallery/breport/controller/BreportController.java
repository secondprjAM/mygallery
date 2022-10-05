package com.am.mygallery.breport.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.am.mygallery.breport.model.vo.Breport;
import com.am.mygallery.breport.service.BreportService;
import com.am.mygallery.common.Paging;


@Controller
public class BreportController {
	private static final Logger logger = LoggerFactory.getLogger(BreportController.class);
	
	@Autowired
	private BreportService breportService;
	
	//게시글 페이지 단위로 목록보기 요청 처리용
		@RequestMapping("blist.do")
		public ModelAndView boardListMethod(
				@RequestParam(name="page", required=false) String page,
				ModelAndView mv) {
			
			int currentPage = 1;
			if(page != null) {
				currentPage = Integer.parseInt(page);
			}
			
			//한 페이지에 게시글 10개씩 출력되게 하는 경우
			//페이징 계산 처리 -- 별도의 클래스로 작성해도 됨 ---------------
			//별도의 클래스의 메소드에서 Paging 을 리턴하면 됨
			int limit = 10;  //한 페이지에 출력할 목록 갯수
			//전체 페이지 갯수 계산을 위해 총 목록 갯수 조회해 옴
			int listCount = breportService.selectListCount();
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
			Paging paging = new Paging(startRow, endRow);
			
			//페이징 계산 처리 끝 ---------------------------------------
			
			ArrayList<Breport> list = breportService.selectList(paging);
			
			if(list != null && list.size() > 0) {
				mv.addObject("list", list);
				mv.addObject("listCount", listCount);
				mv.addObject("maxPage", maxPage);
				mv.addObject("currentPage", currentPage);
				mv.addObject("startPage", startPage);
				mv.addObject("endPage", endPage);
				mv.addObject("limit", limit);
				
				mv.setViewName("breport/breportListView");
			}else {
				mv.addObject("message", 
						currentPage + " 페이지 목록 조회 실패.");
				mv.setViewName("common/error");
			}
			
			return mv;
		}
		
		//게시글 상세보기 처리용
		@RequestMapping("bdetail.do")
		public ModelAndView boardDetailMethod(ModelAndView mv, 
				@RequestParam("b_no") int b_no,
				@RequestParam(name="page", required=false) String page) {
			int currentPage = 1;
			if(page != null) {
				currentPage = Integer.parseInt(page);
			}
			
			//조회수 1증가 처리
			breportService.updateAddReadcount(b_no);
			
			//해당 게시글 조회
			Breport breport = breportService.selectBreport(b_no);
			
			if(breport != null) {
				mv.addObject("breport", breport);
				mv.addObject("currentPage", currentPage);
				mv.setViewName("breport/breportDetailView");
			}else {
				mv.addObject("message", 
						b_no + "번 게시글 조회 실패");
				mv.setViewName("common/error");
			}
			
			return mv;
		}
		
		//게시글 첨부파일 다운로드 처리용
		@RequestMapping("bfdown.do")
		public ModelAndView fileDownMethod(ModelAndView mv, 
				HttpServletRequest request, 
				@RequestParam("ofile") String b_upfile,
				@RequestParam("rfile") String b_refile) {
			//공지사항 첨부파일 저장 폴더 경로 지정
			String savePath = request.getSession()
					.getServletContext().getRealPath(
							"resources/breport_upfile");
			
			//저장 폴더에서 읽을 파일에 대한 파일 객체 생성함		
			File brefile = new File(savePath + "\\" + b_refile);
			//파일다운시 내보낼 파일 객체 생성
			File bupfile = new File(b_upfile);
			
			mv.setViewName("filedown"); //등록된 파일다운로드 처리용 뷰클래스의 id명
			mv.addObject("b_refile", b_refile);
			mv.addObject("b_upfile", b_upfile);
			
			return mv;
		}
		
		//댓글달기 페이지로 이동
		@RequestMapping("breplyform.do")
		public String moveReplyForm(Model model, 
				@RequestParam("b_no") int origin_num,
				@RequestParam("page") int currentPage) {
			
			model.addAttribute("b_no", origin_num);
			model.addAttribute("currentPage", currentPage);
			
			return "breport/breportReplyForm";
		}
		
		//댓글 등록 처리용
		@RequestMapping(value="breply.do", method=RequestMethod.POST)
		public String replyInsertMethod(Breport reply, 
				@RequestParam("page") int page, Model model) {
			//해당 댓글에 대한 원글 조회
			Breport origin = breportService.selectBreport(
					reply.getB_ref());
			
			//현재 등록할 댓글의 레벨을 설정
			reply.setB_lev(origin.getB_lev() + 1);
			
			//대댓글(댓글의 댓글)일때는 board_reply_ref(참조하는 댓글번호) 값 지정
			if(reply.getB_lev() == 3) {
				//참조 원글 번호
				reply.setB_ref(origin.getB_ref());
				//참조 댓글 번호S
				reply.setB_reply_ref(origin.getB_reply_ref());
			}
			
			//댓글과 대댓글은 최근 등록글을 board_reply_seq 를 1로 지정함
			reply.setB_reply_seq(1);
			//기존의 댓글과 대댓글의 순번을 모두 1증가 처리함
			breportService.updateReplySeq(reply);
						
			if(breportService.insertReply(reply) > 0) {
				return "redirect:blist.do?page=" + page;
			}else {
				model.addAttribute("message", 
					reply.getB_ref() + "번 글에 대한 댓글 등록 실패");
				return "common/error";
			}
			
		}
		
		//게시 원글 쓰기 페이지로 이동 처리용
		@RequestMapping("bwform.do")
		public String moveBoardWriteForm() {
			return "breport/breportWriteForm";
		}
		
		//게시 원글 등록 처리용 : 파일 첨부(업로드) 기능 있음
		@RequestMapping(value="binsert.do", method=RequestMethod.POST)
		public String boardInsertMethod(Breport breport, Model model, 
				HttpServletRequest request, 
				@RequestParam(name="upfile", required=false) MultipartFile mfile) {
			logger.info("binsert.do : " + mfile);
			
			//업로드된 파일 저장 폴더 지정
			String savePath = request.getSession()
					.getServletContext().getRealPath(
							"resources/breport_upfile");
			
			//첨부파일이 있을 때만 업로드된 파일을 지정된 폴더로 옮기기
			if(!mfile.isEmpty()) {
				//전송온 파일이름 추출함
				String fileName = mfile.getOriginalFilename();
				
				//다른 공지글의 첨부파일과
				//파일명이 중복되어서 오버라이팅되는 것을 막기 위해
				//파일명을 변경해서 폴더에 저장하는 방식을 사용할 수 있음
				//변경 파일명 : 년월일시분초.확장자
				if(fileName != null && fileName.length() > 0) {
					//바꿀 파일명에 대한 문자열 만들기
					//공지글 등록 요청시점의 날짜시간정보를 이용함
					SimpleDateFormat sdf = 
							new SimpleDateFormat("yyyyMMddHHmmss");
					//변경할 파일이름 만들기
					String renameFileName = sdf.format(
							new java.sql.Date(System.currentTimeMillis()));
					//원본 파일의 확장자를 추출해서, 변경 파일명에 붙여줌
					renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
					
					//파일 객체 만들기
					File originFile = new File(savePath + "\\" + fileName);
					File renameFile = new File(savePath + "\\" + renameFileName);
					
					//업로드된 파일 저장시키고, 바로 이름바꾸기 실행함
					try {
						mfile.transferTo(renameFile);
					} catch (Exception e) {					
						e.printStackTrace();
						model.addAttribute("message", "전송파일 저장 실패!");
						return "common/error";
					} 
					
					//board 객체에 첨부파일명 기록 저장하기
					breport.setB_upfile(fileName);
					breport.setB_refile(renameFileName);
				}
				
			}  //첨부파일이 있을 때만
			
			if(breportService.insertOriginBreport(breport) > 0) {
				return "redirect:blist.do";
			}else {
				model.addAttribute("message", "새 게시 원글 등록 실패!");
				return "common/error";
			}
		}
		
		@RequestMapping("bdel.do")
		public String breportDeleteMethod(Breport breport,
				HttpServletRequest request, Model model) {
			
			if(breportService.deleteBreport(breport) > 0) {
				//글삭제가 성공하면, 저장폴더에 첨부파일도 삭제 처리
				if(breport.getB_refile() != null) {
					new File(request.getSession()
							.getServletContext()
							.getRealPath("resources/board_upfile")
							+ "\\" + breport.getB_refile()).delete();
				}
				
				return "redirect:blist.do?page=1";
			}else {
				model.addAttribute("message", 
						breport.getB_no() + "번 글 삭제 실패");
				return "common/error";
			}
		}
		
		@RequestMapping("bupview.do")
		public String moveBoardUpdateView(
				@RequestParam("b_no") int b_no,
				@RequestParam("page") int currentPage, 
				Model model) {
			//수정페이지로 보낼 breport 객체 정보 조회함
			Breport breport = breportService.selectBreport(b_no);
			if(breport != null) {
				model.addAttribute("breport", breport);
				model.addAttribute("page", currentPage);
				return "breport/breportUpdateForm";
			}else {
				model.addAttribute("message", 
						b_no + "번 글 수정페이지로 이동 실패");
				return "common/error";
			}
		}
		
		//게시 원글 수정 요청 처리용
		@RequestMapping(value="boriginup.do", method=RequestMethod.POST)
		public String boardUpdateMethod(
				Breport breport, Model model, 
				@RequestParam("page") int page,
				@RequestParam(name="delFlag", required=false) String delFlag,
				@RequestParam(name="upfile", required=false) MultipartFile mfile,
				HttpServletRequest request) {
			
			//게시 원글 첨부파일 저장 폴더 경로 지정
			String savePath = request.getSession()
					.getServletContext().getRealPath(
							"resources/board_upfiles");
			
			//첨부파일 수정 처리된 경우 --------------------------------
			//1. 원래 첨부파일이 있는데 삭제를 선택한 경우
			if(breport.getB_upfile() != null 
					&& delFlag != null && delFlag.equals("yes")) {
				//저장 폴더에서 파일을 삭제함
				new File(savePath + "\\" + breport.getB_refile()).delete();
				//board 의 파일정보도 제거함
				breport.setB_upfile(null);
				breport.setB_refile(null);
			}
			
			//2. 새로운 첨부파일이 있을 때 : 게시글 첨부파일은 1개만 가능한 경우
			if(!mfile.isEmpty()) {
				//저장 폴더의 이전 파일은 삭제함
				if(breport.getB_upfile() != null) {
					//저장 폴더에서 파일을 삭제함
					new File(savePath + "\\" + breport.getB_refile()).delete();
					//board 의 파일정보도 제거함
					breport.setB_upfile(null);
					breport.setB_refile(null);
				}
				
				//이전 첨부파일이 없을 때 --------------------------
				//전송온 파일이름 추출함
				String fileName = mfile.getOriginalFilename();
				
				//다른 공지글의 첨부파일과
				//파일명이 중복되어서 오버라이팅되는 것을 막기 위해
				//파일명을 변경해서 폴더에 저장하는 방식을 사용할 수 있음
				//변경 파일명 : 년월일시분초.확장자
				if(fileName != null && fileName.length() > 0) {
					//바꿀 파일명에 대한 문자열 만들기
					//공지글 등록 요청시점의 날짜시간정보를 이용함
					SimpleDateFormat sdf = 
							new SimpleDateFormat("yyyyMMddHHmmss");
					//변경할 파일이름 만들기
					String renameFileName = sdf.format(
							new java.sql.Date(System.currentTimeMillis()));
					//원본 파일의 확장자를 추출해서, 변경 파일명에 붙여줌
					renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
					
					//파일 객체 만들기
					File originFile = new File(savePath + "\\" + fileName);
					File renameFile = new File(savePath + "\\" + renameFileName);
					
					//업로드된 파일 저장시키고, 바로 이름바꾸기 실행함
					try {
						mfile.transferTo(renameFile);
					} catch (Exception e) {					
						e.printStackTrace();
						model.addAttribute("message", "전송파일 저장 실패!");
						return "common/error";
					} 
					
					//board 객체에 첨부파일명 기록 저장하기
					breport.setB_upfile(fileName);
					breport.setB_refile(renameFileName);
				}  //이름바꾸기해서 저장 처리
				
			}  //새로운 첨부파일이 있을 때만
			
			//-------------------------------------------------------------
			
			if(breportService.updateOrigin(breport) > 0) {
				//원글 수정 성공시 상세보기 페이지를 내보낸다면
				model.addAttribute("page", page);
				model.addAttribute("b_no", breport.getB_no());
				return "redirect:bdetail.do";
			}else {
				model.addAttribute("message", 
						breport.getB_no() + "번 게시 원글 수정 실패!");
				return "common/error";
			}
		}
		
		//댓글, 대댓글 수정 처리용
		@RequestMapping(value="breplyup.do", method=RequestMethod.POST)
		public String replyUpdateMethod(Breport reply, 
				@RequestParam("page") int page, Model model) {
			if(breportService.updateReply(reply) > 0) {
				//댓글, 대댓글 수정 성공시 다시 상세페이지가 보여지게 한다면
				model.addAttribute("b_no", reply.getB_no());
				model.addAttribute("page", page);
				return "redirect:bdetail.do";
			}else {
				model.addAttribute("message", 
						reply.getB_no() + "번 글 수정 실패");
				return "common/error";
			}
		}
		

}
