	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
form.sform {
	display: none;  /* 안 보이게 설정 */
	background: lightgrey;
}
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">

$(function(){
	//작성된 이벤트 실행 코드는 이벤트가 발생될 때까지 대기상태가 됨
	//jQuery('태그선택자').실행할메소드(전달값, ......);
	$('input[name=item]').on('change', function(){
		//change 이벤트가 발생한 radio 와 연결된 폼만 보여지게 하고,
		//나머지 폼들은 안보이게 처리함
		$('input[name=item]').each(function(index){
			//해당 index 번째 radio 가 checked 인지 확인하고
			if($(this).is(':checked')){
				$('form.sform').eq(index).css('display', 'block');
			}else{
				$('form.sform').eq(index).css('display', 'none');
			}
		});
	});
});
//로그인 제한/가능 라디오 체크가 변경되었을 때 실행되는 함수
function changeLogin(element){
	//선택한 radio의 name 속성의 이름에서 userid 분리 추출함
	var userid = element.name.substring(12);
	console.log("changeLogin : " + userid);
	if(element.checked == true && element.value == "N"){
		//로그인 제한을 체크했다면
		console.log("로그인 제한 체크함");
		location.href = "${ pageContext.servletContext.contextPath }/loginok.do?userid=" + userid + "&userloginok=N";
	}else{
		console.log("로그인 제한 해제함");
		location.href = "${ pageContext.servletContext.contextPath }/loginok.do?userid=" + userid + "&userloginok=Y";
	}
} 
</script>
<style type="text/css">
h2 {
	font-weight:normal;
	margin:50px 0 ;
}

form.sform {
   display: none;  /* 안 보이게 설정 */
}

.table {
   width: 900px;
    background-color: #f1f3f5;
   border-collapse: collapse;
   border-radius: 5px;
   overflow: hidden;
   border:1px solid #f1f3f5;
}
.table caption {
   font-size: 20px;
   margin-bottom: 30px;
}

.table tr {
   border-bottom: 1px solid #eee;
   text-align:center;
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

.button {
		width: 150px;
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
	
	.search {
		background-color:white; 
	}
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<h2 align="center"  style="margin:50px 0 ;" >회원 조회</h2>
<!-- 조회해 온 회원 리스트 정보 출력 처리 -->
<div align="center">
 <button onclick="javascript:location.href='${ pageContext.servletContext.contextPath }/mlist.do';"  class="button">전체 목록 조회</button> 
<br><br>
<table class="table" align="center" width="500" border="1" cellspacing="0" cellpadding="3">
	<tr>
		<th>아이디</th>
		<th>회원 이름</th>
		<th>이메일</th>
		<th>성별</th>
		<th>로그인 제한여부</th>
	</tr>
	<c:forEach items="${ requestScope.list }" var="m">
	<tr>
		<td  style="padding:8px 0;">${ m.userid }</td>
		<td>${ m.username }</td>
		<td>${ m.useremail }</td>
		<td>${ m.usergender eq 'M'? "남" : "여" }</td>
		<td>
		<c:if test="${ m.userloginok eq 'Y' }">
				<input type="radio" name="userloginok_${ m.userid }" value="Y" checked onchange="changeLogin(this);"> 가능 
				<input type="radio" name="userloginok_${ m.userid }" value="N" onchange="changeLogin(this);"> 제한 &nbsp;
			</c:if>
			<c:if test="${ m.userloginok eq 'N' }">
				<input type="radio" name="userloginok_${ m.userid }" value="Y" onchange="changeLogin(this);"> 가능
				<input type="radio" name="userloginok_${ m.userid }" value="N" checked onchange="changeLogin(this);"> 제한 &nbsp;
			</c:if>
		</td>
	</tr>
	</c:forEach>
</table>
</div>
<center>


<br>
<!-- 페이징 처리 -->
<div style="text-align:center;"> <!-- 페이지 표시 영역 -->
	
	<!-- 이전 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage - 10) < startPage and (currentPage - 10) > 1 }">
		<c:url var="ml2" value="/mlist.do">
			<c:param name="page" value="${ startPage - 10 }" />
		</c:url>
		<a href="${ ml2 }">＜</a> &nbsp;
	</c:if>
	<c:if test="${ !((currentPage - 10) < startPage and (currentPage - 10) > 1) }">
		＜&nbsp;
	</c:if>
	<!-- 현재 페이지가 속한 페이지 그룹 페이지 숫자 출력 -->
	<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
		<c:if test="${ p eq currentPage }">
			<font size="4"><b>[${ p }]</b></font>
		</c:if>
		<c:if test="${ p ne currentPage }">
			<c:url var="ml3" value="/mlist.do">
			<c:param name="page" value="${ p }" />
		</c:url>
		<a href="${ ml3 }">${ p }</a> 
		</c:if>
	</c:forEach>
	<!-- 다음 페이지그룹으로 이동 처리 -->
	<c:if test="${ (currentPage + 10) > endPage and (currentPage + 10) < maxPage }">
		<c:url var="ml4" value="/mlist.do">
			<c:param name="page" value="${ endPage + 10 }" />
		</c:url>
		<a href="${ ml4 }"> ＞</a> &nbsp;
	</c:if>
	<c:if test="${ !((currentPage + 10) > endPage and (currentPage + 10) < maxPage) }">
		&nbsp;＞&nbsp;
	</c:if>
</div>


	<br><br>
	<!-- 항목별 검색 기능 추가 -->
	<div class="container">
		<div class="search">
			<form method="post" name="search" action="msearch.do" class="search">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="action"  style="width: 10rem; height:3rem; border:3px solid  #f1f3f5; ">
								<option value="0">검색 선택</option>
								<option value="userid">아이디 검색(부분검색 허용)</option>
								<option value="userloginok">로그인 제한 여부(대문자 Y, N)</option>
						</select></td>
						<td><input type="text" class="form-control"
							placeholder="검색" name="keyword" maxlength="100" style="width: 25rem;height:2.7rem; border:3px solid #f8f9fa;"></td>
							
						<td><input type="submit" class="btn btn-success"  value="검색" style="width: 4rem; height:3rem; border:3px solid  #f8f9fa; cursor:pointer;"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
<!-- 검색 항목 제공 끝 -->
	<br>
	<!-- 회원아이디로 검색 폼 -->
	<form action="${ pageContext.servletContext.contextPath }/msearch.do" 
	method="post" id="idform" class="sform">
		<input type="text" name="action" value="id">
		<input type="text" name="keyword"> &nbsp; 
		<input type="submit" value="검색">
	</form>
	<!-- 로그인제한/가능 여부로 검색 폼 -->
	<form action="${ pageContext.servletContext.contextPath }/msearch.do" 
	method="post" id="lokform" class="sform">
		<input type="text" name="action" value="userloginok">
		<input type="text" name="keyword" value="Y"> 로그인 가능 회원 &nbsp; 
		<input type="text" name="keyword" value="N"> 로그인 제한 회원 &nbsp; 
		<input type="submit" value="검색">
	</form>
</center>


<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
