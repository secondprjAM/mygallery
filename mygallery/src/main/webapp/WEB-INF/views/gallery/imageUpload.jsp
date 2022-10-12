<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<br><br><br><br>
	<center>
		<h3>Image Upload</h3>
	</center>
	<form action="imginsert.do" method="post" enctype="multipart/form-data">
		<table align="center" width="500" border="1" cellspacing="0"
			cellpadding="5">
			<tr>
				<th>작성자</th>
				<td><input type="text" name="userid" readonly
					value="${  sessionScope.loginMember.userid  }"></td>
			</tr>
			<tr>
				<th>이미지업로드</th>
				<td><input type="file" name="upfile"
					accept="image/png, image/jpeg"></td>
			</tr>
			<tr>
				<th colspan="2"><input type="submit" value="업로드">
					&nbsp; <c:url var="cam" value="/camera.do">
						<c:param name="userid"
							value="${ sessionScope.loginMember.userid }"></c:param>
					</c:url>
					<button type="button">
						<a href="${ cam }">이미지 촬영</a>
					</button>&nbsp; <c:url var="back" value="/gallery.do">
						<c:param name="userid"
							value="${ sessionScope.loginMember.userid }"></c:param>
					</c:url>
					<button>
						<a href="${ back }">이전페이지
					</button></th>
			</tr>
		</table>
	</form>
	<br><br><br><br>
	<hr style="clear: both;">
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>