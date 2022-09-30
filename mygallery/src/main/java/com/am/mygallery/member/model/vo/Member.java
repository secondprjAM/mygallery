package com.am.mygallery.member.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Member implements Serializable {
	private static final long serialVersionUID = 5161221897126526995L;


	//스프링에서 데이터베이스 테이블 컬럼명과 필드(멤버변수)명을 일치시키면 마이바티스 매퍼의 resultMap 이 자동 작동 실행됨
	private String userid;
	private String userpassword;
	private String username;
	private String usergender;
	private String useremail;
	private String userloginok;
	private String useradmin;
	
	public Member() {}
 
	public Member(String userid, String userpassword, String username, String usergender, String useremail,
			String userloginok, String useradmin) {
		super();
		this.userid = userid;
		this.userpassword = userpassword;
		this.username = username;
		this.usergender = usergender;
		this.useremail = useremail;
		this.userloginok = userloginok;
		this.useradmin = useradmin;
	}
	
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUserpassword() {
		return userpassword;
	}

	public void setUserpassword(String userpassword) {
		this.userpassword = userpassword;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUsergender() {
		return usergender;
	}

	public void setUsergender(String usergender) {
		this.usergender = usergender;
	}

	public String getUseremail() {
		return useremail;
	}

	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}

	public String getUserloginok() {
		return userloginok;
	}

	public void setUserloginok(String userloginok) {
		this.userloginok = userloginok;
	}

	public String getUseradmin() {
		return useradmin;
	}

	public void setUseradmin(String useradmin) {
		this.useradmin = useradmin;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Member [userid=" + userid + ", userpassword=" + userpassword + ", username=" + username + ", usergender="
				+ usergender + ", useremail=" + useremail + ", userloginok=" + userloginok + ", useradmin=" + useradmin
				+ "]";
	}



}
