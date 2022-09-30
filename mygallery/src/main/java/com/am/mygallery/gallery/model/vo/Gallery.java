package com.am.mygallery.gallery.model.vo;

import java.sql.Date;

public class Gallery implements java.io.Serializable {
	// 상수필드
	private static final long serialVersionUID = -6094331181718026794L;
	
	// 필드
	private int user_snum;
	private int snum;
	private String userid;
	private String mb_imgname;
	private String mb_sname;
	private Date mb_image_date;
	private String category;
	public Gallery() {
		super();
	}
	public Gallery(int user_snum, int snum, String userid, String mb_imgname, String mb_sname, Date mb_image_date,
			String category) {
		super();
		this.user_snum = user_snum;
		this.snum = snum;
		this.userid = userid;
		this.mb_imgname = mb_imgname;
		this.mb_sname = mb_sname;
		this.mb_image_date = mb_image_date;
		this.category = category;
	}
	public int getUser_snum() {
		return user_snum;
	}
	public void setUser_snum(int user_snum) {
		this.user_snum = user_snum;
	}
	public int getSnum() {
		return snum;
	}
	public void setSnum(int snum) {
		this.snum = snum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getMb_imgname() {
		return mb_imgname;
	}
	public void setMb_imgname(String mb_imgname) {
		this.mb_imgname = mb_imgname;
	}
	public String getMb_sname() {
		return mb_sname;
	}
	public void setMb_sname(String mb_sname) {
		this.mb_sname = mb_sname;
	}
	public Date getMb_image_date() {
		return mb_image_date;
	}
	public void setMb_image_date(Date mb_image_date) {
		this.mb_image_date = mb_image_date;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "Gallery [user_snum=" + user_snum + ", snum=" + snum + ", userid=" + userid + ", mb_imgname="
				+ mb_imgname + ", mb_sname=" + mb_sname + ", mb_image_date=" + mb_image_date + ", category=" + category
				+ "]";
	}
	
	
	
	
	
	
	

	
	
} // class end
