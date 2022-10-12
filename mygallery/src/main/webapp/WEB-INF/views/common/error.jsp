<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="<c:url value="/resources/css/common.css" />">
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<div height = "150"></div>
<c:if test="${ !empty titleMsg }">
<h1 align="center">${ titleMsg }</h1>
</c:if>
<c:if test="${ empty titleMsg }">
<h1 align="center">"에러"</h1>
</c:if>
<br><br><br>
<c:set var = "e" value = "<%= exception %>"/>
<c:if test="${ !empty e }">	<!-- 자바 코드로  if(e != null)과 같음 -->
	<h3>jsp 페이지 오류 발생 : ${ message }</h3>
</c:if>
<c:if test="${ empty e }">
	<h3 align= "center">${ message }</h3>
</c:if>
<c:url var = "movemain" value = "/main.do"/>
<h3 align="center"><a href = "#"  onclick= "javascript:history.go(-1);"}>이전페이지로 이동</a></h3>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>