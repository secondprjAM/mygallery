<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1 align="center">MyGallery 본인 확인</h1>
<div id="checkseif">
	<form action="checkself.do" method="post">
	<input type="hidden" name="userid" value="${ member.userid}">
		<label>암 호 : <input type="password" name="userpassword" class="pos"></label> <br>
		<input type="submit" value="본인 확인"> &nbsp; 
		<input type="reset" value="작성취소"> &nbsp; 
		<a href="main.do">시작페이지로 이동</a>
	</form>
</div>

</body>
</html>