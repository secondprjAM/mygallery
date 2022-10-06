package com.am.mygallery.gallery.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.am.mygallery.common.Paging;
import com.am.mygallery.gallery.model.dao.GalleryDao;
import com.am.mygallery.gallery.model.vo.Gallery;
import com.am.mygallery.sticker.Sticker;

@Service("galleryService")
public class GalleryServiceImpl implements GalleryService {
	
	@Autowired
	private GalleryDao galleryDao;
	
	
	@Override
	public int faceImageUpload(Gallery gallery) {
		return galleryDao.insertFaceImageName(gallery);
	}

	@Override
	public int stickerImageUpload(Sticker sticker) {
		return galleryDao.insertStickerName(sticker);
	}

	@Override
	public Gallery imageModify(Gallery gallery) {
		return null;
	}

	@Override
	public List<Object> faceImageDelete(Gallery gallery) {
		return galleryDao.selectFaceImageName1(gallery);
	}

	@Override
	public int stickerImageDelete(int snum) {
		return galleryDao.deleteStk(snum);
	}

	@Override
	public Gallery moveMainPage(Gallery gallery) {
		return null;
	}

	@Override
	public ArrayList<Gallery> selectImgList(String userid) {
		return galleryDao.selectImgList(userid);
	}


	@Override
	public int deleteGallery(int inum) {
		return galleryDao.deleteImg(inum);
	}

	@Override
	public ArrayList<Sticker> selectStickerList(String userid) {
		return galleryDao.selectStickerList(userid);
	}

//	@Override
//	public int selectListCount() {
//		// TODO Auto-generated method stub
//		return galleryDao.selectListCount();
//	}
//
//	@Override
//	public ArrayList<Gallery> selectList(Paging page) {
//		return galleryDao.selectList(page);
//	}



	

}
