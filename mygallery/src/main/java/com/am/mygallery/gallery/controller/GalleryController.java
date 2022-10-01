package com.am.mygallery.gallery.controller;

import java.io.File;
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

import com.am.mygallery.gallery.model.service.GalleryService;
import com.am.mygallery.gallery.model.vo.Gallery;

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

		// 업로드된 파일 저장 폴더 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/gallery/faceImages");

		// 첨부파일이 있을 때만 업로드된 파일을 지정된 폴더로 옮기기
		if (!mfile.isEmpty()) {

			// 전송온 파일이름 추출함
			String fileName = mfile.getOriginalFilename();
			if (fileName != null && fileName.length() > 0) {

				String renameFileName = gallery.getMb_imgname();
				// 원본 파일의 확장자를 추출해서, 변경 파일명에 붙여줌
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);

				// 파일 객체 만들기
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

				// notice 객체에 첨부파일명 기록 저장하기
				gallery.setMb_imgname(renameFileName);
				// gallery.setMb_imgname(renameFileName);
			}

		} // 첨부파일이 있을 때만

		if (galleryService.faceImageUpload(gallery) > 0) {
			return "redirect:gallery.do";
		} else {
			model.addAttribute("message", "사진 업로드 실패!");
			return "common/error";
		}
	}

	// ====================================================================================================================================

	// 스티커 업로드 처리
	@RequestMapping(value = "stkinsert.do", method = RequestMethod.POST)
	public String stickerInsertMethod(Gallery gallery, Model model, HttpServletRequest request,
			@RequestParam(name = "upfile", required = false) MultipartFile mfile) {
		logger.info("imginsert.do : " + mfile);

		// 업로드된 파일 저장 폴더 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/gallery/stickers");

		// 첨부파일이 있을 때만 업로드된 파일을 지정된 폴더로 옮기기
		if (!mfile.isEmpty()) {

			// 전송온 파일이름 추출함
			String fileName = mfile.getOriginalFilename();
			if (fileName != null && fileName.length() > 0) {
				String renameFileName = gallery.getMb_sname();
				// 원본 파일의 확장자를 추출해서, 변경 파일명에 붙여줌
				renameFileName += "." + fileName.substring(fileName.lastIndexOf(".") + 1);
				// 파일 객체 만들기
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
				// notice 객체에 첨부파일명 기록 저장하기
				gallery.setMb_sname(renameFileName);
			}

		}
		if (galleryService.stickerImageUpload(gallery) > 0) {
			return "redirect:gallery.do";
		} else {
			model.addAttribute("message", "스티커 업로드 실패!");
			return "common/error";
		}
	}

	// ====================================================================================

	// 이미지 전체목록 처리
	@RequestMapping("gallery.do")
	public String galleryListViewMethod(Model model) {
		ArrayList<Gallery> list = galleryService.selectList();

		if (list.size() > 0) {
			model.addAttribute("list", list);
			return "gallery/galleryPage";
		} else {
			model.addAttribute("message", "이미지 정보가 존재하지 않습니다.");
			return "common/error";
		}
	}

	// 이미지 삭제하기 위한 전체 목록 조회 처리
	@RequestMapping("delete.do")
	public String galleryDeleteMethod(Model model) {
		ArrayList<Gallery> list = galleryService.selectList();

		if (list.size() > 0) {
			model.addAttribute("list", list);
			return "gallery/deletePage";
		} else {
			model.addAttribute("message", "이미지 정보가 존재하지 않습니다.");
			return "common/error";
		}
	}

	@RequestMapping("gdel.do")
	public String galleryDeleteMethod(@RequestParam("inum") int inum,
			@RequestParam(name = "rfile", required = false) String renameFileName, Model model,
			HttpServletRequest request) {
		System.out.println("전달 받은 inum : " + inum);
		if (galleryService.deleteGallery(inum) > 0) {
			// 첨부된 파일이 있는 공지일때는 저장 폴더에 있는
			// 첨부파일도 삭제함
			if (renameFileName != null) {
				new File(request.getSession().getServletContext().getRealPath("resources/gallery/faceImages") + "\\"
						+ renameFileName).delete();
			}

			return "redirect:gallery.do";
		} else {
			model.addAttribute("message", inum + "번 사진 삭제 실패!");
			return "common/error";
		}
	}

	@RequestMapping("modify.do")
	public String galleryModifyMethod(Model model) {
		ArrayList<Gallery> list = galleryService.selectList();

		if (list.size() > 0) {
			model.addAttribute("list", list);
			return "gallery/modifyPage";
		} else {
			model.addAttribute("message", "이미지 정보가 존재하지 않습니다.");
			return "common/error";
		}
	}
	
	
	
	
	

} // class end
