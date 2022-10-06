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
.button {
  width: 140px;
  height: 45px;
  font-family: 'Roboto', sans-serif;
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 2.5px;
  font-weight: 500;
  color: #000;
  background-color: #FFA7A7;
  border: none;
  border-radius: 45px;
  box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease 0s;
  cursor: pointer;
  outline: none;
  }

.button:hover {
  background-color: #2EE59D;
  box-shadow: 0px 15px 20px rgba(46, 229, 157, 0.4);
  color: #fff;
  transform: translateY(-7px);
}
</style>
</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<hr>
<c:if test="${ breport.b_lev == 2 }">
<h2 align="center">${ breport.b_ref} 번 글에 대한 댓글</h2>
</c:if>
<c:if test="${breport.b_lev == 1 }">
<h2 align="center">${ breport.b_no } 번 게시글 상세보기</h2>
</c:if>
<br>
<table align="center" width="500" border="1" cellspacing="0" 
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
	<tr><th colspan="2">
		<button onclick="javascript:location.href='blist.do?page=${currentPage}';">목록</button>
		&nbsp;
		<!-- 글 작성자가 아닌 로그인 관리자만 댓글달기 기능 제공 -->
		<c:if test="${ !empty requestScope.breport.userid and sessionScope.loginMember.useradmin eq 'Y' and breport.b_lev<2}">
			<c:url var="brf" value="/breplyform.do">
				<c:param name="b_no" value="${ breport.b_no }" />
				<c:param name="page" value="${ currentPage }" />
			</c:url>
			<a href="${ brf }">[댓글달기]</a>
		</c:if>
		<!-- 본인이 등록한 게시글일 때는 수정과 삭제 기능 제공 -->
		<c:if test="${ requestScope.breport.userid eq sessionScope.loginMember.userid }">
			<c:url var="bup" value="/bupview.do">
				<c:param name="b_no" value="${ breport.b_no }" />
				<c:param name="page" value="${ currentPage }" />
			</c:url>
			<a href="${ bup }">[수정페이지로 이동]</a> &nbsp;
			<c:url var="bdl" value="/bdel.do">
				<c:param name="b_no" value="${ breport.b_no }" />
				<c:param name="b_lev" value="${ breport.b_lev }" />
				<c:param name="b_refile" value="${ breport.b_refile }" />
			</c:url>
			<a href="${ bdl }">[글삭제]</a>
		</c:if>
	
	</th></tr>
</table>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>

