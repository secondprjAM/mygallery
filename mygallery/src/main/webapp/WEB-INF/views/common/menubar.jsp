
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #333;
        }

        li {
            font-weight: 200;
            float: right;
            font-size: 22px;
        }

        li a {
        display: block;
        margin-top: 5px;
        color: white;
        text-align: center;
        padding: 16px 16px;
        text-decoration: none;
        transition: 0.3s;
        }

        li a:hover:not(.active) {
        background-color: salmon;
        }

        .active {
        font-weight: 300;
        font-size: 28px;
        }
</style>
</head>
<body>
    <!-- 로그인 안 한 경우 -->
	<c:if test="${ empty sessionScope.loginMember }">
		<ul id="menubar">
			<li><a href="loginPage.do">로그인</a></li>
			<li><a href="#">아이디찾기</a></li>
			<li><a href="#">비밀번호찾기</a></li>
			<li><a href="enrollPage.do">회원가입</a></li>
		</ul>
	</c:if>
	<!-- 로그인 한 경우 : 관리자인 경우 -->
	<c:if test="${ !empty sessionScope.loginMember and sessionScope.loginMember.useradmin eq 'Y' }">
		<ul id="menubar">
			<li><a href="#">공지사항관리</a></li>
			<li><a href="#">게시글관리</a></li>
			<li><a href="#">회원관리</a></li>
			<li><a href="logout.do">로그아웃</a></li>
			<li><a href="${ pageContext.servletContext.contextPath }/main.do">홈</a></li>
		</ul>
	</c:if>
	<!-- 로그인 한 경우 : 일반회원인 경우 -->
	<c:if test="${ !empty sessionScope.loginMember and sessionScope.loginMember.useradmin ne 'Y' }">
		<ul id="menubar">
			<li><a href="#">공지사항</a></li>
			<li><a href="#">게시글</a></li>
			<li><a href="#">QnA</a></li>
			<li><a href="logout.do">로그아웃</a></li>
			<li><a href="${ pageContext.servletContext.contextPath }/main.do">홈</a></li>
		</ul>
	</c:if>
      
      
</body>
</html> 