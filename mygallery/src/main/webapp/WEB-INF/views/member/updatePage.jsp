<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
</style>
<script type="text/javascript">

function validate(){
	//암호확인의 포커스가 사라질 때 암호와 암호확인 일치하는지 검사
	
	//암호와 암호확인이 일치하는지 확인
	var pwd1 = document.getElementById("upwd1").value;
	var pwd2 = document.getElementById("upwd2").value;
	
	if(pwd1 !== pwd2){
		alert("암호와 암호 확인의 값이 일치하지 않습니다.\n"
				+ "다시 입력하세요.");
		document.getElementById("upwd1").select();		
	}
}
</script>
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
<h2 align="center">회원 정보 수정 페이지기</h2>
<br>
<form action="mupdate.do" method="post">
	<input type="hidden" name="origin_userpassword" value="${ member.userpassword }">
<table id="outer" align="center" width="500" cellspacing="5" cellpadding="0">
	<th>
		<td>비밀번호만이 변경이 가능합니다.</td>
	</th>
	<tr>
		<th width="120">이 름</th>
		<td><input type="text" name="username" value="${ member.username }" readonly></td>
	</tr>
	<tr>
		<th width="120">아이디</th>
		<td><input type="text" name="userid" id="userid" value="${ member.userid }" readonly>
		</td>
	</tr>
	<tr>
		<th width="120">암 호</th>
		<td><input type="password" name="userpassword" id="upwd1" placeholder="새로운 암호" value=""></td>
	</tr>
	<tr>
		<th width="120">암호확인</th>
		<td><input type="password" id="upwd2" placeholder="새로운 암호 확인" onblur="validate();"></td>
	</tr>
	<tr>
		<th width="120">성 별</th>
		<td readonly>
		<c:if test="${ member.usergender eq 'M' }">
			<input type="radio" name="usergender" value="M" checked onclick="return false"> 남자 &nbsp;
			<input type="radio" name="usergender" value="F" onclick="return false"> 여자
		</c:if>
		<c:if test="${ member.usergender eq 'F' }">
			<input type="radio" name="usergender" value="M" onclick="return false"> 남자 &nbsp;
			<input type="radio" name="usergender" value="F" checked onclick="return false"> 여자
		</c:if>
		</td>
	</tr>
	<tr>
		<th width="120">이메일</th>
		<td><input type="email" name="useremail" value="${ member.useremail }" readonly></td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" class="from-button" value="수정하기">
			<input type="reset" class="from-button" value="수정취소">
			<a class="from-button" href="main.do">시작페이지로 이동</a>
		</th>		
	</tr>
</table>
</form>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>