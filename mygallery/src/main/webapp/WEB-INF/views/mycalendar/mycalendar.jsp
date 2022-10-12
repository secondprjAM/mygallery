<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="ko">
<head>
<title>캘린더</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">

<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/modal.js"></script>
<script type="text/javascript"
	src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${ pageContext.servletContext.contextPath }/resources/js/modal.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function modalOpen2(date, schedule,filename) {
		$("#date.body-date").val(date);
		$("#contents.body-contents").val(schedule);
		if(filename==""){
			content= '<input witdh = "50px" type="text" value="등록된 이미지가 없습니다." readonly>';
		}else{
			content = '<img width = "90%" height="auto" src="resources/gallery/faceImages/' + filename +'">';
		}
		$("#imgBox").html(content);
	}
	function showWriteForm(userid) {
		location.href = "${ pageContext.servletContext.contextPath }/calmovewrite.do?userid="+userid;
	}
	function updateCalForm(){
		var sedate = $("#date.body-date").val();
		var userid = $("#userid.userid").val();
		console.log(sedate);
		console.log(userid);
		location.href="${ pageContext.servletContext.contextPath }/calmoveup.do?userid="+userid+"&date="+sedate;
	}
	function deleteCalForm(){
		var sedate = $("#date.body-date").val();
		var userid = $("#userid.userid").val();
		location.href="${ pageContext.servletContext.contextPath }/deleteCal.do?userid="+userid+"&date="+sedate;
	}
</script>
<style TYPE="text/css">
body {
	scrollbar-face-color: #F6F6F6;
	scrollbar-highlight-color: #bbbbbb;
	scrollbar-3dlight-color: #FFFFFF;
	scrollbar-shadow-color: #bbbbbb;
	scrollbar-darkshadow-color: #FFFFFF;
	scrollbar-track-color: #FFFFFF;
	scrollbar-arrow-color: #bbbbbb;
	margin-left: "0px";
	margin-right: "0px";
	margin-top: "0px";
	margin-bottom: "0px";
}

td {
	font-family: "돋움";
	font-size: 9pt;
	color: #595959;
}

th {
	font-family: "돋움";
	font-size: 9pt;
	color: #000000;
}

select {
	font-family: "돋움";
	font-size: 9pt;
	color: #595959;
}

.divDotText {
	overflow: hidden;
	text-overflow: ellipsis;
}

A:link {
	font-size: 9pt;
	color: #000000;
	text-decoration: none;
}

A:visited {
	font-size: 9pt;
	font-family: "돋움";
	color: #000000;
	text-decoration: none;
}

A:active {
	font-size: 9pt;
	font-family: "돋움";
	color: red;
	text-decoration: none;
}

A:hover {
	font-size: 9pt;
	color: gainsboro;
	text-decoration: none;
	transition: 0.6s;
}

.day {
	width: 50px;
	height: 30px;
	font-weight: bold;
	font-size: 15px;
	font-weight: bold;
	text-align: center;
}

.sat {
	color: #529dbc;
}

.sun {
	color: red;
}

.today_button_div, .add_button_div {
	float: right;
}

.today_button {
	width: 50px;
	height: 30px;
}

.calendar {
	width: 80%;
	margin: auto;
}

.navigation {
	margin-top: 100px;
	margin-bottom: 30px;
	text-align: center;
	font-size: 25px;
	vertical-align: middle;
}

.calendar_body {
	width: 100%;
	height: 850px;
	background-color: #FFFFFF;
	/* border: 1px solid white; */
	margin-bottom: 50px;
	border-collapse: collapse;
}

.calendar_body .today {
	width: 100px;
	height: 120px;
	border: 2px solid #80808047;
	/* background-color: #fa80726e; */
	text-decoration:underline salmon 3px;
	text-align: left;
	vertical-align: top;
}

.calendar_body .date {
	width: 100px;
	font-weight: bold;
	font-size: 15px;
	padding-left: 3px;
	padding-top: 3px;
}

.calendar_body .sat_day {
	width: 100px;
	height: 120px;
	border: 2px solid #80808047;
	text-align: left;
	vertical-align: top;
}

.calendar_body .sat_day .sat {
	width: 100px;
	color: #529dbc;
	font-weight: bold;
	font-size: 15px;
	padding-left: 3px;
	padding-top: 3px;
}

.calendar_body .sun_day {
	width: 100px;
	
	border: 2px solid #80808047;
	background-color: white;
	text-align: left;
	vertical-align: top;
}

.calendar_body .sun_day .sun {
	width: 100px;
	font-weight: bold;
	font-size: 15px;
	padding-left: 3px;
	padding-top: 3px;
}

.calendar_body .normal_day {
width: 100px;
	border: 2px solid #80808047;
	height: 120px;
	vertical-align: top;
	text-align: left;
}

.before_after_month {
	margin: 10px;
	padding:10px;
	font-weight: bold;
	color: #333;
	padding: 10px 7px;
	transition: 0.6s;
	border-radius: 45%;
	border: none
}

.before_after_month:hover {
	color: white;
	background-color: salmon;
}

.before_after_year {
	font-weight: bold;
}

.this_month {
	margin: 10px;
}

.month, .write_btn {
	margin: 10px;
	color: #333;
	padding: 10px 7px;
	transition: 0.6s;
	border-radius: 45%;
	border: none;
}

.month:hover, .write_btn:hover {
	color: white;
	background-color: salmon;
}

        footer{
           /* position : absolute;
         bottom : 0; */
         width:100%;
            margin-top: 100px;
            padding-top: 50px;
            background-color: #333;
            height: 150px;
            text-align: center;
            color: white;
            font-weight: 200;
        }

