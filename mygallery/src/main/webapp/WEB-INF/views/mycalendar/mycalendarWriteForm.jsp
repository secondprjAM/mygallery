<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" >
function readURL(input) {
	  if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function(e) {
	      document.getElementById('preview').src = e.target.result;
	    };
	    reader.readAsDataURL(input.files[0]);
	  } else {
	    document.getElementById('preview').src = "";
	  }
	}
</script>
</head>
<body>
<form action="minsert.do" method="post"  enctype="multipart/form-data" >
<table align="center"  width="500"  border="1"  cellspacing="0"  
cellpadding="10"  style="margin-top:200px;">
	<tr><th>날짜</th><td><input type="date" name="calendar_date"></td></tr>

	<tr><th>내용</th><td><input type="textarea" name="calendar_content" ></td></tr>
	<tr><th>작성자</th><td><input type="text"  name="userid" 	 readonly value="${sessionScope.loginMember.userid}" }></td></tr>
	
	<tr><th>내 용</th><td><img id="preview"></td></tr>
	<tr><th colspan="2">
		
		<!-- <input type="file"  onchange="readURL(this);" name="upfile"> &nbsp; -->
		<input type="submit" value="캘린더 등록"> &nbsp; 
		<a href="./mycalendar.do">이전화면</a> &nbsp; 		<!-- 오류나면 여기 history -->
	</th></tr>
</table>
</form>
</body>
</html>








