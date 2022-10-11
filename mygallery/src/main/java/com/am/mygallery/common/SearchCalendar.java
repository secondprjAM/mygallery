package com.am.mygallery.common;

import java.io.Serializable;

import org.springframework.stereotype.Component;

@Component("searchcalendar")
public class SearchCalendar implements Serializable{
	private static final long serialVersionUID = -3481419422893239964L;
	
	private String dateFormat;
	private String id;
	private String endDate="";
	
	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public SearchCalendar() {
		super();
	}
	
	public SearchCalendar(String dateFormat, String id, String endDate) {
		super();
		this.dateFormat = dateFormat;
		this.id = id;
		this.endDate = endDate;
	}

	public String getDateFormat() {
		return dateFormat;
	}

	public void setDateFormat(String dateFormat) {
		this.dateFormat = dateFormat;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "SearchCalendar [dateFormat=" + dateFormat + ", id=" + id + ", endDate=" + endDate + "]";
	}
}
