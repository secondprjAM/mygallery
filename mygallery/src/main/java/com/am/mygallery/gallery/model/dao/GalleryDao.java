package com.am.mygallery.gallery.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.am.mygallery.gallery.model.vo.Gallery;

@Repository("galleryDao")
public class GalleryDao {
	// MyBatis mapper file 의 query문을 dao가 실행함.
		// root-context.xml 생성된 객체를 연결하여 사용함.
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

		public int insertStickerName(Gallery gallery) {
			return session.insert("galleryMapper.insertSticker", gallery);
		}
		
		public List<Object> selectFaceImageName1(Gallery gallery) {
			return session.selectList("galleryMapper.selectGallery", gallery);
		}
		
		public int deleteImg(int inum) {
			return session.delete("galleryMapper.deleteImg", inum);
		}

		public ArrayList<Gallery> selectList() {
			List<Gallery> list = session.selectList("galleryMapper.selectAll");
			return (ArrayList<Gallery>)list;
		}
		
}
