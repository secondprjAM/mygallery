<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title></title>
<!-- ============================================================================================== -->

<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	function pythonStart() {
		console.log("start");
		$.ajax({
			url : "python.do",
			type : "POST",

			success : function(data) {
				console.log("success : " + data); //Object 로 출력됨
			},

			error : function(jqXHR, textStatus, errorThrown) {
				console.log("error : " + jqXHR + ", " + textStatus + ", "
						+ errorThrown);
			}
		});
	}
</script>




</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />

	<center>
		<h3>Modify Page</h3>
	</center>



	<h3>IMAGES</h3>

	<form action="" method="post">
		<fieldset>
			<c:forEach items="${ requestScope.list }" var="g">
				<c:if test="${ !empty g.img_rename }">
					<input type="checkbox" id="myCheckbox1" value="${g.img_rename}" name="" />
					<label for="myCheckbox1"><img src="resources/gallery/faceImages/${g.img_rename}" width="100" height="100"></label>
				</c:if>
			</c:forEach>
		</fieldset>
	</form>


	<h3>STICKERS</h3>

	<c:forEach items="${ requestScope.slist }" var="g">
		<c:if test="${ !empty g.s_rename }">
			<input type="radio" id="myCheckbox1" value="${g.s_rename}" name="" />
			<label for="myCheckbox1"><img
				src="resources/gallery/stickers/${g.s_rename}" width="100"
				, height="100"></label>
		</c:if>
	</c:forEach>

	
	

	<br>
	<hr>
	<br>
	<center>
		<input type="button" onclick="pythonStart()" value="이미지 편집하기">
	</center>



	<!-- <hr style="clear:both;"> -->
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>