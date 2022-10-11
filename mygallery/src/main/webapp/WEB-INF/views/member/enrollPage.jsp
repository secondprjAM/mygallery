<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="<c:url value="/resources/css/common.css" />">
<style type="text/css">
th {
	font-size: 10pt;
	margin: 0;
	align: left;
	margin-top: 10px;
}

td{
	margin: 100px;
}

.input-group-addon {
	margin-left: -30px;
}

table{
	background-color: #f8f9fa;
	padding: 20px;
	border-spacing: 0 20px;
}

form {
    margin-top: -200px;
    align: center;
    width: 100%;
    height: 100%;
}

.from-button{
	width: 5rem;
	height: 1.5rem;
	border: 0px;
	background-color: #f8f9fa;
	cursor: pointer;
}

a {
  text-decoration: none;
}

.startPage:link {
  color : black;
}
.startPage:visited {
  color : black;
}
.startPage:hover {
  color : black;
}
.startPage:active {
  color : black;
}
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">

//아이디 중복 체크 확인을 위한 ajax 실행 처리용 함수
//ajax(Asynchronous Javascript And Xml) : 
//페이지를 바꾸지 않고, 서버와 통신하는 기술임 
//(서버측에 서비스 요청하고 결과받음)
function dupCheckId(){
	//입력된 아이디가 중복되지 않았는지 확인 : jQuery.ajax() 사용
	//jQuery 는 $ 로 줄일 수 있음
	//jQuery.ajax(); => $.ajax();
	if($("#userid").val() == ''){
		alert('아이디를 작성해주세요')
	}else{
		$.ajax({
			url: "idchk.do",
			type: "post",
			data: { userid: $("#userid").val() },
			success: function(data){
				console.log("success : " + data);
				if(data == "ok"){
					alert("사용 가능한 아이디입니다.");
					$("#upwd1").focus();
				}else{
					alert("이미 사용중인 아이디입니다.\n다시 입력하세요.");
					$("#userid").select();
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				console.log("error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
			}
		});
	}
	
	return false;  //클릭 이벤트 전달을 막음
}

function validate(){
	//전송보내기 전(submit 버튼 클릭시) 입력값 유효한 값인지 검사
	
	//암호와 암호확인이 일치하는지 확인
	var pwd1 = document.getElementById("upwd1").value;
	var pwd2 = document.getElementById("upwd2").value;
	
	if(pwd1 !== pwd2){
		alert("암호와 암호 확인의 값이 일치하지 않습니다.\n"
				+ "다시 입력하세요.");
		document.getElementById("upwd1").select();
		return false;  //전송 안 함
	}
	
	return true; //전송함
}
function emailCK(){
	// const eamil = $('#useremail').val() + $('#userEmail2').val(); // 이메일 주소값 얻어오기!
	// console.log('완성된 이메일 : ' + eamil); // 이메일 오는지 확인
	console.log('완성된 이메일 : ' + $('#useremail').val()); // 이메일 오는지 확인
	const checkInput = $('.mail-check-input'); // 인증번호 입력하는곳 

	
	if ($('#useremail').val() != null){
		$.ajax({
			type : 'get',
			//url : '<c:url value ="/MemberController/mailCheck?email="/>'+eamil, // GET방식이라 Url 뒤에 email을 뭍힐수있다.
			url : '<c:url value ="/mailCheck.do?email=' + $('#useremail').val() +'"/>',
			success : function (data) {
				console.log("data : " +  data);
				checkInput.attr('disabled',false);
				code =data;
				alert('인증번호가 전송되었습니다.')
			}		
		}); // end ajax
	}else{
		alert('이메일을 작성해주세요.')
	}
	
	$('.mail-check-input').blur(function () {
		const inputCode = $(this).val();
		const $resultMsg = $('#mail-check-warn');
		
		if(inputCode === code){
			$resultMsg.html('인증번호가 일치합니다.');
			$resultMsg.css('color','green');
			$('#mail-Check-Btn').attr('disabled',true);
			$('#enrolldo').attr('disabled',false);
		//	$('#userEamil1').attr('readonly',true);
		//	$('#userEamil').attr('readonly',true);
		//	$('#userEamil2').attr('readonly',true);
		//	$('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
		//	$('#userEmail').attr('onFocus', 'this.initialSelect = this.selectedIndex');
	    //	$('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
	    //	$('#userEmail').attr('onChange', 'this.selectedIndex = this.initialSelect');
	    	return true;  //전송 함
		}else{
			$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
			$resultMsg.css('color','red');
			return false;  //전송 안 함
		}
	});
}
</script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/menubar.jsp" />
	<br><br>
	<h1 align="center">MyGallery</h1>
	<h2 align="center">회원가입</h2>
<form action="enroll.do" method="post">
<table id="outer" align="center">
	<tr>
		<th>이 름 :</th>
		<td>
			<input type="text" name="username" placeholder="이름" required style="magin: 100px;"></td>
	</tr>
	<tr>
		<th width="120">아이디 :</th>
		<td>
			<input type="text" name="userid" id="userid" placeholder="아이디" required>
			&nbsp;
			<input type="button" class="from-button" value="중복 체크" onclick="return dupCheckId();">
		</td>
	</tr>
	<tr>
		<th width="120">암 호 :</th>
		<td><input type="password" name="userpassword" id="upwd1" placeholder="비밀번호" required></td>
	</tr>
	<tr>
		<th width="120">암호확인 :</th>
		<td><input type="password" id="upwd2" placeholder="비밀번호재확인" onblur="validate();" required></td>
	</tr>
	<tr>
		<th for="email">이메일 :</th>
		<td class="input-group">
			<input type="email" class="form-control" name="useremail" id="useremail" placeholder="이메일" required>
			&nbsp;
			<input type="button" class="from-button" value="파일업로드" onclick="#">
		</td>
	</tr>
	<tr>
		<th width="120">본인인증 :</th>
		<td class="mail-check-box">
			<input class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6" required>
			&nbsp;
			<span id="mail-check-warn"/>
			<input type="button" class="from-button btn btn-primary" id="mail-Check-Btn" value="본인 인증" onclick="emailCK(); return false" required></button>
		</td>
	</tr>
	<tr>
		<th width="120">성 별 :</th>
		<td>
			<input type="radio" name="usergender" value="M" required> 남자 &nbsp;
			<input type="radio" name="usergender" value="F" required> 여자
		</td>
	</tr>
	<div>
	</div>
	<tr>
		<th colspan="2">
			<input type="submit" class="from-button" value="가입하기"  disabled="disabled" name="enrolldo" id="enrolldo"> &nbsp; 
			<input type="reset" class="from-button" value="작성취소"> &nbsp; 
			<a class="startPage" href="main.do">시작페이지로 이동</a>
		</th>		
	</tr>
</table>
</form>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>