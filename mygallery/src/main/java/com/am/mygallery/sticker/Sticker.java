package com.am.mygallery.sticker;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("Sticker")
public class Sticker implements java.io.Serializable{
	private static final long serialVersionUID = -3526317164064222509L;
	
	private int snum;
	private String userid;
	private String s_ori_name;
	private String s_rename;
	private Date s_date;
	private String category;
	
	public Sticker() {
		super();
	}
	public Sticker(int snum, String userid, String s_ori_name, String s_rename, Date s_date, String category) {
		super();
		this.snum = snum;
		this.userid = userid;
		this.s_ori_name = s_ori_name;
		this.s_rename = s_rename;
		this.s_date = s_date;
		this.category = category;
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
	public String getS_ori_name() {
		return s_ori_name;
	}
	public void setS_ori_name(String s_ori_name) {
		this.s_ori_name = s_ori_name;
	}
	public String getS_rename() {
		return s_rename;
	}
	public void setS_rename(String s_rename) {
		this.s_rename = s_rename;
	}
	public Date getS_date() {
		return s_date;
	}
	public void setS_date(Date s_date) {
		this.s_date = s_date;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	@Override
	public String toString() {
		return "Sticker [snum=" + snum + ", userid=" + userid + ", s_ori_name=" + s_ori_name + ", s_rename=" + s_rename
				+ ", s_date=" + s_date + ", category=" + category + "]";
	}
	
	
}
