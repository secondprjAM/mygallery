<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<br>
<table align="center" width="500" border="1" cellspacing="0" 
cellpadding="5">
	<tr><th>제 목</th><td>${ notice.notice_title }</td></tr>
	<tr><th>작성자</th><td>${ notice.userid }</td></tr>
	<tr><th>날 짜</th><td>${ notice.notice_date }</td></tr>
	<tr><th>조회수</th><td>${notice.notice_readcount}</td></tr>
	<tr><th>첨부파일</th>
		<td>
			<!-- 첨부파일이 있다면, 파일명 클릭시 다운로드 실행되게 함 -->
			<c:if test="${ !empty notice.notice_upfile }">
				<c:url var="nfd" value="/nfdown.do">
					<c:param name="ofile" value="${ notice.notice_upfile }" />
					<c:param name="rfile" value="${ notice.notice_refile }" />
				</c:url>
				<a href="${ nfd }">${ notice.notice_upfile }</a>
			</c:if>
			<!-- 첨부파일이 없다면 공백으로 처리함 -->
			<c:if test="${ empty notice.notice_upfile }">
				&nbsp;
			</c:if>
		</td>
	</tr>
	<tr><th>내 용</th><td>${ notice.notice_content }</td></tr>
	<tr><th colspan="2">
		<button onclick="javascript:history.go(-1);">목록</button>
		<!-- 수정페이지로 이동 버튼 -->
		<c:url var="movenup" value="/nmoveup.do">
			<c:param name="noticeno" value="${ notice.notice_no }" />			
		</c:url>
		<button onclick="javascript:location.href='${ movenup }';">수정페이지로 이동</button>
		<!-- 삭제하기 버튼 -->
		<c:url var="ndel" value="/ndel.do">
			<c:param name="noticeno" value="${ notice.notice_no }" />
			<c:param name="rfile" value="${ notice.notice_refile }" />
		</c:url>
		<button onclick="javascript:location.href='${ ndel }';">글삭제</button>
	</th></tr>
</table>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>