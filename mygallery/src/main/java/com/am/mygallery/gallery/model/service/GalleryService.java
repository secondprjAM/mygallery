package com.am.mygallery.gallery.model.service;

import java.util.ArrayList;
import java.util.List;

import com.am.mygallery.gallery.model.vo.Gallery;
import com.am.mygallery.sticker.Sticker;

public interface GalleryService {
	
	int faceImageUpload(Gallery gallery);
	int stickerImageUpload(Sticker sticker);
	Gallery imageModify(Gallery gallery);
	int stickerImageDelete(int snum);
	Gallery moveMainPage(Gallery gallery);
	int faceImageDelete(int inum);
	List<Object> faceImageDelete(Gallery gallery);
	
	
	// 이미지 삭제하기 위한 목록조회
	ArrayList<Gallery> selectImgList(String userid);
	
	int deleteGallery(int inum);
	
	// sticker 삭제하기 위한 목록조회
	ArrayList<Sticker> selectStickerList(String userid);
	
}
