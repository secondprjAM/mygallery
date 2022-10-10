<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<h1 align="center">내 정보 보기</h1>
<br>
<table id="outer" align="center" width="500" cellspacing="5" 
cellpadding="0" border="1">
   <tr>
      <th width="120">이 름</th>
      <td>${ requestScope.member.username }</td>
   </tr>
   <tr>
      <th width="120">아이디</th>
      <td>${ member.userid }   </td>
   </tr>   
   <tr>
      <th width="120">성 별</th>
      <td>
      <c:if test="${ member.usergender eq 'M' }">
         <input type="radio" name="usergender" value="M" checked> 남자 &nbsp;
         <input type="radio" name="usergender" value="F"> 여자
      </c:if>
      <c:if test="${ member.usergender eq 'F' }">
         <input type="radio" name="usergender" value="M" > 남자 &nbsp;
         <input type="radio" name="usergender" value="F" checked> 여자
      </c:if>
      </td>
   </tr>
   <tr>
      <th width="120">이메일</th>
      <td>${ member.useremail }</td>
   </tr>
   <tr>
      <th colspan="2">
         <c:url var="moveup" value="/moveup.do">
            <c:param name="userid" value="${ member.userid }"/>
         </c:url>
         <a href="${ moveup }">수정페이지로 이동</a> &nbsp; 
         <c:url var="mdel" value="mdel.do">
            <c:param name="userid" value="${ member.userid }"/>
         </c:url>
         <a href="${ mdel }">탈퇴하기</a> &nbsp; 
         <a href="main.do">시작페이지로 이동</a>
      </th>      
   </tr>
</table>

<hr style="clear:both;">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>