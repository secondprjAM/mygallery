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
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<h2 align="center">${ notice.noticeno }번 공지글 수정 페이지</h2>
<!-- form 태그에서 입력된 값들(문자열)과 첨부파일을 같이 전송하려면,
	반드시 enctype 속성을 form 태그에 추가해야 됨
	enctype="multipart/form-data" 값을 지정해야 함
	method="post" 로 지정해야 함
 -->
<form action="nupdate.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="notice_no" value="${ n.notice_no }">
	<c:if test="${ !empty n.notice_upfile }">
	<!-- 첨부파일이 있는 공지글이라면 -->
		<input type="hidden" name="notice_upfile" value="${ n.notice_upfile }">
		<input type="hidden" name="notice_refile" value="${ n.notice_refile }">
	</c:if>
<table align="center" width="500" border="1" cellspacing="0" 
cellpadding="5">
	<tr><th>제 목</th><td><input type="text" name="notice_title" value="${ n.notice_title }"></td></tr>
	<tr><th>작성자</th>
	<td><input type="text" name="notice_writer" readonly value="${ n.notice_writer }"></td></tr>
	<tr><th>첨부파일</th>
		<td>
			<!-- 원래 첨부파일이 있는 경우 -->
			<c:if test="${ !empty n.notice_upfile }">
				${ n.notice_upfile } &nbsp; 
				<input type="checkbox" name="delFlag" value="yes"> 파일삭제 <br>
			</c:if>
			<br>
			새로 첨부 : <input type="file" name="upfile">
		</td>
	</tr>
	<tr><th>내 용</th><td><textarea rows="5" cols="50" name="notice_content">${ n.notice_content }</textarea></td></tr>
	<tr><th colspan="2">
		<input type="submit" value="수정하기"> &nbsp; 
		<input type="reset" value="수정취소"> &nbsp; 
		<button onclick="javascript:history.go(-1);">이전페이지로 이동</button>
	</th></tr>
</table>
</form>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>