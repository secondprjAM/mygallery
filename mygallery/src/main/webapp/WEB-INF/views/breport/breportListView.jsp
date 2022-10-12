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
h2 {
	font-weight:normal;
	margin-top:40px;
}
btable {
	width: 900px;
	background-color: #fff;
	border-collapse: collapse;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
	border-radius: 5px;
	overflow: hidden;
}

.btable caption {
	font-size: 20px;
	margin-bottom: 30px;
}

.btable tr {
	border-bottom: 1px solid #eee;
}

.btable tr:last-child {
	border: none;
}

.btable tr:nth-child(odd) {
	background-color: #ddd;
}

.btable th, .btable td {
	padding: 12px;
	text-align: center;
}

.btable tr th {
	background-color: salmon;
	color: #333;
	font-weight:500;
	}

.btable tr th:first-child {
	border-radius: 5px 0 0 0;
}

.wrap {
	height: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
}

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
	
	a {
		underline: none;
	}
	
	.datedate:hover {
	background-color:#f8f9fa;
	}
</style>
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
function Change(){
	var key = test.value
	 if(key==1){
		 document.all["d1"].style.display="block";
		 document.all["d2"].style.display="none";
		 }
	 if(key==2){
		 document.all["d1"].style.display="none";
		 document.all["d2"].style.display="block";
		 }
}

	$(function() {
		showDiv();

		$('input[name=item]').on("change", function() {
			showDiv();
		});
	});

	function showDiv() {
		if ($('input[name=item]').eq(0).is(":checked")) {
			$("#titleDiv").css("display", "block");
			$("#writerDiv").css("display", "none");
			$("#dateDiv").css("display", "none");
		}
		if ($('input[name=item]').eq(1).is(":checked")) {
			$("#titleDiv").css("display", "none");
			$("#writerDiv").css("display", "none");
			$("#dateDiv").css("display", "block");
		}
	}

	//글쓰기 버튼 클릭시 실행되는 함수
	function showWriteForm() {
		//게시원글 쓰기 페이지로 이동 처리
		location.href = "${ pageContext.servletContext.contextPath }/bwform.do";
	}
</script>
</head>
<body>
	<!-- 상대경로로 대상 파일의 위치를 지정한 경우 -->
	<c:import url="../common/menubar.jsp" />
	<h2 style="text-align:center; margin:50px 0;">버그리포트</h2>

	<!-- 목록 출력 영역 -->
	<!-- => 로그인한 회원만 게시글 등록(쓰기) 버튼이 보이게 함 -->
	<br>
	<div class="wrap" align="right">
		<button class="button"
			onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/blist.do';" class="button" style="margin:0 auto;">전체
			목록 보기</button>
		<c:if
			test="${ !empty sessionScope.loginMember and sessionScope.loginMember.useradmin ne 'Y' }">
			<hr>
			<button class="button" onclick="showWriteForm();">글등록</button>
		</c:if>
	</div>
	<br>
	<table class="btable" align="center" width="1000" style="margin:20px auto;">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>날짜</th>
			<th>조회수</th>
			<th>첨부파일</th>
		</tr>
		<c:forEach items="${ requestScope.list }" var="b">
			<tr>
				<td align="center">${ b.b_no }</td>

				<!-- 게시글제목 클릭시 해당 글의 상세보기로 넘어가게 처리 -->
				<c:url var="bdt" value="/bdetail.do">
					<c:param name="b_no" value="${ b.b_no }" />
					<c:param name="page" value="${ currentPage }" />
				</c:url>
				<td>
					<!-- 제목 글자 앞에 댓글과 대댓글 표시 기호 붙임
				들여쓰기 처리 : 원글과 구분지음
			 --> <c:if test="${ b.b_lev eq 2 }">&nbsp; &nbsp; ▶ </c:if> <c:if
						test="${ b.b_lev eq 3 }">&nbsp; &nbsp; &nbsp; &nbsp; ▶▶ </c:if> <!-- 로그인한 회원만 상세보기 할 수 있게 한다면 -->
					<c:if test="${ !empty sessionScope.loginMember }">
						<a href="${ bdt }" style="text-decoration:none;">${ b.b_title }</a>
					</c:if> <c:if test="${ empty sessionScope.loginMember }">
				${ b.b_title }
			</c:if>
				</td>
				<td align="center">${ b.userid }</td>
				<td align="center"><fmt:formatDate value="${ b.b_date }"
						pattern="yyyy-MM-dd" /></td>
				<td align="center">${ b.b_readcount }</td>
				<td align="center"><c:if test="${ !empty b.b_upfile }">◎</c:if>
					<c:if test="${ empty b.b_refile }">&nbsp;</c:if></td>

			</tr>
		</c:forEach>
	</table>
	<br>
	<!-- 검색 항목 영역 -->
	<div align="center">
		<select id="test" onchange="Change()"  style="width: 4rem; height:3rem; border:3px solid  #f8f9fa;position:relative; top:50px;text-align:center; right:260px;">
			<option value="1">제목</option>
			<option value="2">날짜</option>
		</select>
		<div id="d1" style="display:block">
			<form action="bsearchTitle.do" method="get">
				<input type="search" name="keyword" id="d1_input"  style="width: 25rem;height:3rem; border:3px solid #f8f9fa;"> 
				<input type="submit" value="검색"  style="width: 3rem;height:3rem;border:none; background-color:#f8f9fa; cursor:pointer;" class="btn">
			</form>
		</div>
		<div id="d2" style="display:none">
			<form action="bsearchDate.do" method="get">
				<input type="date" name="begin" style="width: 12rem;height:2.5rem; border:3px solid #f8f9fa;" class="datedate"> 
				<input type="date" name="end" style="width: 12rem;height:2.5rem; border:3px solid #f8f9fa;" class="datedate"> 
				<input type="submit" value="검색" style="width: 3rem;height:3rem;border:none; background-color:#f8f9fa; cursor:pointer;" class="btn">
			</form>
		</div>
	</div>
	<br>
	
