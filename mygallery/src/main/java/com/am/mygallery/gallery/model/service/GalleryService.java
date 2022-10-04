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
	ArrayList<Gallery> selectImgList(String userid);
	ArrayList<Sticker>selectStickerList(String userid);
	
	int deleteGallery(int inum);
	
	
	
}
