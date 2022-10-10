package com.am.mygallery.notice.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Notice implements Serializable {
	private static final long serialVersionUID = 4334893905730615136L;
	
	private int notice_no;
	private String userid;
	private String notice_title;
	private Date notice_date;
	private String notice_content;
	private int notice_readcount;
	private String notice_upfile;
	private String notice_refile;
	private int importance;
	
	public Notice() {}

	public Notice(int notice_no, String userid, String notice_title, Date notice_date, String notice_content,
			int notice_readcount, String notice_upfile, String notice_refile, int importance) {
		super();
		this.notice_no = notice_no;
		this.userid = userid;
		this.notice_title = notice_title;
		this.notice_date = notice_date;
		this.notice_content = notice_content;
		this.notice_readcount = notice_readcount;
		this.notice_upfile = notice_upfile;
		this.notice_refile = notice_refile;
		this.importance = importance;
	}

	public int getNotice_no() {
		return notice_no;
	}

	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getNotice_title() {
		return notice_title;
	}

	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}

	public Date getNotice_date() {
		return notice_date;
	}

	public void setNotice_date(Date notice_date) {
		this.notice_date = notice_date;
	}

	public String getNotice_content() {
		return notice_content;
	}

	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}

	public int getNotice_readcount() {
		return notice_readcount;
	}

	public void setNotice_readcount(int notice_readcount) {
		this.notice_readcount = notice_readcount;
	}

	public String getNotice_upfile() {
		return notice_upfile;
	}

	public void setNotice_upfile(String notice_upfile) {
		this.notice_upfile = notice_upfile;
	}

	public String getNotice_refile() {
		return notice_refile;
	}

	public void setNotice_refile(String notice_refile) {
		this.notice_refile = notice_refile;
	}

	public int getImportance() {
		return importance;
	}

	public void setImportance(int importance) {
		this.importance = importance;
	}

	@Override
	public String toString() {
		return "Notice [notice_no=" + notice_no + ", userid=" + userid + ", notice_title=" + notice_title
				+ ", notice_date=" + notice_date + ", notice_content=" + notice_content + ", notice_readcount="
				+ notice_readcount + ", notice_upfile=" + notice_upfile + ", notice_refile=" + notice_refile
				+ ", importance=" + importance + "]";
	}
}
