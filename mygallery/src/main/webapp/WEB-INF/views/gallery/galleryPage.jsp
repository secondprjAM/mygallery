<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<!-- ============================================================================================== -->
<style type="text/css">
.container h2 {
	padding-top: 10px;
	padding-bottom: 10px;
	font-weight: 300;
}

.btn, .btn-two {
	margin: 9px;
}

/* Colors for .btn and .btn-two */
.btn.blue, .btn-two.blue {
	background-color: #656565;
}

.rounded {
	border-radius: 10px;
}

/* default button style */
.btn {
	position: relative;
	border: 0;
	padding: 15px 25px;
	display: inline-block;
	text-align: center;
	color: white;
}

.btn:active {
	top: 4px;
}

/* color classes for .btn */
.btn.blue {
	box-shadow: 0px 4px #74a3b0;
}

.btn.blue:active {
	box-shadow: 0 0 #74a3b0;
	background-color: #709CA8;
}

/* Button two */
.btn-two {
	color: white;
	padding: 15px 25px;
	display: inline-block;
	border: 1px solid rgba(0, 0, 0, 0.21);
	border-bottom-color: rgba(0, 0, 0, 0.34);
	text-shadow: 0 1px 0 rgba(0, 0, 0, 0.15);
	box-shadow: 0 1px 0 rgba(255, 255, 255, 0.34) inset, 0 2px 0 -1px
		rgba(0, 0, 0, 0.13), 0 3px 0 -1px rgba(0, 0, 0, 0.08), 0 3px 13px -1px
		rgba(0, 0, 0, 0.21);
}

.btn-two:active {
	top: 1px;
	border-color: rgba(0, 0, 0, 0.34) rgba(0, 0, 0, 0.21)
		rgba(0, 0, 0, 0.21);
	box-shadow: 0 1px 0 rgba(255, 255, 255, 0.89), 0 1px rgba(0, 0, 0, 0.05)
		inset;
	position: relative;
}

* {
	margin: 0;
	paddin: 0;
	font-family: sans-serif;
}

.img-gallery {
	width: 80%;
	margin: 100px auto 50px;
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	grid-gap: 30px;
}

.img-gallery img {
	width: 200px;
	cursor: pointer;
}

.img-gallery img:hover {
	transform: scale(0.8) rotate(-15deg);
	border-radius: 20px;
	box-shadow: 0 32px 75px rgba(68, 77, 136, 0.2);
}

.full-img {
	width: 100%;
	height: 100vh;
	background: rgba(0, 0, 0, 0.9);
	position: fixed;
	top: 0;
	left: 0;
	display: none;
	align-items: center;
	justify-content: center;
	z-index: 100;
}

.full-img img {
	width: 90%;
	max-width: 500px;
}

.full-img span {
	position: absolute;
	top: 10%;
	right: 10%;
	font-size: 30px;
	color: #fff;
	cursor: pointer;
}

hr {
	height: 1px;
	background-color: black;
	border: none;
}
</style>

<!-- ============================================================================================== -->
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<br>
	<br>
	<center>
		<h3>Image Gallery</h3>
	</center>

	<!-- ----------------------------------------------------------------------------------------------------------------------- -->
	<div class="img-gallery">
		<c:if test="${ requestScope.list.size() == 0 }">등록된 이미지가 없습니다.</c:if>
		<c:if test="${ requestScope.list.size()!= 0 }">
			<c:forEach items="${ requestScope.list }" var="g">
				<div class="full-img" id="fullImgBox">
					<img src="resources/gallery/faceImages/${ g.img_rename }"
						id="fullImg"> <span onclick="closeFullImg()">x</span>
				</div>
				<c:if test="${ g.img_ori_name != null }">
					<img src="resources/gallery/faceImages/${ g.img_rename }"
						onclick="openFullImg(this.src)">
				</c:if>
			</c:forEach>
		</c:if>
	</div>
	<!-- ----------------------------------------------------------------------------------------------------------------------- -->
	<br>
	<br>
	<center>
		<h3>Sticker Gallery</h3>
	</center>
	<div class="img-gallery">
		<c:if test="${ requestScope.slist.size() == 0 }">등록된 스티커가 없습니다.</c:if>
		<c:if test="${ requestScope.slist.size()!= 0 }">
			<c:forEach items="${ requestScope.slist }" var="g">
				<div class="full-img" id="fullImgBox">
					<img src="resources/gallery/stickers/${ g.s_rename }" id="fullImg">
					<span onclick="closeFullImg()">x</span>
				</div>
				<c:if test="${ g.s_rename != null }">
					<img src="resources/gallery/stickers/${ g.s_rename }"
						onclick="openFullImg(this.src)">
				</c:if>
			</c:forEach>
		</c:if>
	</div>
	<!-- ----------------------------------------------------------------------------------------------------------------------- -->
	<br>
	<hr>

	<c:url var="modi" value="/modify.do">
		<c:param name="userid" value="${ sessionScope.loginMember.userid }"></c:param>
	</c:url>
	<c:url var="del" value="/delete.do">
		<c:param name="userid" value="${ sessionScope.loginMember.userid }"></c:param>
	</c:url>
	<c:url var="sdel" value="/sdelete.do">
		<c:param name="userid" value="${ sessionScope.loginMember.userid }"></c:param>
	</c:url>

	<center>
		<div class="container">
			<h2>menu</h2>
			<a href="imgUpload.do" class="btn-two blue rounded">사진업로드</a> <a
				href="sticketUpload.do" class="btn-two blue rounded">스티커업로드</a> <a
				href="${ modi }" class="btn-two blue rounded">사진 편집</a> <a
				href="${ del }" class="btn-two blue rounded">사진 삭제</a> <a
				href="${ sdel }" class="btn-two blue rounded">스티커 삭제</a> <a
				class="btn-two blue rounded" onclick="javascript:history.go(-1);">이전페이지</a>
		</div>
	</center>
	
	
	
	<!-- JavaScripts ============================================= -->

	<script type="text/javascript">
		var fullImgBox = document.getElementById("fullImgBox");
		var fullImg = document.getElementById("fullImg");

		function openFullImg(pic) {
			fullImgBox.style.display = "flex";
			fullImg.src = pic;
		}

		function closeFullImg() {
			fullImgBox.style.display = "none";
		}
	</script>
	<c:import url="/WEB-INF/views/common/footer2.jsp" />
</body>
</html>