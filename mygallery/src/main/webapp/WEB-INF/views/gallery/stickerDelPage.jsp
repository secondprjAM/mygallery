<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<!-- ============================================================================================== -->
<link rel="stylesheet" href="<c:url value="/resources/css/common.css" />">
<style type="text/css">
    .button {
      width: 100px;
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

   th {
      font-weight:normal;
      font-size: 16px;
   }
   
   td input{
      width: 25rem;
      height:3rem; 
      border:3px solid #f8f9fa; 
   }
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<br>
	<br>
	<center>
		<h3>Sticker Delete Page</h3>
			<br>
	<br>
	</center>
	<!-- ---------------------------------------------------------------------------------------------------------- -->
	<table align="center"  class="table"  cellspacing="0" cellpadding="3"
		width="700">
		<tr>
			<th>이미지</th>
			<th>유저아이디</th>
			<th>등록날짜</th>
			<th>삭제</th>
		</tr>
		<c:forEach items="${ requestScope.slist }" var="s">
			<tr align="center">
				<c:if test="${ s.s_rename != null }">
					<td width="100"><img
						src="resources/gallery/stickers/${ s.s_rename }" width="100"
						height="100"></td>
					<td>${ s.userid }</td>
					<td><fmt:formatDate value="${ s.s_date }" pattern="yyyy-MM-dd" /></td>
					<c:url var="sdel" value="/sdel.do">
						<c:param name="rfile" value="${ s.s_rename }" />
						<c:param name="snum" value="${ s.snum }" />
						<c:param name="userid" value="${ s.userid }" />
					</c:url>

					<td><button onclick="javascript:location.href='${ sdel}';">delete</button></td>
				</c:if>

			</tr>
		</c:forEach>
	</table>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<!-- ----------------------------------------------------------------------------------------------------------- -->

	<c:import url="/WEB-INF/views/common/footer2.jsp" />


</body>
</html>