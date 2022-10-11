<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
function isSame(){
	//전송보내기 전(submit 버튼 클릭시) 입력값 유효한 값인지 검사
	
	//암호와 암호확인이 일치하는지 확인
	var pwd1 = document.getElementById("upwd1").value;
	var pwd2 = document.getElementById("upwd2").value;
	
	if(pwd1 !== pwd2){
		
		document.getElementById("same").innerHTML="암호와 암호 확인의 값이 일치하지 않습니다.<br>다시 입력하세요.";
		document.getElementById("userpassword").select();
		return false;  //전송 안 함
	}
	
	return true; //전송함
}
</script>
</head>
<body>
<form action="resetpwd.do" method="POST" class="content" onsubmit="return isSame();">
	<input type="text" name="userid" value="${ member.userid }" readonly>
	<div class="textbox">
		<label>새비밀번호
			<input id="upwd1" name="userpassword" type="password" required>
		</label>
	</div>
	<div class="textbox">
		<label>새비밀번호 확인
			<input id="upwd2" type="password" required>
		</label>
	</div>
	<span id=same></span>
	<br><br>
	<input type="submit" id="check" value="비밀번호변경">

</form>
</body>
</html>