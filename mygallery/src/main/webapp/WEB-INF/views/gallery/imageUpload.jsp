<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="<c:url value="/resources/css/common.css" />">
<style type="text/css">
    .button {
      width: 120px;
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
   
   a{text-decoration:none; color:#333;}
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<br><br><br><br>
	<center>
		<h3>Image Upload</h3>
	</center>
	<form action="imginsert.do" method="post" enctype="multipart/form-data">
		<table align="center" width="500" class="table" cellspacing="0"
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
				<th colspan="2"><input type="submit" value="업로드" class="button">
					&nbsp; <c:url var="cam" value="/camera.do">
						<c:param name="userid"
							value="${ sessionScope.loginMember.userid }"></c:param>
					</c:url>
					<button type="button" class="button">
						<a href="${ cam }"  style="color:#333;">이미지 촬영</a>
					</button>&nbsp; <c:url var="back" value="/gallery.do">
						<c:param name="userid"
							value="${ sessionScope.loginMember.userid }"></c:param>
					</c:url>
					<button class="button">
						<a href="${ back }">이전페이지
					</button></th>
			</tr>
		</table>
	</form>
	<br><br><br><br>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>