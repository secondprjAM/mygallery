<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentPage" value="${ requestScope.currentPage }" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
.table, .btable {
		 margin:50px auto;
}
h2 {
	font-weight:normal;
	margin:50px auto;
}
	th {
		font-weight:normal;
		font-size: 16px;
	}
	
	td {
		width: 25rem;
		height:3rem; 
		border:3px solid #f8f9fa; 
		margin:20px 0;
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
a{text-decoration:none; color:#333;}</style>
</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<c:if test="${ breport.b_lev == 2 }">
<h2 align="center">${ breport.b_ref} 번 글에 대한 댓글</h2>
</c:if>
<c:if test="${breport.b_lev == 1 }">
<h2 align="center"  style="padding-top:40px;">${ breport.b_no } 번 게시글 상세보기</h2>
</c:if>
<br>
<table class="table" align="center" width="500" border="0" cellspacing="1"  class="table"
cellpadding="5">
	<tr><th>제 목</th><td>${ breport.b_title }</td></tr>
	<tr><th>작성자</th><td>${ breport.userid }</td></tr>
	<tr><th>날 짜</th>
	   <td><fmt:formatDate value="${ breport.b_date }" type="date" pattern="yyyy-MM-dd" /></td>
	</tr>
	<tr><th>첨부파일</th>
		<td>
			<!-- 첨부파일이 있다면, 파일명 클릭시 다운로드 실행되게 함 -->
			<c:if test="${ !empty breport.b_upfile }">
				<c:url var="bfd" value="/bfdown.do">
					<c:param name="ofile" value="${ breport.b_upfile }" />
					<c:param name="rfile" value="${ breport.b_refile }" />
				</c:url>
				<a href="${ bfd }">${ breport.b_upfile }</a>
			</c:if>
			<!-- 첨부파일이 없다면 공백으로 처리함 -->
			<c:if test="${ empty breport.b_upfile }">
				&nbsp;
			</c:if>
		</td>
	</tr>
	<tr><th>내 용</th><td>${ breport.b_content }</td></tr>
</table>
<br>
<div align="center">
		<!-- 글 작성자가 아닌 로그인 관리자만 댓글달기 기능 제공 -->
		<c:if test="${ !empty requestScope.breport.userid and sessionScope.loginMember.useradmin eq 'Y' and breport.b_lev<2}">
			<c:url var="brf" value="/breplyform.do">
				<c:param name="b_no" value="${ breport.b_no }" />
				<c:param name="page" value="${ currentPage }" />
			</c:url>
			<button class="button"><a href="${ brf }" style="text-decoration:none; color:#333;">댓글달기</a></button>
		</c:if>
		<!-- 본인이 등록한 게시글일 때는 수정과 삭제 기능 제공 -->
		<c:if test="${ requestScope.breport.userid eq sessionScope.loginMember.userid }">
			<c:url var="bup" value="/bupview.do">
				<c:param name="b_no" value="${ breport.b_no }" />
				<c:param name="page" value="${ currentPage }" />
			</c:url>
			<button class="button" style="width:180px;"><a href="${ bup }"  style="text-decoration:none; color:#333; ">수정페이지로 이동</a></button> &nbsp;
			<c:url var="bdl" value="/bdel.do">
				<c:param name="b_no" value="${ breport.b_no }" />
				<c:param name="b_lev" value="${ breport.b_lev }" />
				<c:param name="b_refile" value="${ breport.b_refile }" />
			</c:url>
			<button class="button"><a href="${ bdl }" style="text-decoration:none; color:#333;">글삭제</a></button>
		</c:if>
&nbsp;
<button class="button" onclick="javascript:location.href='blist.do?page=${currentPage}';">목록</button>

</div>

<br>
<table class="btable" align="center" width="500" border="0" cellspacing="1" 
cellpadding="5">
	<tr><td  style="border:none; font-weight:bold;font-size:20px;">${ breply.b_title }</td><td>${ breply.userid }</td>
	<td><fmt:formatDate value="${ breply.b_date }" type="date" pattern="yyyy-MM-dd" /></td></tr>
	<tr><td colspan="3" style="border:1px solide gray;">${ breply.b_content }</td></tr>
	<tr style="border:none;text-align:center"><td colspan="3">
	<!-- 본인이 등록한 게시글일 때는 수정과 삭제 기능 제공 -->
		<c:if test="${ requestScope.breply.userid eq sessionScope.loginMember.userid }">
			<c:url var="bup" value="/bupviewreply.do">
				<c:param name="b_no" value="${ breport.b_no }" />
				<c:param name="page" value="${ currentPage }" />
			</c:url>
			<button class="button"><a href="${ bup }" style="text-decoration:none; color:#333;">수정하기</a></button> &nbsp;
			<button class="button"><c:url var="bdl" value="/bdel.do"></button> 
				<c:param name="b_no" value="${ breply.b_no }" />
				<c:param name="b_lev" value="${ breply.b_lev }" />
			</c:url> &nbsp;
			<a href="${ bdl }">[글삭제]</a> 
		</c:if>
	</td></tr>
</table>



<c:import url="/WEB-INF/views/common/footer2.jsp" />
</body>
</html>