</style>


</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<jsp:include page="./modal.jsp"></jsp:include>
	<form name="calendarFrm" id="calendarFrm" action="" method="GET" >
		<div class="calendar">
			<!--날짜 네비게이션  -->
			<div class="navigation">
				<a class="before_after_year"
					href="./mycalendar.do?year=${today_info.search_year-1}&month=${today_info.search_month-1}&userid=${sessionScope.loginMember.userid}">
					&lt;&lt; <!-- 이전해 -->
				</a>
				
					<a class="before_after_month"
						href="./mycalendar.do?year=${today_info.before_year}&month=${today_info.before_month}&userid=${sessionScope.loginMember.userid}">
						before <!-- 이전달 -->
					</a>
				<span class="this_month"> &nbsp;${today_info.search_year}. <c:if
						test="${today_info.search_month<10}">0</c:if>${today_info.search_month}
					<!-- 이번달 -->
				</span>
				
					<a class="before_after_month"
						href="./mycalendar.do?year=${today_info.after_year}&month=${today_info.after_month}&userid=${sessionScope.loginMember.userid}">
						after <!-- 다음달 -->
					</a>
				

				<a class="before_after_year"
					href="./mycalendar.do?year=${today_info.search_year+1}&month=${today_info.search_month-1}&userid=${sessionScope.loginMember.userid}">
					<!-- 다음해 --> &gt;&gt;
				</a>
			</div>

			<!-- 현재 날짜로 돌아가기 버튼 생성 완료 -->
			<div class="today_button_div">
				<button type="button" class="month"
					onclick="location.href='mycalendar.do?userid=${sessionScope.loginMember.userid}'"
					style="height: 30ps; width: 80px; font-weight: bold;">today</button>
			</div>
			<!-- 글쓰기용 버튼 -->
			<div class="today_button_div" style="display: inline-block;">
				<button type="button" class="write_btn" onclick="showWriteForm('${sessionScope.loginMember.userid}');"
					style="height: 30ps; width: 80px; font-weight: bold;">write</button>
			</div>
			<table class="calendar_body" align="center">
				<thead>
					<tr style="border: 2px solid #80808047; background-color:#fa80726e;">
						<td class="day sun">일</td>
						<td class="day">월</td>
						<td class="day">화</td>
						<td class="day">수</td>
						<td class="day">목</td>
						<td class="day">금</td>
						<td class="day sat">토</td>
					</tr>
				</thead>
				<tbody>
					
						<c:forEach var="dateList" items="${dateList}" varStatus="date_status">
							<c:choose>
								<c:when test="${dateList.value=='today'}">
									<td class="today">
										<div class="date">
											${ dateList.date }
											<c:if test="${ !empty dateList.schedule_detail }">
												<div style="padding-left: 50px;">
													<a data-toggle="modal" data-target="#myModal"
													onclick="modalOpen2('${ dateList.schedule_date }' , '${ dateList.schedule_detail }', '${ dateList.imgName }');">
														<img height="120" width="100" src="resources/gallery/faceImages/${ dateList.imgName }">
													</a>
												</div>
											</c:if>
											
										</div>
									</td>
								</c:when>
								<c:when test="${date_status.index%7==6}">
									<td class="sat_day">
										<div class="sat">
										${ dateList.date }
										<c:if test="${ !empty dateList.schedule_detail }">
												<div style="padding-left: 50px;">
													<a data-toggle="modal" data-target="#myModal"
															onclick="modalOpen2('${ dateList.schedule_date }' , '${ dateList.schedule_detail }', '${ dateList.imgName }');">
															<img height="120" width="100" src="resources/gallery/faceImages/${ dateList.imgName }">
													</a>
												</div>
										</c:if>
										</div>
									</td>
								</c:when>
								<c:when test="${date_status.index%7==0}">
					</tr>
					<tr>
						<td class="sun_day">
							<div class="sun">
								${dateList.date}
								<c:if test="${ !empty dateList.schedule_detail }">
									<div class="modal-dialog">
									</div>
									<div style="padding-left: 50px;">
										<a data-toggle="modal" data-target="#myModal"
												onclick="modalOpen2('${ dateList.schedule_date }' , '${ dateList.schedule_detail }', '${ dateList.imgName }');">
												<img height="120" width="100" src="resources/gallery/faceImages/${ dateList.imgName }">
										</a>
									</div>
								</c:if>
							</div>
							<div></div>
						</td>
					</c:when>
						<c:otherwise>
							<td class="normal_day">
								<div class="date">
									${dateList.date}
									<c:if test="${ !empty dateList.schedule_detail }">
										<div class="modal-dialog">
										</div>
										<div style="padding-left: 50px;">
										<a data-toggle="modal" data-target="#myModal"
												onclick="modalOpen2('${ dateList.schedule_date }' , '${ dateList.schedule_detail }', '${ dateList.imgName }');">
												<img height="120" width="100" src="resources/gallery/faceImages/${ dateList.imgName }">
										</a>
										</div>
									</c:if>
								</div>
								<div></div>
							</td>
						</c:otherwise>
						</c:choose>
						</c:forEach>
				
				</tbody>

			</table>
		</div>
	</form>
<%-- <c:import url="/WEB-INF/views/common/footer.jsp" /> --%>
<footer>
 <br>
 <br>
 Copyright ©AM: Project By MyGallery. <br><br>
        팀장:문창기, 강처치, 김영재, 권혜영, 서보경, 선도원
</footer>
</body>
</html>
