<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<style type="text/css">
table th { background-color: #99ffff; }
table#outer { border: 2px solid navy; }
</style>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">

function checkID(){
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
					alert("존재하지 않는 아이디 입니다.");
					$("#userid").select();
				}else{
					$("#useremail").focus();
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				console.log("error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
			}
		});
	}
	return false;  //클릭 이벤트 전달을 막음
}

</script>
</head>
<body>
<form action="PWDmailCheck.do" method="GET">
	<div class="textbox">
  		<input id="userid" name=userid required type="text" onchange="return checkID();"/>
  		<label for="text">아이디</label>
 	</div>
	<div class="textbox">
  		<input id="useremail" name=useremail required type="email" />
  		<label for="useremail">이메일</label>
	</div><br><br>
   	<input type="submit" id="check" value="비밀번호찾기">
</form>
</body>
</html>