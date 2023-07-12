<%--
	회원가입을 하기위해 필요한 데이터를 작성하여 
	제출할 폼을 제공하는 곳
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/commons/top.jsp" %>
<%@ include file="/commons/cancel.jsp" %>
<div class="root">
	<form action="./join-task.jsp" method="post" class="join-form">
		<h2>#계정을 생성하세요</h2>
		<div style="margin: 0.2em">
			<h4 style="text-align: left; margin:0.1em">* 사용할 아이디</h4>
			<input type="text" placeholder="아이디" class="join-input" name="id"/>
		</div>
		<div style="margin: 0.2em">
			<h4 style="text-align: left; margin:0.1em">* 사용할 비밀번호</h4>
			<input type="password" placeholder="비밀번호" class="join-input" name="pass"/>
		</div>
		<div style="margin: 0.2em">
			<h4 style="text-align: left; margin:0.1em">* 사용할 대표 닉네임</h4>
			<input type="text" placeholder="대표 닉네임" class="join-input" name="nick"/>
		</div>
		<h3>
			* 모든 정보는 필수 기입 정보 입니다.
		</h3>
		<div>
			<button type="submit" class="join-btn">다음</button>
		</div>
		
	</form>
</div>
<%@ include file="/commons/bottom.jsp" %>
