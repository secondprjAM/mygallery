<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage = "error.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">

        section {
          text-align: center;
        }

        section h1 {
          margin-top: 150px;
          margin-bottom: 20px;
          font-size: 104px;
          font-weight: 500;
          text-shadow: 2px 2px 8px gray;
          letter-spacing: 3px;
          color: #333;
        }

        section div {
          font-size: 50px;
          letter-spacing: 5px;
        }
        
        .btn {
        	width: 150px;
			height: 60px;
			 font-size: 20px;
			letter-spacing: 2px;
			color: white;
			background-color: #333;
			border: none;
			border-radius: 45px;
			cursor: pointer;
			outline: none;
			transition: 0.6s ease-in-out;
			margin:30px 30px;
			margin-bottom:-20px;
        }
        
        .btn:hover {
        	background-color:salmon;
        }
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<br>

  <section>
    <h1>AM:</h1>
    
    <c:if test="${ !empty sessionScope.loginMember and sessionScope.loginMember.useradmin eq 'N' }">
	<c:url var="cal" value = "/mycalendar.do">
	<c:param name="userid" value="${ sessionScope.loginMember.userid }"></c:param>
	</c:url>
	<button type="button"  class="btn"><a href= "${ cal }" style=" color: #fff; text-decoration: none; outline: none">캘린더</a></button>
	
	<c:url var="gal" value = "/gallery.do">
	<c:param name="userid" value="${ sessionScope.loginMember.userid }"></c:param>
	</c:url>
	<button type="button"  class="btn"><a href="${ gal }"  style="color: #fff; text-decoration: none; outline: none">갤러리</a></button>
	</c:if>
    <div>Welcome to MyGallery.</div>
  </section>
  
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>