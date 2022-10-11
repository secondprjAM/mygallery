<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/css/common.css" />">
<style type="text/css">
th {
	font-size: 10pt;
	margin: 0;
	align: left;
	margin-top: 10px;
}

td{
	margin: 100px;
}

.input-group-addon {
	margin-left: -20px;
}

table{
	background-color: #f8f9fa;
	padding: 40px;
	border-spacing: 0 20px;
}

form {
    margin-top: 50px;
    align: center;
    width: 100%;
    height: 100%;
}

.from-button{
	width: 7rem;
	height: 1.5rem;
	border: 0px;
	background-color: #f8f9fa;
	cursor: pointer;
}

a {
  text-decoration: none;
}

.startPage:link {
  color : black;
}
.startPage:visited {
  color : black;
}
.startPage:hover {
  color : black;
}
.startPage:active {
  color : black;
}
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<br><br>
<h1 align="center">MyGallery</h1>
<h2 align="center">내 정보 보기</h2>
	<form action="checkself.do" method="post">
	<table align="center">
		<input type="hidden" name="userid" value="${ member.userid}">
		<th>
			<td>암호를 입력하여 본인 인증 해주세요.</td>
		</th>
		<tr>
			<th width="120">암 호 : </th>
			<td>
				<input type="password" name="userpassword" class="pos"></label>
			</td>
			<br>
		</tr>
		<th>
			<td>
				<input type="submit" class="from-button" value="본인 확인">
				<input type="reset" class="from-button" value="작성취소">
				<a class="from-button" href="main.do">시작페이지로 이동</a>
			</td>
		</th>
		</form>
	</table>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>