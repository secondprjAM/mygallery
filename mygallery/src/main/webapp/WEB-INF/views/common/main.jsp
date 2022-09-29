<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage = "error.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
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
</style>
</head>
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp"/>
<section>
    <h1>AM:</h1>
    <div>welcom to MyGallery.</div>
</section>

<hr style="clear:both;">
<c:import url="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>