package com.am.mygallery.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller()
public class PythonCode {
	private static final Logger logger = LoggerFactory.getLogger(PythonCode.class);

	@RequestMapping("python.do")
	@ResponseBody
	public void pythonOpen(HttpServletRequest request) throws IOException, InterruptedException {

		ProcessBuilder processBuilder = new ProcessBuilder("python", "C:\\AIPROJECT\\myGallery.py",
				"C:\\AIPROJECT\\data\\sample\\face_photo\\img-10.jpg", // 1 = 얼굴사진
				"C:\\AIPROJECT\\data\\sample\\pig_nose.png", // 2 = 코 스티커
				"C:\\AIPROJECT\\data\\sample\\pig_right.png", // 3 = 오른쪽 귀
				"C:\\AIPROJECT\\data\\sample\\pig_left.png"); // 4 = 윈쪽 귀

//		String[] face = request.getParameterValues("processBuilder");
//		String nose = request.getParameter(null);
//		String right = request.getParameter(null);
//		String left = request.getParameter(null);

		processBuilder.redirectErrorStream(true);

		Process process = processBuilder.start();
		int exitVal = process.waitFor();

		BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream())); // 서브 프로세스가 출력하는 내용을 받기
																									// 위해
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
