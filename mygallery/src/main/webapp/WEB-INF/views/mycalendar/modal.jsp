<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.UnsupportedEncodingException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 id="modal-title" class="modal-title"></h4>
			</div>
			<div class="modal-body">
				<table class="table">
					<tr> 
						<td>날짜 : <input type="text" class ="body-date" id="date" name ="date" value ="??" readonly style="width: 30rem;height:3rem; border:3px solid #f8f9fa;"></td>
					</tr>
					<tr>
						<td>내용 : <input type="textarea" class="body-contents" id="contents" name="contents" readonly wrap=on style="width: 50rem;height:3rem; border:3px solid #f8f9fa;"></td>
					</tr>
					<tr>
						<td>유저 아이디 : <input type="text" class="userid" id = "userid" name="userid" value ="${ sessionScope.loginMember.userid }" readonly style="width: 25rem;height:3rem; border:3px solid #f8f9fa;"></td>
					</tr>
					<tr>
					<td><br><p id = "imgBox"></p></td>
				</table>
			</div>
			<div class="modal-footer">
				<button id="modalSubmit" type="button" class="btn btn-success"
					onclick="updateCalForm();">수정하기</button>
				<button type="button" class="btn btn-default" data-dismiss="modal" onclick="deleteCalForm();" style="">삭제하기</button>
			</div>
		</div>
	</div>
</div>