<c:if test="${ empty action }">
	<!-- 페이징 처리 -->
	<div style="text-align: center;">
		<!-- 페이지 표시 영역 -->
		<!-- 1페이지로 이동 처리 -->
		<c:if test="${ currentPage eq 1 }">
		&lt;&lt; &nbsp;
	</c:if>
		<c:if test="${ currentPage > 1 }">
			<c:url var="bl" value="/blist.do">
				<c:param name="page" value="1" />
			</c:url>
			<a href="${ bl }">&lt;&lt;</a> &nbsp;
	</c:if>
		<!-- 이전 페이지그룹으로 이동 처리 -->
		<c:if
			test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
			<c:url var="bl2" value="/blist.do">
				<c:param name="page" value="${ startPage - 10 }" />
			</c:url>
			<a href="${ bl2 }">&lt;</a> &nbsp;
	</c:if>
		<c:if
			test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
		&lt; &nbsp;
	</c:if>
		<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
		<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
			<c:if test="${ p eq currentPage }">
				<font size="3" color="black"><b>[${ p }]</b></font>
			</c:if>
			<c:if test="${ p ne currentPage }">
				<c:url var="bl3" value="/blist.do">
					<c:param name="page" value="${ p }" />
				</c:url>
				<a href="${ bl3 }">${ p }</a> &nbsp;
			</c:if>
		</c:forEach>
		<!-- 다음 페이지그룹으로 이동 처리 -->
		<c:if
			test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
			<c:url var="bl4" value="/blist.do">
				<c:param name="page" value="${ endPage + 10 }" />
			</c:url>
			<a href="${ bl4 }">&nbsp;&nbsp;&gt;</a> &nbsp;
	</c:if>
		<c:if
			test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
		&nbsp;&nbsp;&gt; &nbsp;
	</c:if>
		<!-- 끝페이지로 이동 처리 -->
		<c:if test="${ currentPage eq maxPage }">
		&gt;&gt; &nbsp; 
	</c:if>
		<c:if test="${ currentPage < maxPage }">
			<c:url var="bl5" value="/blist.do">
				<c:param name="page" value="${ maxPage }" />
			</c:url>
			<a href="${ bl5 }">&gt;&gt;</a> &nbsp;
	</c:if>
	</div>
