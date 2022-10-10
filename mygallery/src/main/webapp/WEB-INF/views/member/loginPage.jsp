<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="<c:url value="/resources/css/common.css" />">
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<div height = "150"></div>
	<h1 align="center">MyGallery</h1>
	<form action="login.do" method="post" align="center">
		<table align="center" id="logtable" >
			<c:if test="${ !empty massage }">
				<div>${ message }
				</div>
			</c:if>
			<tr>
				<td><font size="4">아  이  디 : &nbsp;</font></td>
				<td><input width="300px" height ="10px" type="text" name="userid" class="pos"></td>
				</th>
			</tr>
			<tr>
				<td><font size="4">패스워드 : &nbsp; </font></td>
				<td><input type="password" name="userpassword" class="pos"></td>
			</tr>
			<tr>
				<th colspan="2"><input type="submit" value="로그인">
				</th>
			</tr>
		</table>
	</form>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>