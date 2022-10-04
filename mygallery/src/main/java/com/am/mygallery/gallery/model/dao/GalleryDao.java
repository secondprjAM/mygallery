package com.am.mygallery.gallery.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.am.mygallery.gallery.model.vo.Gallery;
import com.am.mygallery.sticker.Sticker;

@Repository("galleryDao")
public class GalleryDao {
	
		@Autowired
		private SqlSessionTemplate session;
		
		public Gallery selectFaceImageName(Gallery gallery) {
			return gallery;
		}
		
		public Gallery selectStickerName(Gallery gallery) {
			return gallery;
			
		}
		
		public int insertFaceImageName(Gallery gallery) {
			return session.insert("galleryMapper.insertGallery", gallery);
		}

		public int insertStickerName(Sticker sticker) {
			return session.insert("galleryMapper.insertSticker", sticker);
		}
		
		public List<Object> selectFaceImageName1(Gallery gallery) {
			return session.selectList("galleryMapper.selectGallery", gallery);
		}
		
		public int deleteImg(int inum) {
			return session.delete("galleryMapper.deleteImg", inum);
		}

		public ArrayList<Gallery> selectImgList(String userid) {
			List<Gallery> list = session.selectList("galleryMapper.selectImgAll", userid);
			return (ArrayList<Gallery>)list;
		}

		public ArrayList<Sticker> selectStickerList(String userid) {
			List<Sticker> list = session.selectList("galleryMapper.selectStickerAll", userid);
			return (ArrayList<Sticker>)list;
		}
		
}
