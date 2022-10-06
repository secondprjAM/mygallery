package com.am.mygallery.gallery.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.am.mygallery.common.Paging;
import com.am.mygallery.gallery.model.service.GalleryService;
import com.am.mygallery.gallery.model.vo.Gallery;
import com.am.mygallery.sticker.Sticker;


@Controller
public class GalleryController {

	private static final Logger logger = LoggerFactory.getLogger(GalleryController.class);

	@Autowired
	private GalleryService galleryService;

	// 뷰 페이지 이동 처리 ======================================

	// 삭제페이지 이동 처리
//		@RequestMapping("delete.do")
//		public String deleteImageMetheod() {
//			return "gallery/deletePage";
//		}
	// ====================================================================================================================================
	// 이미지 업로드페이지 이동 처리
	@RequestMapping("imgUpload.do")
	public String moveToImageUpload() {
		return "gallery/imageUpload";
	}

	// ====================================================================================================================================
	// 스티커 업로드페이지 이동 처리
	@RequestMapping("sticketUpload.do")
	public String moveToStickerUpload() {
		return "gallery/stickerUpload";
	}

	// ====================================================================================================================================
	// 이미지 편집페이지 이동 처리
//		@RequestMapping("modify.do")
//		public String moveToModifyPage() {
//			return "gallery/modifyPage";
//		}
	// ====================================================================================================================================
	// 얼굴 이미지 저장 처리
	@RequestMapping(value = "imginsert.do", method = RequestMethod.POST)
	public String imageInsertMethod(Gallery gallery, Model model, HttpServletRequest request,
			@RequestParam(name = "upfile", required = false) MultipartFile mfile) {
		logger.info("imginsert.do : " + mfile);
		String savePath = request.getSession().getServletContext().getRealPath("resources/gallery/faceImages");

		if (!mfile.isEmpty()) {
			String fileName = mfile.getOriginalFilename();
			if (fileName != null && fileName.length() > 0) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()));
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);

				File originFile = new File(savePath + "\\" + fileName);
				File renameFile = new File(savePath + "\\" + renameFileName);
				try {
					mfile.transferTo(renameFile);
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("titleMsg", "이미지 업로드 실패");
					model.addAttribute("message", e.getMessage().toString());
					return "common/error";
				}

				gallery.setImg_ori_name(fileName);
				gallery.setImg_rename(renameFileName);
			}

		} // 첨부파일이 있을 때만

		if (galleryService.faceImageUpload(gallery) > 0) {
			model.addAttribute("userid", gallery.getUserid());
			return "redirect:gallery.do";
		} else {
			model.addAttribute("message", "사진 업로드 실패!");
			return "common/error";
		}
	}

	// ====================================================================================================================================

	// 스티커 업로드 처리
	@RequestMapping(value = "stkinsert.do", method = RequestMethod.POST)
	public String stickerInsertMethod(Sticker sticker, Model model, HttpServletRequest request,
			@RequestParam(name = "upfile", required = false) MultipartFile mfile) {

		String savePath = request.getSession().getServletContext().getRealPath("resources/gallery/stickers");
		if (!mfile.isEmpty()) {

			String fileName = mfile.getOriginalFilename();
			if (fileName != null && fileName.length() > 0) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis()));
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);

				File originFile = new File(savePath + "\\" + fileName);
				File renameFile = new File(savePath + "\\" + renameFileName);

				// 업로드된 파일 저장시키고, 바로 이름바꾸기 실행함
				try {
					mfile.transferTo(renameFile);
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message", "전송파일 저장 실패!");
					return "common/error";
				}
				sticker.setS_ori_name(fileName);
				sticker.setS_rename(renameFileName);
			}
		}
		if (galleryService.stickerImageUpload(sticker) > 0) {
			model.addAttribute("userid", sticker.getUserid());
			return "redirect:gallery.do";
		} else {
			model.addAttribute("message", "스티커 업로드 실패!");
			return "common/error";
		}
	}

	// ====================================================================================

	// 이미지 전체목록 처리
	@RequestMapping("gallery.do")
	public String galleryListViewMethod(@RequestParam("userid") String userid, Model model) {
		ArrayList<Gallery> list = galleryService.selectImgList(userid);
		ArrayList<Sticker> slist = galleryService.selectStickerList(userid);
		model.addAttribute("list", list);
		model.addAttribute("slist", slist);
		return "gallery/galleryPage";
	}

	// 이미지 삭제하기 위한 전체 목록 조회 처리
	@RequestMapping("delete.do")
	public String galleryDeleteMethod(@RequestParam("userid") String userid, Model model) {
		ArrayList<Gallery> list = galleryService.selectImgList(userid);

		if (list.size() > 0) {
			model.addAttribute("list", list);
			return "gallery/deletePage";
		} else {
			model.addAttribute("message", "이미지 정보가 존재하지 않습니다.");
			return "common/error";
		}
	}

	// 스티커 삭제하기 위한 전체 목록 조회 처리
	@RequestMapping("sdelete.do")
	public String stickerDeleteMethod(@RequestParam("userid") String userid, Model model) {
		ArrayList<Sticker> slist = galleryService.selectStickerList(userid);

		if (slist.size() > 0) {
			model.addAttribute("slist", slist);
			return "gallery/stickerDelPage";
		} else {
			model.addAttribute("message", "스티커 정보가 존재하지 않습니다.");
			return "common/error";
		}
	}

	@RequestMapping("gdel.do")
	public String galleryDeleteMethod(@RequestParam("inum") int img_num, @RequestParam("userid") String userid,
			@RequestParam(name = "rfile", required = false) String renameFileName, Model model,
			HttpServletRequest request) {
		if (galleryService.deleteGallery(img_num) > 0) {
			if (renameFileName != null) {
				new File(request.getSession().getServletContext().getRealPath("resources/gallery/faceImages") + "\\"
						+ renameFileName).delete();
			}
			model.addAttribute("userid", userid);
			return "redirect:gallery.do";
		} else {
			model.addAttribute("message", img_num + "번 사진 삭제 실패!");
			return "common/error";
		}
	}

	@RequestMapping("sdel.do")
	public String stickerDeleteMethod(@RequestParam("snum") int snum, @RequestParam("userid") String userid,
			@RequestParam(name = "rfile", required = false) String renameFileName, Model model,
			HttpServletRequest request) {
		if (galleryService.stickerImageDelete(snum) > 0) {
			if (renameFileName != null) {
				new File(request.getSession().getServletContext().getRealPath("resources/gallery/stickers") + "\\"
						+ renameFileName).delete();
			}
			model.addAttribute("userid", userid);
			return "redirect:gallery.do";
		} else {
			model.addAttribute("message", snum + "번 사진 삭제 실패!");
			return "common/error";
		}
	}

	@RequestMapping("modify.do")
	public String galleryModifyMethod(@RequestParam("userid") String userid, Model model) {
		ArrayList<Gallery> list = galleryService.selectImgList(userid);
		ArrayList<Sticker> slist = galleryService.selectStickerList(userid);

		if (list.size() > 0 && slist.size() > 0) {
			model.addAttribute("list", list);
			model.addAttribute("slist", slist);
			return "gallery/modifyPage";
		} else {
			model.addAttribute("message", "이미지 정보가 존재하지 않습니다.");
			return "common/error";
		}
	}
	
	/*
	 * // 갤러리페이지 피이징ㅐ 처리
	 * 
	 * @RequestMapping("glist.do") public ModelAndView galleryListMethod(
	 * ModelAndView mv,
	 * 
	 * @RequestParam(name="page", required=false) String page) { int currentPage =
	 * 1;
	 * 
	 * if(page != null) { currentPage = Integer.parseInt(page); } // 기본적으로 한 페이지에
	 * 게시글 10개씩 출력하기 // 페이징 계산 처리 === 별도의 클래스로 작성해도 됨.
	 * ================================== // 별도의 클래스의 메소드에서 Paging 을 리턴하면 됨. int
	 * limit = 10; // 한 페이지에 출력할 목록 갯수 //전체 페이지 갯수 계산을 위해 총 목록 갯수 조회해 옴 int
	 * listCount = galleryService.selectListCount(); // 페이지 수 계산 // 주의 : 목록이 11개이면
	 * 페이지 수는 2페이지가 됨. // 나머지 목록 1개도 1페이지가 필요함. int maxPage =
	 * (int)((double)listCount / limit + 0.9); // 현재 페이지가 포함된 페이지 그룹의 시작값 지정 // => 뷰
	 * 아래쪽에 표시할 페이지 수를 10개로 하는 경우 int startPage = (currentPage / 10) * 10 + 1; // 현재
	 * 페이지가 포함된 페이지 그룹의 끝값 지정 int endPage = startPage + 10 - 1;
	 * 
	 * if(maxPage < endPage) { endPage = maxPage; }
	 * 
	 * // 쿼리문에 전달할 현재 페이지에 적용할 목록의 시작행과 끝행 계산 int startRow = (currentPage - 1) *
	 * limit + 1; int endRow = startRow + limit - 1; Paging paging = new
	 * Paging(startRow, endRow);
	 * 
	 * 
	 * // 페이징 계산 처리 끝========================================================
	 * ArrayList<Gallery> list = galleryService.selectList(paging); if(list != null
	 * && list.size() > 0) { mv.addObject("list", list); mv.addObject("listCount",
	 * listCount); mv.addObject("maxPage", maxPage); mv.addObject("currentPage",
	 * currentPage); mv.addObject("startPage", startPage); mv.addObject("endPage",
	 * endPage); mv.addObject("limit", limit);
	 * 
	 * mv.setViewName("gallery/galleryPage"); }else { mv.addObject("message",
	 * currentPage + "페이지 목록 조회 실패!"); mv.setViewName("common/error"); } return mv;
	 * 
	 * } // method end
	 */	
	
	

} // class end
