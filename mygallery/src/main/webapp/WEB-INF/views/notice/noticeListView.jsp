<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="listCount" value="${ requestScope.listCount }" />
<c:set var="startPage" value="${ requestScope.startPage }" />
<c:set var="endPage" value="${ requestScope.endPage }" />
<c:set var="maxPage" value="${ requestScope.maxPage }" />
<c:set var="currentPage" value="${ requestScope.currentPage }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">

	.button {
		width: 160px;
		height: 45px;
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
table {
	width: 900px;
	background-color: gainsboro;
	border-collapse: collapse;
	border-radius: 5px;
	overflow: hidden;
	border:none;
}

.table caption {
	font-size: 20px;
	margin-bottom: 30px;
}

.table tr {
	border-bottom: 1px solid #eee;
}

.table tr:nth-child(odd) {
	background-color: #f1f3f5;
}

.table th, .btable td {
	padding: 16px;
	text-align: center;
}

.table tr th {
	background-color: salmon;
	font-weight:500;
}

.table tr th:first-child {
	border-radius: 5px 0 0 0;
}

.wrap {
	height: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
}

#d1_input:hover {
	background-color:#f8f9fa;
}

.datedate:hover {
	background-color:#f8f9fa;
}

.btn:hover {
	background-color:salomon;
}
</style>

<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	function Change() {
		var key = test.value
		if (key == 1) {
			document.all["d1"].style.display = "block";
			document.all["d2"].style.display = "none";
		}
		if (key == 2) {
			document.all["d1"].style.display = "none";
			document.all["d2"].style.display = "block";
		}
	}

	//글쓰기 버튼 클릭시 실행되는 함수
	function showWriteForm() {
		//게시원글 쓰기 페이지로 이동 처리
		location.href = "${ pageContext.servletContext.contextPath }/nwform.do";
	}
</script>
</head>
<body>
	<!-- 상대경로로 대상 파일의 위치를 지정한 경우 -->
	<c:import url="../common/menubar.jsp" />
	<!-- jstl 에서 절대경로 표기 : /WEB-INF/views/common/menubar.jsp -->
	<br>
	<!-- 목록 출력 영역 -->
	<br>
	<div align="center">
		<button class="button"
			onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/nlist.do';">전체
			목록 조회</button>
			<c:if test="${ sessionScope.loginMember.useradmin eq 'Y' }">
	<button class="button" onclick="javascript:location.href='movewrite.do';">
	공지등록</button>
</c:if>
		</center>
		<br> <br>
		<table class="table" align="center" width="500" border="1"
			cellspacing="0" cellpadding="1">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>등록 날짜</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>첨부파일</th>
			</tr>
			<c:forEach items="${ requestScope.list }" var="n">
				<c:if test="${ n.importance eq 1 }">
					<tr align="center">
				</c:if>
				<c:if test="${ n.importance eq 2 }">
					<tr align="center" bgcolor="gray">
				</c:if>
				<tr align="center">
					<td>${ n.notice_no }</td>
					<!-- 공지제목 클릭시 해당 글의 상세보기로 넘어가게 처리 -->
					<c:url var="ndt" value="/ndetail.do">
						<c:param name="notice_no" value="${ n.notice_no }" />
						<c:param name="page" value="${ currentPage }" />
					</c:url>
					<td><a href="${ ndt }" style="text-decoration:none;">${ n.notice_title }</a></td>
					<td><fmt:formatDate value="${ n.notice_date }"
							pattern="yyyy-MM-dd" /></td>
					<td>${ n.userid }</td>
					<td align="center">${ n.notice_readcount }</td>
					<td style="padding:8px;"><c:if test="${ !empty n.notice_upfile }">◎</c:if> <c:if
							test="${ empty n.notice_upfile }">&nbsp;</c:if></td>
				</tr>
			</c:forEach>
		</table>
	</div>

<center>
<br>
<c:if test="${ empty action }">
<!-- 전체 목록 페이징 처리 -->

<div style="text-align:center;"> <!-- 페이지 표시 영역 -->
	<!-- 1페이지로 이동 처리 -->
	<c:if test="${ currentPage eq 1 }">
		&lt;&lt; &nbsp;
	</c:if>
	<c:if test="${ currentPage > 1 }">
		<c:url var="bl" value="/nlist.do">
			<c:param name="page" value="1" />
		</c:url>
		<a href="${ bl }">&lt;&lt;</a> &nbsp;
	</c:if>
	<!-- 이전 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
		<c:url var="bl2" value="/nlist.do">
			<c:param name="page" value="${ startPage - 10 }" />
		</c:url>
		<a href="${ bl2 }">&lt;</a> &nbsp;
	</c:if>
	<c:if test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
		&lt; &nbsp;
	</c:if>
	<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
	<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
		<c:if test="${ p eq currentPage }">
			<font size="4" ><b>[${ p }]</b>&nbsp;&nbsp;</font>
		</c:if>
		<c:if test="${ p ne currentPage }">
			<c:url var="bl3" value="/nlist.do">
			<c:param name="page" value="${ p }" />
		</c:url>
		<a href="${ bl3 }">${ p }</a> 
		</c:if>
	</c:forEach>
	<!-- 다음 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
		<c:url var="bl4" value="/nlist.do">
			<c:param name="page" value="${ endPage + 10 }" />
		</c:url>
		<a href="${ bl4 }">&gt;</a> &nbsp;
	</c:if>
	<c:if test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
		&gt; &nbsp;
	</c:if>
	<!-- 끝페이지로 이동 처리 -->
	<c:if test="${ currentPage eq maxPage }">
		&gt;&gt; &nbsp; 
	</c:if>
	<c:if test="${ currentPage < maxPage }">
		<c:url var="bl5" value="/nlist.do">
			<c:param name="page" value="${ maxPage }" />
		</c:url>
		<a href="${ bl5 }">&gt;&gt;</a> &nbsp;
	</c:if>
