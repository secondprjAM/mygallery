package com.am.mygallery.gallery.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.am.mygallery.gallery.model.dao.GalleryDao;
import com.am.mygallery.gallery.model.vo.Gallery;

@Service("galleryService")
public class GalleryServiceImpl implements GalleryService {
	
	@Autowired
	private GalleryDao galleryDao;
	
	
	@Override
	public int faceImageUpload(Gallery gallery) {
		return galleryDao.insertFaceImageName(gallery);
	}

	@Override
	public int stickerImageUpload(Gallery gallery) {
		return galleryDao.insertStickerName(gallery);
	}

	@Override
	public Gallery imageModify(Gallery gallery) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Object> faceImageDelete(Gallery gallery) {
		return galleryDao.selectFaceImageName1(gallery);
	}

	@Override
	public int stickerImageDelete(int snum) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Gallery moveMainPage(Gallery gallery) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<Gallery> selectList() {
		return galleryDao.selectList();
	}

	@Override
	public int faceImageDelete(int inum) {
		return galleryDao.deleteImg(inum);
	}

	@Override
	public int deleteGallery(int inum) {
		// TODO Auto-generated method stub
		return galleryDao.deleteImg(inum);
	}

	

}
