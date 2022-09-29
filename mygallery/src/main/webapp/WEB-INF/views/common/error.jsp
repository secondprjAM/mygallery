<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>에러 페이지</h1>
<c:set var = "e" value = "<%= exception %>"/>
<c:if test="${ !empty e }">	<!-- 자바 코드로  if(e != null)과 같음 -->
	<h3>jsp 페이지 오류 발생 : ${ message }</h3>
</c:if>
<c:if test="${ empty e }">
	<h3>컨트롤러 요청 실패 메세지 : ${ message }</h3>
</c:if>
<hr>

<c:url var = "movemain" value = "/main.do"/>
<a href = "${movemain}" }>시작페이지로 이동</a>
</body>
</html>