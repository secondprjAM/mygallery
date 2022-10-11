<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript" >
function onDisplay(){
	console.log("ㅇㅇ");
	$(".nonTr").show();
}
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<h2 align="center">수정 페이지</h2>

<form action="calupdate.do"  method="post" >
	<table align="center"  width="500"  border="1"  cellspacing="0"  cellpadding="10"  style="margin-top:200px;">
		<tr><th>날짜</th><td><input type="date" name="calendar_date" readonly value="${ mycalendar.calendar_date  }"></td></tr>
		<tr><th>내용</th><td><input type="textarea" name="calendar_content" value="${ mycalendar.calendar_content  }"></td></tr>
		<tr><th>작성자</th><td><input type="text"  name="userid" 	 readonly value="${ mycalendar.userid }" ></td></tr>
		<tr><th>이미지</th><td><img id="preview"></td></tr>
		<tr><th><img src="resources/gallery/faceImages/${ mycalendar.filename }"  width="150" height="150"></td></tr>
		
		<tr><th><input type="button" onclick="onDisplay()" value= "이미지 수정"></th></tr>
		<tr class="nonTr" style="display: none;"><th>
		<c:forEach var="imgList" items="${ imgList }">
			<td id="full-img">
			<input type="radio" id="filename" class="checkbox" name="filename" value="${ imgList.img_rename }">
			<img src="resources/gallery/faceImages/${ imgList.img_rename }"  width="150" height="150">
			</td>
		</c:forEach>
		</th></tr>
		
		<tr><th colspan="2">
			<input type="submit" value="수정하기"> &nbsp; 
			<input type="reset" value="수정취소"> &nbsp; 
			<a href="./mycalendar.do">이전화면</a> &nbsp; 
		</th></tr>
</table>
</form> 
<br><br><br><br><br><br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>