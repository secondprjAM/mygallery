package com.am.mygallery.gallery.model.vo;

import java.sql.Date;

public class Gallery implements java.io.Serializable {

	private static final long serialVersionUID = 3042047769618408673L;

		private int img_num;
		private String userid;
		private String img_ori_name;
		private String img_rename;
		private Date image_date;
		
		public Gallery() {
			super();
		}
		public Gallery(int img_num, String userid, String img_ori_name, String img_rename, Date image_date) {
			super();
			this.img_num = img_num;
			this.userid = userid;
			this.img_ori_name = img_ori_name;
			this.img_rename = img_rename;
			this.image_date = image_date;
		}
		public int getImg_num() {
			return img_num;
		}
		public void setImg_num(int img_num) {
			this.img_num = img_num;
		}
		public String getUserid() {
			return userid;
		}
		public void setUserid(String userid) {
			this.userid = userid;
		}
		public String getImg_ori_name() {
			return img_ori_name;
		}
		public void setImg_ori_name(String img_ori_name) {
			this.img_ori_name = img_ori_name;
		}
		public String getImg_rename() {
			return img_rename;
		}
		public void setImg_rename(String img_rename) {
			this.img_rename = img_rename;
		}
		public Date getImage_date() {
			return image_date;
		}
		public void setImage_date(Date image_date) {
			this.image_date = image_date;
		}
		@Override
		public String toString() {
			return "Gallery [img_num=" + img_num + ", userid=" + userid + ", img_ori_name=" + img_ori_name
					+ ", img_rename=" + img_rename + ", image_date=" + image_date + "]";
		}
		
}
