package com.am.mygallery.gallery.model.service;

import java.util.ArrayList;
import java.util.List;

import com.am.mygallery.gallery.model.vo.Gallery;

public interface GalleryService {
	
	int faceImageUpload(Gallery gallery);
	int stickerImageUpload(Gallery gallery);
	Gallery imageModify(Gallery gallery);
	int stickerImageDelete(int snum);
	Gallery moveMainPage(Gallery gallery);
	int faceImageDelete(int inum);
	List<Object> faceImageDelete(Gallery gallery);
	ArrayList<Gallery> selectList();
	int deleteGallery(int inum);
	
	
	
}
