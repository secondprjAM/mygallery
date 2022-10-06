package com.am.mygallery.gallery.model.service;

import java.util.ArrayList;
import java.util.List;

import com.am.mygallery.common.Paging;
import com.am.mygallery.gallery.model.vo.Gallery;
import com.am.mygallery.sticker.Sticker;


public interface GalleryService {
	
	int faceImageUpload(Gallery gallery);
	
	int stickerImageUpload(Sticker sticker);
	
	Gallery imageModify(Gallery gallery);
	
	// 스티커 삭제
	int stickerImageDelete(int snum);
	
	Gallery moveMainPage(Gallery gallery);
	
	List<Object> faceImageDelete(Gallery gallery);
	
	// 이미지 삭제하기 위한 목록조회
	ArrayList<Gallery> selectImgList(String userid);
	
	// 이미지 삭제
	int deleteGallery(int inum);
	
	// sticker 삭제하기 위한 목록조회
	ArrayList<Sticker> selectStickerList(String userid);
	
	
	//페이징 처리
//	int selectListCount();
	
	// 페이징처리
//	ArrayList<Gallery> selectList(Paging page);
	
	
}
