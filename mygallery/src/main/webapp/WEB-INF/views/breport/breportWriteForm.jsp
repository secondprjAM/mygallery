<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
th {
      font-weight:normal;
      font-size: 16px;
   }
   
   td input{
      width: 25rem;
      height:3rem; 
      border:3px solid #f8f9fa; 
      margin:5px 0;
   }

.button {
      width: 100px;
      height: 45px;
       font-size: 16px;
      letter-spacing: 2px;
      color: #000;
      background-color: #f1f3f5;
      border: none;
      border-radius: 45px;
      cursor: pointer;
      outline: none;
      transition: 0.6s;
  }

   .button:hover {
      background-color:salmon;
   }

   .box {
      width: none;
   }

   .table {
       margin:50px auto;
       position: relative;
       left: 100px;
}


   a{text-decoration:none;}

</style>
</head>
<body>
<!-- 절대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="/WEB-INF/views/common/menubar.jsp" />

<h2 align="center">버그리포트 등록</h2>
<!-- form 태그에서 입력된 값들(문자열)과 첨부파일을 같이 전송하려면,
   반드시 enctype 속성을 form 태그에 추가해야 됨
   enctype="multipart/form-data" 값을 지정해야 함
   method="post" 로 지정해야 함
 -->
<form action="binsert.do" method="post" enctype="multipart/form-data">
<table class="table" align="center" width="800" height="300" cellspacing="0" 
cellpadding="5" >
   <tr><th>제 목</th><td><input type="text" name="b_title"></td></tr>
   <tr><th>작성자</th>
   <td><input type="text" name="userid" readonly value="${ sessionScope.loginMember.userid }"></td></tr>
   <tr><th>첨부파일</th><td><input type="file" name="upfile"></td></tr>
   <tr><th>내 용</th><td><input type="textarea" name="b_content"></td></tr>
</table>
<br>
<div class="box" align="center">
<input class="button" type="submit" value="등록하기"> &nbsp;  
<button class="button" onclick="javascript:history.go(-1); return false;">목록</button>
</div>
</form>
<br>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>







