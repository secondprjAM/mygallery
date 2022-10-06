<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="b_no" value="${ requestScope.b_no }" />
<c:set var="currentPage" value="${ requestScope.currentPage }" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<h3 align="center">댓글 페이지</h3>
<form action="breply.do" method="post" >
	<!-- 원글 번호도 함께 숨겨서 전송 -->
	<input type="hidden" name="b_ref" value="${ b_no }">
	<input type="hidden" name="page" value="${ currentPage }">
	
<table align="center" width="500" border="1" cellspacing="0" 
cellpadding="5">
	<tr><th>제 목</th><td><input type="text" name="b_title"></td></tr>
	<tr><th>작성자</th>
	<td><input type="text" name="userid" readonly value="${ loginMember.userid }"></td></tr>
	
	<tr><th>내 용</th><td><textarea rows="5" cols="50" name="b_content"></textarea></td></tr>
	<tr><th colspan="2">
		<input type="submit" value="댓글등록하기"> &nbsp; 
		<input type="reset" value="작성취소"> &nbsp; 
		<button onclick="javascript:history.go(-1);">이전페이지로 이동</button>
	</th></tr>
</table>
</form>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>