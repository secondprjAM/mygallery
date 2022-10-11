<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
/* 아이디 찾기 */ 
//아이디 & 스토어 값 저장하기 위한 변수
	// 아이디 값 받고 출력하는 ajax
function findId_click(){
	var username=$('#username').val()
	var useremail=$('#useremail').val()
	
	if(username == '' | useremail == ''){
		alert("이름 또는 이메일을 입력해주세요.")
	}else{
		$.ajax({
			url:"find_id.do",
			type:"POST",
			data:{"username":username, "useremail":useremail} ,
			success:function(data){
				if(data == 0){
					alert("이름 혹은 이메일 정보가 정확하지 않습니다 재입력 해주세요.");
					//$('#id_value').text("회원 정보를 확인해주세요!");
					//$('#username').val('');
					//$('#useremail').val('');
					//$('#id_value').text("회원 정보를 확인해주세요!");
				} else {
					alert("그 외의 경우");
					alert("아이디는 : " + data + "입니다.");
					//$('#id_value').text(data);
					//$('#username').val('');
					//$('#useremail').val('');
					
				}
			},
			 error:function(){
	                alert("에러입니다");
	            }
		});
	};
};

</script>
<style>
 #modal.modal-overlay {
            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
            display: none;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(1.5px);
            -webkit-backdrop-filter: blur(1.5px);
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.18);
        }
        #modal .modal-window {
            background: rgba( 0, 0, 0, 0.70 ); // 69, 139, 197
            box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 );
            backdrop-filter: blur( 13.5px );
            -webkit-backdrop-filter: blur( 13.5px );
            border-radius: 10px;
            border: 1px solid rgba( 255, 255, 255, 0.18 );
            width: 400px;
            height: 300px;
            position: relative;
            top: -100px;
            padding: 10px;
        }
        #modal .title {
            padding-left: 10px;
            display: inline;
            text-shadow: 1px 1px 2px gray;
            color: white;
            
        }
        #modal .title h2 {
            display: inline;
        }
        #modal .close-area {
            display: inline;
            float: right;
            padding-right: 10px;
            cursor: pointer;
            text-shadow: 1px 1px 2px gray;
            color: white;
        }
        
        #modal .content {
            margin-top: 20px;
            padding: 0px 10px;
            text-shadow: 1px 1px 2px gray;
            color: white;
        }
</style>
</head>
<body>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			
				<div class="w3-center w3-large w3-margin-top">
					<h3>아이디 찾기</h3>
				</div>
				<div>
					<p>
						<label>이름</label>
						<input class="w3-input" type="text" id="username" name="username" placeholder="이름을 입력해주세요." required>
					</p>
					
					<p>
						<label>이메일</label>
						<input class="w3-input" type="email" id="useremail" name="useremail" placeholder="이메일을 입력해주세요." required>
					</p>
					
					<p class="w3-center">
						<button type="button" id='find_id' onclick="findId_click()">아이디 찾기</button>
						<button type="button" onclick="history.go(-1);" class=>돌아가기</button>
					</p>
				</div>
			
		</div>
	</div>
<hr style="clear:both;">
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>