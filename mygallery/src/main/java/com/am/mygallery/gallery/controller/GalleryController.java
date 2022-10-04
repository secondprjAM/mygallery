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
				SimpleDateFormat sdf = 
						new SimpleDateFormat("yyyyMMddHHmmss");
				String renameFileName = sdf.format(
						new java.sql.Date(System.currentTimeMillis()));
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
			model.addAttribute("userid",gallery.getUserid());
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
				SimpleDateFormat sdf = 
						new SimpleDateFormat("yyyyMMddHHmmss");
				String renameFileName = sdf.format(
						new java.sql.Date(System.currentTimeMillis()));
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
			model.addAttribute("userid",sticker.getUserid());
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
		model.addAttribute("slist",slist);
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

	@RequestMapping("gdel.do")
	public String galleryDeleteMethod(@RequestParam("inum") int img_num, @RequestParam("userid") String userid,
			@RequestParam(name = "rfile", required = false) String renameFileName, Model model,
			HttpServletRequest request) {
		if (galleryService.deleteGallery(img_num) > 0) {
			if (renameFileName != null) {
				new File(request.getSession().getServletContext().getRealPath("resources/gallery/faceImages") + "\\"
						+ renameFileName).delete();
			}
			model.addAttribute("userid",userid);
			return "redirect:gallery.do";
		} else {
			model.addAttribute("message", img_num + "번 사진 삭제 실패!");
			return "common/error";
		}
	}

	@RequestMapping("modify.do")
	public String galleryModifyMethod(Model model) {
		ArrayList<Gallery> list = null;//galleryService.selectImgList();

		if (list.size() > 0) {
			model.addAttribute("list", list);
			return "gallery/modifyPage";
		} else {
			model.addAttribute("message", "이미지 정보가 존재하지 않습니다.");
			return "common/error";
		}
	}
} // class end
