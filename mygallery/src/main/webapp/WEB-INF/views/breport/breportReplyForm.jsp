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
btable {
	width: 900px;
	background-color: #fff;
	border-collapse: collapse;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
	border-radius: 5px;
	overflow: hidden;
}

.btable caption {
	font-size: 20px;
	margin-bottom: 30px;
}

.btable tr {
	border-bottom: 1px solid #eee;
}

.btable tr:last-child {
	border: none;
}

.btable tr:nth-child(odd) {
	background-color: #ddd;
}

.btable th, .btable td {
	padding: 12px;
	text-align: center;
}

.btable tr th {
	background-color: #FF8080;
	color: #fff;
}

.btable tr th:first-child {
	border-radius: 5px 0 0 0;
}

.wrap {
	height: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
}

.button {
  width: 140px;
  height: 45px;
  font-family: 'Roboto', sans-serif;
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 2.5px;
  font-weight: 500;
  color: #000;
  background-color: #FFA7A7;
  border: none;
  border-radius: 45px;
  box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease 0s;
  cursor: pointer;
  outline: none;
  }

.button:hover {
  background-color: #2EE59D;
  box-shadow: 0px 15px 20px rgba(46, 229, 157, 0.4);
  color: #fff;
  transform: translateY(-7px);
}
</style>

</head>
<body>
	<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<hr>
	<h3 align="center">댓글 페이지</h3>

	<form action="breply.do" method="post">
		<!-- 원글 번호도 함께 숨겨서 전송 -->
		<input type="hidden" name="b_ref" value="${ b_no }"> <input
			type="hidden" name="page" value="${ currentPage }">

		<table class="btable" align="center" width="700" height="400" border="1"
			cellspacing="0" cellpadding="5">
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
				<td><textarea rows="15" cols="70" name="b_content"></textarea></td>
			</tr>
			
		</table>
		<br>
		<div align="center">
			<button class="button"><input type="submit" value="댓글등록"></button> &nbsp;  
			<button class="button" onclick="javascript:history.go(-1);">이전페이지로 이동</button>
		</div>
	</form>

	<br>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>