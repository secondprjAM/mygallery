<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value="/resources/css/common.css" />">
<style type="text/css">
	
		.button:hover {
		background-color:salmon;
	}

	
	th {
		font-weight:normal;
		font-size: 16px;
	}
	
	td input{
		width: 25rem;
		height:3rem; 
		border:3px solid #f8f9fa; 
	}
	a{ text-decoration: none; color:#333;}
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<br><br>
<h1 align="center">MyGallery</h1>
<h2 align="center">내 정보 보기</h2>
	<form action="checkself.do" method="post">
	<table align="center"  class="table">
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
				<button type="submit" value="본인 확인" class="button"  style="width: 180px;
		height: 45px;
		 font-size: 16px;
		letter-spacing: 2px;
		color: #000;
		background-color: #f1f3f5;
		border: none;
		border-radius: 45px;
		cursor: pointer;
		outline: none;
		transition: 0.6s;">본인 확인</button>
				<button class="button"  type="reset"  value="작성취소" style="width: 180px;
		height: 45px;
		 font-size: 16px;
		letter-spacing: 2px;
		color: #000;
		background-color: #f1f3f5;
		border: none;
		border-radius: 45px;
		cursor: pointer;
		outline: none;
		transition: 0.6s;">작성취소</button>
				<button class="button" style="width: 180px;
		height: 45px;
		 font-size: 16px;
		letter-spacing: 2px;
		color: #000;
		background-color: #f1f3f5;
		border: none;
		border-radius: 45px;
		cursor: pointer;
		outline: none;
		transition: 0.6s;"><a href="main.do">시작페이지로 이동</a></button>
			</td>
		</th>
		</form>
	</table>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>