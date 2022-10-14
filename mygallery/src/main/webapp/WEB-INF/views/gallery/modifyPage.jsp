<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title></title>
<!-- ============================================================================================== -->
<style type="text/css">
body {padding: 0 100px;}
label:before {
	content:
		url("https://cdn1.iconfinder.com/data/icons/windows8_icons_iconpharm/26/unchecked_checkbox.png");
	position: absolute;
	z-index: 100;
}

:checked+label:before {
	content:
		url("https://cdn1.iconfinder.com/data/icons/windows8_icons_iconpharm/26/checked_checkbox.png");
}

input[type=checkbox] {
	display: none;
}

input[type=radio]{
	display: none;
}


/* =================================================== */
.print-values {
	position: relative;
	margin-top: 2rem;
}

.print-values p {
	background: white;
	padding: 16px;
	color: #b8b8b8;
}
</style>

<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>

<script type="text/javascript">
	function pythonStart() {
		console.log("start");
		$.ajax({
			url : "python.do",
			type : "POST",
	        dataType : "text",
			success : function(data) {
				console.log("success : " + data); //Object 로 출력됨
				<c:url var="gal" value = "/gallery.do">
				<c:param name="userid" value="${ sessionScope.loginMember.userid }"></c:param>
				</c:url>
				location.href= "${gal}";
			},

			error : function(jqXHR, textStatus, errorThrown) {
				console.log("error : " + jqXHR + ", " + textStatus + ", "
						+ errorThrown);
			}
		});
	}
	
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />

	<center>
	<br>
	<br>
		<h3>Modify Page</h3>
		<br>
	</center>

	<h2>이미지</h2>
	<form width="500" action="python.do" method="post">
		<fieldset id="chk1">
			<c:forEach items="${ requestScope.list }" var="g">
				<c:if test="${ !empty g.img_rename }">
					<input type="checkbox" id="${g.img_rename}" class="checkbox1"
						value="${g.img_rename}" name="img_rename">
					<label for="${g.img_rename}"><img
						src="resources/gallery/faceImages/${g.img_rename}" width="150"
						height="150"></label>
				</c:if>
			</c:forEach>
			<div class="print-values">
				<div id="faceList"></div>
		</fieldset>


		<h2>코 스티커</h2>
		<h5>스티커 한개만 선택 가능</h5>
		<fieldset id="chk2">
			<c:forEach items="${ requestScope.slist }" var="s">
				<c:if test="${ s.s_rename != null && s.category == 'nose'}">
					<input type="radio" id="nose${s.s_rename}" class="checkbox2"
						value="${s.s_rename}" name="s_rename">
					<label for="nose${s.s_rename}"><img
						src="resources/gallery/stickers/${s.s_rename}" width="150"
						height="150"></label>
				</c:if>
			</c:forEach>
			<div class="print-values">
				<div id="noseList"></div>
		</fieldset>


		<h2>오른쪽 스티커</h2>
		<h5>스티커 한개만 선택 가능</h5>
		<fieldset id="chk3">
			<c:forEach items="${ requestScope.slist}" var="s">
				<c:if test="${ s.s_rename != null  && s.category == 'rig' }">
					<input type="radio" id="right${s.s_rename}" class="checkbox3"
						value="${s.s_rename}" name="rig_rename">
					<label for="right${s.s_rename}"><img
						src="resources/gallery/stickers/${s.s_rename}" width="150"
						height="150"></label>
				</c:if>
			</c:forEach>
			<div class="print-values">
				<div id="rightList"></div>
		</fieldset>


		<h2>윈쪽 스티커</h2>
		<h5>스티커 한개만 선택 가능</h5>
		<fieldset id="chk4">
			<c:forEach items="${ requestScope.slist }" var="s">
				<c:if test="${ s.s_rename != null && s.category == 'lef'}">
					<input type="radio" id="left${s.s_rename}" class="checkbox4"
						value="${s.s_rename}" name="lef_rename">
					<label for="left${s.s_rename}"><img
						src="resources/gallery/stickers/${s.s_rename}" width="150"
						height="150"></label>
				</c:if>
			</c:forEach>
			<div class="print-values">
				<div id="leftList"></div>
		</fieldset>


		<br> <br>
		<center>
			<input type="submit" onclick="pythonStart()" value="이미지 편집하기">
		</center>
		</div>
	</form>

	<br>
	<hr>
	<br>
	
	<script type="text/javascript">
		var limit = document.getElementsByClassName('.checkbox2');

		limit.click(function() {
		var bol = limit:checked.length >= 1;     
		limit.not(":checked").attr("disabled",bol);
		});
		
	
	</script>


	<script type="text/javascript"
		src="${ pageContext.servletContext.contextPath }/resources/js/app.js"></script>

	<c:import url="/WEB-INF/views/common/footer2.jsp" />
</body>
</html>