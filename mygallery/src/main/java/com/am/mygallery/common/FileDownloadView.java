package com.am.mygallery.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class FileDownloadView extends AbstractView{
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		File renameFile = (File)model.get("renameFile");
		File downFile = (File)model.get("originFile");
		
		String fileName = downFile.getName();
		
		response.setContentType("text/plain; charset=utf-8");
		response.addHeader("Content-Disposition", "attachment; filename=\""+ new String(fileName.getBytes("UTF-8"),"ISO-8859-1") + "\"");
		response.setContentLength((int)renameFile.length());
		
		OutputStream out = response.getOutputStream();
		FileInputStream fin = null;
		fin = new FileInputStream(renameFile);
		FileCopyUtils.copy(fin, out);
		fin.close();
	}
	
	
	
}