</c:if>
	<!-- 검색 항목 별 페이징 처리 -->



	<c:if test="${ !empty action }">
		<!-- 검색 목록 페이징 처리 -->


		<div style="text-align: center;">
			<!-- 페이지 표시 영역 -->
			<!-- 1페이지로 이동 처리 -->
			<c:if test="${ currentPage eq 1 }">
		 &lt;&lt; &nbsp;
	</c:if>
			<c:if test="${ currentPage > 1 }">
				<c:if test="${ action eq 'title' }">
					<c:url var="bsl" value="nsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="1" />
					</c:url>
				</c:if>


				<c:if test="${ action eq 'date' }">
					<c:url var="bsl" value="bsearchDate.do">
						<c:param name="begin" value="${ begin }" />
						<c:param name="end" value="${ end }" />
						<c:param name="page" value="1" />
					</c:url>
				</c:if>
				<a href="${ bsl }">&lt;&lt;</a> &nbsp;
	</c:if>
			<!-- 이전 페이지그룹으로 이동 처리 -->
			<c:if
				test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
				<c:if test="${ action eq 'title' }">
					<c:url var="bsl" value="bsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ startPage - 10 }" />
					</c:url>
				</c:if>

				<c:if test="${ action eq 'date' }">
					<c:url var="bsl" value="bsearchDate.do">
						<c:param name="begin" value="${ begin }" />
						<c:param name="end" value="${ end }" />
						<c:param name="page" value="${ startPage - 10 }" />
					</c:url>
				</c:if>
				<a href="${ bsl }">&lt;</a> &nbsp;
	</c:if>
			<c:if
				test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
		&lt; &nbsp;
	</c:if>
			<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
			<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
				<c:if test="${ p eq currentPage }">
					<font size="4" ><b>[${ p }]</b></font>
				</c:if>
				<c:if test="${ p ne currentPage }">
					<c:if test="${ action eq 'title' }">
						<c:url var="bsl" value="bsearchTitle.do">
							<c:param name="keyword" value="${ keyword }" />
							<c:param name="page" value="${ p }" />
						</c:url>
					</c:if>

					<c:if test="${ action eq 'date' }">
						<c:url var="bsl" value="bsearchDate.do">
							<c:param name="begin" value="${ begin }" />
							<c:param name="end" value="${ end }" />
							<c:param name="page" value="${ p }" />
						</c:url>
					</c:if>
					<a href="${ bsl }">${ p }</a>
				</c:if>
			</c:forEach>
			<!-- 다음 페이지그룹으로 이동 처리 -->
			<c:if
				test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
				<c:if test="${ action eq 'title' }">
					<c:url var="bsl" value="bsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ endPage + 10 }" />
					</c:url>
				</c:if>


				<c:if test="${ action eq 'date' }">
					<c:url var="bsl" value="bsearchDate.do">
						<c:param name="begin" value="${ begin }" />
						<c:param name="end" value="${ end }" />
						<c:param name="page" value="${ endPage + 10 }" />
					</c:url>
				</c:if>
				<a href="${ bsl }">&nbsp;&gt;</a> &nbsp;
	</c:if>
			<c:if
				test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
		&nbsp;&nbsp;&gt; &nbsp;
	</c:if>
			<!-- 끝페이지로 이동 처리 -->
			<c:if test="${ currentPage eq maxPage }">
		&gt;&gt; &nbsp; 
	</c:if>
			<c:if test="${ currentPage < maxPage }">
				<c:if test="${ action eq 'title' }">
					<c:url var="bsl" value="bsearchTitle.do">
						<c:param name="keyword" value="${ keyword }" />
						<c:param name="page" value="${ maxPage }" />
					</c:url>
				</c:if>

				<c:if test="${ action eq 'date' }">
					<c:url var="bsl" value="bsearchDate.do">
						<c:param name="begin" value="${ begin }" />
						<c:param name="end" value="${ end }" />
						<c:param name="page" value="${ maxPage }" />
					</c:url>
				</c:if>
				<a href="${ bsl }">&gt;&gt;</a> &nbsp;
	</c:if>
		</div>
	</c:if>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>







