<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<body>
<h1 align="center">Admin 정보</h1>
<br>
<table id="outer" align="center" width="500" cellspacing="5" 
cellpadding="0" border="1">	
	<center>
	<tr>
	<th width="300">${ requestScope.member.username }</th>
	</tr>
	<tr>
		<th width="300">${ member.userid }</th>
	</tr>	
	<tr>
		<th width="300">
		<c:if test="${ member.usergender eq 'M' }">
			<input type="radio" name="usergender" value="M" checked onclick="return(false);"> 남자 &nbsp;
			<input type="radio" name="usergender" value="F" onclick="return(false);"> 여자
		</c:if>
		<c:if test="${ member.usergender eq 'F' }">
			<input type="radio" name="usergender" value="M" onclick="return(false);"> 남자 &nbsp;
			<input type="radio" name="usergender" value="F" checked onclick="return(false);"> 여자
		</c:if>
	</th>	
	</tr>
		<th width="300">${ member.useremail }</th>
	</tr>
	<br>
	</center>
	</table>
	<br>
<center>
	<button onclick="javascript:history.go(-1);">이전페이지</button>
</center>
	</tr>
	<br>


<hr style="clear:both;">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>