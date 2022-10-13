<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 조건부 메인페이지 네브 모양이 달라야함 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
<style type="text/css">
html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed, 
figure, figcaption, footer, header, hgroup, 
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
	margin: 0;
	padding: 0;
}


header ul {
   list-style-type: none;
   margin: 0;
   padding: 10px;
   overflow: hidden;
   background-color: #333;
   color: white;
}

header li {
   font-weight: 200;
   float: right;
   font-size: 22px;
   margin: 8px;
}

header li a {
   display: block;
   color: white;
   padding: 5px 5px;
   text-align: center;
   text-decoration: none;
   transition: 0.3s;
}

header li a:hover:not(.active) {
   display: block;
   background-color: salmon;
}

header .active {
   font-size: 28px;
}

section {
   text-align: center;
}

section h1 {
   margin-top: 150px;
   font-size: 104px;
   font-weight: 500;
   text-shadow: 2px 2px 8px gray;
   letter-spacing: 3px;
   color: #333;
}

section div {
   font-size: 50px;
   margin: 150px 0;
   letter-spacing: 5px;
}


#menubar > li > a{
	color:white;
	font-size:22px;
}

#menubar > li:first-child > a{
	font-size:28px;
}
</style>
</head>
<body>
   <header>
      <!-- 로그인 안 한 경우 -->
      <c:if test="${ empty sessionScope.loginMember }">
         <ul id = "menubar">
            <li style="float: left"><a class="active" href="main.do">MyGallery</a></li>
            <li><a href="loginPage.do">로그인</a></li>
            <li><a href="pw_find.do">비밀번호찾기</a></li>
            <li><a href="findIDPage.do">아이디찾기</a></li>
            <li><a href="enrollPage.do">회원가입</a></li>
            <li><a href=" ${pageContext.servletContext.contextPath }/nlist.do">공지사항</a></li>
         </ul>
      </c:if>
      <!-- 로그인 한 경우 : 관리자인 경우 -->
      <c:if
         test="${ !empty sessionScope.loginMember and sessionScope.loginMember.useradmin eq 'Y' }">
         <ul id = "menubar">
            <li style="float: left"><a class="active" href="main.do">MyGallery</a></li>
            <li><a href="${ pageContext.servletContext.contextPath }/nlist.do">공지사항관리</a></li>
            <li><a href="${ pageContext.servletContext.contextPath }/blist.do">버그리포트</a></li>
            <li><a href="${ pageContext.servletContext.contextPath }/mlist.do">회원관리</a></li>
            <li><c:url var="callMyinfo" value="/myinfo.do">
                        <c:param name="userid" value="${ loginMember.userid }" />
                   </c:url>
                   <a href="${ callMyinfo }">내정보</a></li>            
            <li><a href="logout.do">로그아웃</a></li>
         </ul>
      </c:if>
      <!-- 로그인 한 경우 : 일반회원인 경우 -->
      <c:if test="${ !empty sessionScope.loginMember and sessionScope.loginMember.useradmin ne 'Y' }">
         <ul id="menubar" >
            <li style="float:left;"><a class="active" href="main.do">MyGallery</a></li>
            <li  style="color:red;"><a href="${ pageContext.servletContext.contextPath }/nlist.do">공지사항</a></li>
            <li><a href="${ pageContext.servletContext.contextPath }/blist.do">버그리포트</a></li>
            <li><c:url var="callMyinfo" value="/myinfo.do">
                        <c:param name="userid" value="${ loginMember.userid }" />
                   </c:url>
                   <a href="${ callMyinfo }">내정보</a></li>
            <li><a href="logout.do">로그아웃</a></li>
         </ul>
      </c:if>
   </header>
</body>
</html>