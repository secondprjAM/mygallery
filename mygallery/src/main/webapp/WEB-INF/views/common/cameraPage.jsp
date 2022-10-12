<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<script type="text/javascript"
	src="${pageContext.servletContext.contextPath}/resources/js/jquery-3.6.1.min.js"></script>
<!-- <link rel="stylesheet" href="https://pyscript.net/latest/pyscript.css" /> -->
<script defer src="https://pyscript.net/latest/pyscript.js"></script>

</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<br>
	<br>
	<br>
	<br>
	<center>
		<py-script> 
		import os
		os.system('../resources/python/main.exe') 
		</py-script>
		
		<center>

			<h2>CAMERA</h2>
			<img src="http://localhost:5000/stream?src=0" width="650"
				height="480" id="video"> <br>
			<div class="controller">
				<button id="snap" type="submit">이미지 촬영</button>
				<button onclick="javasctript:history.go(-1);">이전페이지</button>
				<p>이미지 촬영후 이미지위에서 마우스 오른쪽 클릭하여 이미지를 저장하십시오!</p>
			</div>
			<br>
			<canvas id="canvas" width="640" height="480"></canvas>
			<br>
			
			<!-- <button id="saveBtn">파일로 저장</button> -->
			
			<br>
		</center>

		<script type="text/javascript">
			const video = document.getElementById('video');
			const canvas = document.getElementById('canvas');
			const snap = document.getElementById('snap');
			const saveBtn = document.getElementById('saveBtn');
			const errorMsgElement = document.getElementById('snapErrorMsg');

			/* const storage = [];
			 const bitmap = storage.shift(); */
			/* storage.push(bitmap); */
			const constraints = {
			/* audio: true, */
			/* 	video: 
			 width: 640, height: 360;	 */
			}

			var context = canvas.getContext('2d');
			var imageData = canvas.toDataURL("image/png", 1.0);
			/* var link = document.createElement('a'); */
			snap.addEventListener("click", function() {
				/* var imageData = context.transferFromImageBitmap(bitmap); */
				context.drawImage(video, 0, 0, 640, 480);
				/* link.href = image;
				link.download = "MyImage";
				link.click(); */
			});

			/* console.log(image);
			 console.log(context); */

			$(function() {
				saveBtn.addEventListener('click', function() {
					var filename = prompt("저장할 파일명.png 을 입력하시오.");

					console.log("imageData : " + imageData);
					var blobBin = atob(imageData.split(',')[1]); // base64 데이터 디코딩
					var array = [];
					for (var i = 0; i < blobBin.length; i++) {
						array.push(blobBin.charCodeAt(i));
					}
					var file = new Blob([ new Uint8Array(array) ], {
						type : 'image/png'
					}); // Blob 생성
					var formdata = new FormData();
					formdata.append("file", file);
					formdata.append("filename", filename);

					$.ajax({
						type : 'post',
						url : 'saveimg.do',
						data : formdata,
						processData : false, // data 파라미터 강제 string 변환 방지!!
						contentType : false, // application/x-www-form-urlencoded; 방지!!
						success : function(data) {
							if (data === "ok") {
								alert("이미지 저장 성공");
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log("image save error : " + jqXHR + ", "
									+ textStatus + ", " + errorThrown);
						}
					}); //ajax
				}); //addEventListener
			}); //$
		</script>

		<br> <br> <br> <br>
		<hr style="clear: both;">
		<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>