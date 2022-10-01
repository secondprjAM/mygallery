<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<!-- ============================================================================================== -->

</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp"/>
	<br>
	<br>
	<br>
	<br>
	<center>
	<h3>Delete Page</h3>
	</center>
		
	
	<!-- ---------------------------------------------------------------------------------------------------------- -->
	
	<table align="center" border="1" cellspacing="0" cellpadding="3" width="700">
		<tr>
			<th>이미지</th>
			<!-- <th>번호</th> -->
			<th>유저아이디</th>
			<th>등록날짜</th>
			<th>삭제</th>
		</tr>
		<c:forEach items="${ requestScope.list }" var="g">
		<tr align="center">
			<c:if test="${ g.mb_imgname != null }">
				<td width="100"><img src="resources/gallery/faceImages/${ g.mb_imgname }" width="100" height="100"></td>
			<td>${ g.userid }</td>
			<td><fmt:formatDate value="${ g.mb_image_date }" pattern="yyyy-MM-dd"/></td>
			<c:url var="gdel" value="/gdel.do">
					<c:param name="inum" value="${ g.user_snum }"/>
				</c:url>
			
			<td><button onclick="javascript:location.href='${ gdel}';">delete</button></td>
				
				
			</c:if>
			<%-- <c:if test="${ g.mb_imgname == null }">&nbsp;</c:if> --%>
			
			
			
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
	

<hr style="clear:both;">
<c:import url="/WEB-INF/views/common/footer.jsp"/>


</body>
</html>