</div>
</c:if>

<!-- ----------------------------------------- -->
<c:if test="${ !empty action }">
<!-- 검색 목록 페이징 처리 -->


<div style="text-align:center;"> <!-- 페이지 표시 영역 -->
	<!-- 1페이지로 이동 처리 -->
	<c:if test="${ currentPage eq 1 }">
		 &lt;&lt; &nbsp;
	</c:if>
	<c:if test="${ currentPage > 1 }">
			<c:if test="${ action eq 'title' }">
				<c:url var="nsl" value="nsearchTitle.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="1" />
				</c:url>
			</c:if>
		
		
			<c:if test="${ action eq 'date' }">
				<c:url var="nsl" value="nsearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="1" />
				</c:url>
			</c:if>
		<a href="${ nsl }">&lt;&lt;</a> &nbsp;
	</c:if>
	<!-- 이전 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
		<c:if test="${ action eq 'title' }">
				<c:url var="nsl" value="nsearchTitle.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ startPage - 10 }" />
				</c:url>
			</c:if>
		
		
		
			<c:if test="${ action eq 'date' }">
				<c:url var="nsl" value="nsearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="${ startPage - 10 }" />
				</c:url>
			</c:if>
		<a href="${ nsl }">&lt;</a> &nbsp;
	</c:if>
	<c:if test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
		&lt; &nbsp;
	</c:if>
	<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
	<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
		<c:if test="${ p eq currentPage }">
			<font size="4" ><b>[${ p }]&nbsp;&nbsp;</b></font>
		</c:if>
		<c:if test="${ p ne currentPage }">
			<c:if test="${ action eq 'title' }">
				<c:url var="nsl" value="nsearchTitle.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ p }" />
				</c:url>
			</c:if>
		
		
		
			<c:if test="${ action eq 'date' }">
				<c:url var="nsl" value="nsearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="${ p }" />
				</c:url>
			</c:if>
			<a href="${ nsl }">${ p }</a> 
		</c:if>
	</c:forEach>
	<!-- 다음 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
		<c:if test="${ action eq 'title' }">
				<c:url var="nsl" value="nsearchTitle.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ endPage + 10 }" />
				</c:url>
			</c:if>
		
		
			<c:if test="${ action eq 'date' }">
				<c:url var="nsl" value="nsearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="${ endPage + 10 }" />
				</c:url>
			</c:if>
		<a href="${ nsl }">&gt;</a> &nbsp;
	</c:if>
	<c:if test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
		&gt; &nbsp;
	</c:if>
	<!-- 끝페이지로 이동 처리 -->
	<c:if test="${ currentPage eq maxPage }">
		&gt;&gt; &nbsp; 
	</c:if>
	<c:if test="${ currentPage < maxPage }">
		<c:if test="${ action eq 'title' }">
				<c:url var="nsl" value="nsearchTitle.do">
					<c:param name="keyword" value="${ keyword }" />
					<c:param name="page" value="${ maxPage }" />
				</c:url>
			</c:if>
		
		
			<c:if test="${ action eq 'date' }">
				<c:url var="nsl" value="nsearchDate.do">
					<c:param name="begin" value="${ begin }" />
					<c:param name="end" value="${ end }" />
					<c:param name="page" value="${ maxPage }" />
				</c:url>
			</c:if>
		<a href="${ nsl }">&gt;&gt;</a> &nbsp;
	</c:if>
</div>
</c:if>	
		<br> 
		<br>
	</center>
	<!-- 항목별 검색 기능 추가 -->
	<div align="center">
		<select id="test" onchange="Change()" style="width: 4rem; height:3rem; border:3px solid  #f8f9fa;position:relative; top:50px;text-align:center; right:260px;">
			<option value="1">제목</option>
			<option value="2">날짜</option>
		</select>
		<div id="d1" style="display: block">
			<form action="nsearchTitle.do" method="get">
				<input type="search" name="keyword" id="d1_input"  style="width: 25rem;height:3rem; border:3px solid #f8f9fa;">
				<input type="submit" value="검색"  style="width: 3rem;height:3rem;border:none; background-color:#f8f9fa; cursor:pointer;" class="btn">
			</form>
		</div>
		<div id="d2" style="display: none">
			<form action="nsearchDate.do" method="get">
				<input type="date" name="begin"  style="width: 12rem;height:2.5rem; border:3px solid #f8f9fa;" class="datedate">
				<input type="date" name="end"  style="width: 12rem;height:2.5rem; border:3px solid #f8f9fa;" class="datedate">
				<input type="submit" value="검색" style="width: 3rem;height:3rem;border:none; background-color:#f8f9fa; cursor:pointer;" class="btn">
			</form>
		</div>
	</div>
	<br>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>







