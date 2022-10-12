<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
        .button {
      width: 160px;
      height: 45px;
      margin-top:50px;
       font-size: 16px;
      text-transform: uppercase;
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
   }
      
</style>
<link rel="stylesheet" href="<c:url value="/resources/css/common.css" />">
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<form action="minsert.do" method="post"  enctype="multipart/form-data" >
<table align="center"  width="500"  border="0"  cellspacing="0"  
cellpadding="10"  style="margin-top:50px; padding-bottom:100px;" class="table">
	
	<tr>
	<th>날짜 : </th>
		<td colspan= "3"><input type="date" name="calendar_date" style="width: 25rem;height:3rem; border:3px solid #f8f9fa;"></td>
	</tr>

	<tr><th>내용 : </th><td colspan= "3"><input type="textarea" name="calendar_content" maxlength='33' size="50" required style="width: 25rem;height:3rem; border:3px solid #f8f9fa;"></td></tr>
	<tr><th>작성자 : </th><td colspan= "3"><input type="text"  name="userid" 	 readonly value="${sessionScope.loginMember.userid}" } style="width: 25rem;height:3rem; border:3px solid #f8f9fa;"></td></tr>
		<tr>
		<th colspan= "4" style="border:2px solid  #f1f3f5">등록 가능한 이미지</th>
	</tr>
	<tr>
    <c:forEach var="imgList" items="${ imgList }" varStatus="img_status">
		<td id="full-img">
		<input type="radio" id="filename" class="checkbox" name="filename" value="${ imgList.img_rename }" required>
		<img src="resources/gallery/faceImages/${ imgList.img_rename }"  width="150" height="150">
		<c:if test="${img_status.index%4==3}"><tr></tr></c:if>
		</td>
	</c:forEach>
	</tr>
	<tr><th colspan="4">
		<input type="submit" value="캘린더 등록" class="button" style="width:140px;"> &nbsp; 
		<c:url var="back" value="./mycalendar.do">
		<c:param name="userid" value="${ sessionScope.loginMember.userid }"></c:param>
		</c:url>
		<input type="button" onclick="location.href='${back}' " value="이전화면" class="button"  style="width:140px;">
	</th></tr>
</table>
</form>
<c:import url="/WEB-INF/views/common/footer2.jsp" />
</body>
</html>








