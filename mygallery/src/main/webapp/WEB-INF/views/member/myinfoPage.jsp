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
	margin-left: -30px;
}

table{
	background-color: #f8f9fa;
	padding: 20px;
	border-spacing: 0 20px;
}

form {
    margin-top: -200px;
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
<br>
<table id="outer" align="center" width="500" cellspacing="5" cellpadding="0">
   <tr>
      <th width="120">이 름 :</th>
      <td>${ requestScope.member.username }</td>
   </tr>
   <tr>
      <th width="120">아이디 :</th>
      <td>${ member.userid }   </td>
   </tr>   
   <tr>
      <th width="120">성 별 :</th>
      
      <c:if test="${ member.usergender eq 'M' }">
         <td>남자</td> 
      </c:if>
      <c:if test="${ member.usergender eq 'F' }">
         <td >여자</td> 
      </c:if>
   </tr>
   <tr>
      <th width="120">이메일 :</th>
      <td>${ member.useremail }</td>
   </tr>
   <tr>
      <th colspan="2">
         <c:url var="moveup" value="/moveup.do">
            <c:param name="userid" value="${ member.userid }"/>
         </c:url>
         <a class="startPage" href="${ moveup }">수정페이지로 이동</a> &nbsp; 
         <c:url var="mdel" value="mdel.do">
            <c:param name="userid" value="${ member.userid }"/>
         </c:url>
         <a class="startPage" href="${ mdel }">탈퇴하기</a> &nbsp; 
         <a class="startPage" href="main.do">시작페이지로 이동</a>
      </th>      
   </tr>
</table>

<hr style="clear:both;">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>