package com.am.mygallery.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.am.mygallery.gallery.model.service.GalleryService;
import com.am.mygallery.gallery.model.vo.Gallery;

@Controller()
public class PythonCode {
	private static final Logger logger = LoggerFactory.getLogger(PythonCode.class);
	private static final String String = null;

	@Autowired
	private GalleryService galleryService;
	@Autowired
	private SqlSessionTemplate session;

	@RequestMapping(value = "python.do", method = RequestMethod.POST)
	@ResponseBody
	public void pythonOpen(Model model, Gallery gallery, HttpServletRequest request)
			throws IOException, InterruptedException {

		String facePath = "C:\\framework_workspace\\AM\\mygallery\\mygallery\\src\\main\\webapp\\resources\\gallery\\faceImages\\";
		String stickerPath = "C:\\framework_workspace\\AM\\mygallery\\mygallery\\src\\main\\webapp\\resources\\gallery\\stickers\\";

		/* String faceName = img_rename; */
		/* System.out.println(faceName); */
		/* String noseName = "fox_nose.png"; */
		/* String rightName = "fox_right.png"; */
		/* String leftName = "fox_left.png"; */

		String img_rename = request.getParameter("img_rename");
		String s_rename = request.getParameter("s_rename");
		String rightName = request.getParameter("rig_rename");
		String leftName = request.getParameter("lef_rename");

		System.out.println(img_rename);
		System.out.println(s_rename);
		System.out.println(rightName);
		System.out.println(leftName);
		ProcessBuilder processBuilder = new ProcessBuilder("python", "C:\\AIPROJECT\\myGallery.py",

				facePath + img_rename, // 1 = 얼굴사진
				stickerPath + s_rename, // 2 = 코 스티커
				stickerPath + rightName, // 3 = 오른쪽 귀
				stickerPath + leftName); // 4 = 윈쪽 귀

		processBuilder.redirectErrorStream(true);

		Process process = processBuilder.start();
		int exitVal = process.waitFor();

		BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream())); // 서브 프로세스가 출력하는 내용을 받기

		String line = "";
		while ((line = br.readLine()) != null) {
			System.out.println(">>>  " + line); // 표준출력에 쓴다
		}
		if (exitVal != 0) {
			// 비정상 종료
			System.out.println("서브 프로세스가 비정상 종료되었다.");
		}

	}

}
