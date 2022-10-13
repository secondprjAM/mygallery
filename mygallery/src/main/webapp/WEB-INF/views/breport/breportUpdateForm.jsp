<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentPage" value="${ requestScope.page }" /> 
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="<c:url value="/resources/css/common.css" />">
<style>

#table {
	 margin:50px auto;
		 text-align:center;
}
th {
		width:120px;
		font-weight:normal;
		font-size: 16px;
	}
	
	td > input{
		width: 25rem;
		height:3rem; 
		border:3px solid #f8f9fa; 
	}
	
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
</style>
</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" /> 

<h2 align="center" style="font-weight:normal; margin:50px 0;">${ breport.b_no }번 게시글 수정 페이지</h2>
<br>
<!-- 원글 수정 폼 -->
<c:if test="${ breport.b_lev eq 1 }">

<form action="originup.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="b_no" value="${ breport.b_no }">
	<input type="hidden" name="page" value="${ currentPage }">
	<c:if test="${ !empty breport.b_upfile }">
	<!-- 첨부파일이 있는 버그리포트라면 -->
		<input type="hidden" name="b_upfile" value="${ breport.b_upfile }">
		<input type="hidden" name="b_refile" value="${ breport.b_refile }">
	</c:if>
<table align="center" width="500"1cellspacing="0" cellpadding="5"  id="table" >
	<tr><th>제 목</th><td><input type="text" name="b_title" value="${ breport.b_title }"></td></tr>
	<tr><th>작성자</th>
	<td><input type="text" name="userid" readonly value="${ breport.userid }"></td></tr>
	<tr><th>첨부파일</th>
		<td>
			<!-- 원래 첨부파일이 있는 경우 -->
			<c:if test="${ !empty breport.b_upfile }">
				${ breport.b_upfile } &nbsp; 
				<input type="checkbox" name="delFlag" value="yes"> 파일삭제 <br>
			</c:if>
			<br>
			새로 첨부 : <input type="file" name="upfile">
		</td>
	</tr>
	<tr><th>내 용</th><td><textarea rows="5" cols="50" name="b_content">${ breport.b_content }</textarea></td></tr>
	<tr><th colspan="2">
		<input type="submit" value="수정하기" class="button"> &nbsp; 
		<input type="reset" value="수정취소" class="button"> &nbsp; 
		<button onclick="javascript:history.go(-1); return false;" class="button">이전페이지로 이동</button>
	</th></tr>
</table>
</form>
</c:if>
<!-- 댓글/대댓글 수정 폼 -->
<c:if test="${ breply.b_lev eq 2 }">
<form action="breplyup.do" method="post" >	
	<input type="hidden" name="b_no" value="${ breply.b_no }">
	<input type="hidden" name="b_ref" value="${ breply.b_ref }">
	
<table align="center" width="500" ellspacing="0" 
cellpadding="5">
	<tr><th>제 목</th><td><input type="text" name="b_title" value="${breport.b_title}"></td></tr>
	<tr><th>작성자</th>
	<td><input type="text" name="userid" readonly value="${ breport.userid }"></td></tr>
	
	<tr><th>내 용</th><td><textarea rows="5" cols="50" name="b_content">${ breport.b_content }</textarea></td></tr>
	<tr><th colspan="2">
		<input type="submit" value="수정하기" class="button"> &nbsp; 
		<input type="reset" value="수정취소" class="button"> &nbsp; 
		<button onclick="javascript:history.go(-1); return false;" class="button" style="width:180px;">이전페이지로 이동</button>
	</th></tr>
</table>
</form>
</c:if>
<br>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>