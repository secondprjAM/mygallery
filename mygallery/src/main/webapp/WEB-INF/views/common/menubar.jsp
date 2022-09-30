<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Gallery.</title>
    <style>
        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #333;
        }

        li {
            font-weight: 200;
            float: right;
            font-size: 22px;
        }
        li a {
        display: block;
        margin-top: 5px;
        color: white;
        text-align: center;
        padding: 16px 16px;
        text-decoration: none;
        transition: 0.3s;
        }
        li a:hover:not(.active) {
        background-color: salmon;
        }
        .active {
        font-weight: 300;
        font-size: 28px;
        }
    </style>
</head>
<body>
    <ul>
        <li style="float:left"><a class="active" href="#about">My Gallery</a></li>
        <li><a href="gallery.do">Gallery</a></li>
        <li><a href="#">로그인</a></li>
        <li><a href="#">아이디찾기</a></li>
        <li><a href="#">비밀번호찾기</a></li>
        <li><a href="#">회원가입</a></li>
      </ul>
</body>
</html>