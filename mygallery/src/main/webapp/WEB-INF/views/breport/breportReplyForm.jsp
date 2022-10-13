<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="b_no" value="${ requestScope.b_no }" />
<c:set var="currentPage" value="${ requestScope.currentPage }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">

.h3 {
	text-align:center;
	font-weight:normal;
	margin:50px auto;
	margin-left:-100px;
}

.table {
	   margin:0 auto;
	   padding-left:50px;
}
	
	th {
		font-weight:normal;
		font-size: 16px;
	}
	
	td > input {
		width: 25rem;
		height:3rem; 
		border:3px solid #f8f9fa; 
		margin:10px 0;
	}
	
.button {
	width:180px;
  	height: 45px;
		 font-size: 16px;
		letter-spacing: 2px;
		color: #000;
		background-color: #f1f3f5;
		border: none;
		border-radius: 45px;
		cursor: pointer;
		outline: none;
		transition: 0.6s;
	}
	
		.button:hover {
		background-color:salmon;
	}
	
	.box {
		padding-left:100px;
	}</style>

</head>
<body>
	<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<h3 align="center" class="h3">댓글 페이지</h3>

	<form action="breply.do" method="post">
		<!-- 원글 번호도 함께 숨겨서 전송 -->
		<input type="hidden" name="b_ref" value="${ b_no }"> <input
			type="hidden" name="page" value="${ currentPage }">

		<table class="table" align="center" width="700" height="400" cellspacing="0" cellpadding="5">
			<tr>
				<th>제 목</th>
				<td><input type="text" name="b_title"></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="userid" readonly
					value="${ loginMember.userid }"></td>
			</tr>

			<tr>
				<th>내 용</th>
				<td><input type="textarea" rows="15" cols="70" name="b_content"></textarea></td>
			</tr>
			
		</table>
		<br>
		<div align="center" style="margin:0 auto;" class="box">
			<button class="button" type="submit" value="댓글등록" style="margin-left:-100px;" class="button">댓글등록</button> &nbsp;  
			<button class="button" onclick="javascript:history.go(-1);" class="button">이전페이지로 이동</button>
		</div>
	</form>

	<br>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>