package com.am.mygallery.breport.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Breport implements Serializable{
	private static final long serialVersionUID = 6169733365204864755L;
	
	private int b_no;
	private String userid;
	private String b_title;
	private Date b_date;
	private String b_content;
	private int b_readcount;
	private String b_upfile;
	private String b_refile;
	private int b_ref;
	private int b_reply_ref;
	private int b_lev;
	private int b_reply_seq;
	
	public Breport() {}

	public Breport(int b_no, String userid, String b_title, Date b_date, String b_content, int b_readcount,
			String b_upfile, String b_refile, int b_ref, int b_reply_ref, int b_lev, int b_reply_seq) {
		super();
		this.b_no = b_no;
		this.userid = userid;
		this.b_title = b_title;
		this.b_date = b_date;
		this.b_content = b_content;
		this.b_readcount = b_readcount;
		this.b_upfile = b_upfile;
		this.b_refile = b_refile;
		this.b_ref = b_ref;
		this.b_reply_ref = b_reply_ref;
		this.b_lev = b_lev;
		this.b_reply_seq = b_reply_seq;
	}

	public int getB_no() {
		return b_no;
	}

	public void setB_no(int b_no) {
		this.b_no = b_no;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getB_title() {
		return b_title;
	}

	public void setB_title(String b_title) {
		this.b_title = b_title;
	}

	public Date getB_date() {
		return b_date;
	}

	public void setB_date(Date b_date) {
		this.b_date = b_date;
	}

	public String getB_content() {
		return b_content;
	}

	public void setB_content(String b_content) {
		this.b_content = b_content;
	}

	public int getB_readcount() {
		return b_readcount;
	}

	public void setB_readcount(int b_readcount) {
		this.b_readcount = b_readcount;
	}

	public String getB_upfile() {
		return b_upfile;
	}

	public void setB_upfile(String b_upfile) {
		this.b_upfile = b_upfile;
	}

	public String getB_refile() {
		return b_refile;
	}

	public void setB_refile(String b_refile) {
		this.b_refile = b_refile;
	}

	public int getB_ref() {
		return b_ref;
	}

	public void setB_ref(int b_ref) {
		this.b_ref = b_ref;
	}

	public int getB_reply_ref() {
		return b_reply_ref;
	}

	public void setB_reply_ref(int b_reply_ref) {
		this.b_reply_ref = b_reply_ref;
	}

	public int getB_lev() {
		return b_lev;
	}

	public void setB_lev(int b_lev) {
		this.b_lev = b_lev;
	}

	public int getB_reply_seq() {
		return b_reply_seq;
	}

	public void setB_reply_seq(int b_reply_seq) {
		this.b_reply_seq = b_reply_seq;
	}


	@Override
	public String toString() {
		return "Breport [b_no=" + b_no + ", userid=" + userid + ", b_title=" + b_title + ", b_date=" + b_date
				+ ", b_content=" + b_content + ", b_readcount=" + b_readcount + ", b_upfile=" + b_upfile + ", b_refile="
				+ b_refile + ", b_ref=" + b_ref + ", b_reply_ref=" + b_reply_ref + ", b_reply_lev=" 				+ ", b_lev=" + b_lev + ", b_reply_seq=" + b_reply_seq + "]";
	}

	
	
	
}
