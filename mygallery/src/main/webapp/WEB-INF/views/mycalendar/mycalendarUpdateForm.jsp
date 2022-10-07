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
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<%-- <h2 align="center">${ mycalendar.calendar_no}번 마이캘린더 수정 페이지</h2>

<form action="nupdate.do"  method="post"  enctype="multipart/form-data">
	<table align="center"  width="500"  border="1"  cellspacing="0"  cellpadding="10"  style="margin-top:200px;">
		<tr><th>날짜</th><td><input type="date" name="begin" value="${ mycalendar.calendar_date  }"></td></tr>
		<tr><th>내용</th><td><input type="textarea" name="calendar_content" value="${ mycalendar.calendar_content  }"></td></tr>
		<tr><th>작성자</th><td><input type="text"  name="userid" 	 readonly value="${sessionScope.loginMember.userid}" ></td></tr>
		<tr><th>이미지</th><td><img id="preview"></td></tr>
		<tr><th></th>
			<td>
				<input type="file"  onchange="readURL(this);" name="upfile"> 
				<c:if test="${ !empty notice.original_filepath }">
				${ notice.original_filepath } &nbsp; 
				<input type="checkbox" name="delFlag" value="yes"> 파일삭제 <br>
			</c:if>
			</td>
		</tr>
		<tr><th colspan="2">
			<input type="submit" value="수정하기"> &nbsp; 
			<input type="reset" value="수정취소"> &nbsp; 
			<a href="./mycalendar.do">이전화면</a> &nbsp; 
		</th></tr>
</table>
</form> --%>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>