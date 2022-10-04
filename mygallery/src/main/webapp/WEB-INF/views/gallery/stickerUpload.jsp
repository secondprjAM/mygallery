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
	<h3>Sticker Upload</h3>
	</center>
	<form action="stkinsert.do" method="post" enctype="multipart/form-data">
	<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>작성자</th><td><input type="text" name="userid" readonly value="${  sessionScope.loginMember.userid  }"></td></tr><!-- readonly value="${ sessionScope.userid }" -->
	<tr><th>스티커업로드</th><td><input type="file" name="upfile" accept="image/png, image/jpeg"></td></tr><!-- accept="image/*" -->
	<tr>
	<th colspan="2">
		<input type="submit" value="업로드"> &nbsp; 
		<input type="reset" value="작성취소"> &nbsp; 
		<button onclick="javascript:history.go(-1);">이전페이지</button>
	</th>
	</tr>
</table>
</form>
	<br>
	<br>
	<br>
	<br>
<hr style="clear:both;">
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>