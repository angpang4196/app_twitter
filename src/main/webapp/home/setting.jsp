<%@ page import="data.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
boolean logon = (boolean) session.getAttribute("logon");
if (!logon) {
	response.sendRedirect("/flow/login.jsp");
	return;
}
User user = (User) session.getAttribute("logonUser");
%>
<%@ include file="/commons/top.jsp"%>
<div style="display: flex; height: 100vh; gap: 10px;">
	<%@ include file="/commons/side.jsp"%>
	<%-- 센터 영역 --%>
	<div style="flex: 5;">
		<form action="./setting-task.jsp" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="<%=user.getId()%>" />
			<h1>#정보를 수정하세요</h1>
			
			<div style="margin: 0.2em">
				<h4 style="text-align: left; margin: 0.1em">프로필이미지</h4>
				<input type="file" placeholder="이미지 선택" class="join-input" name="attach"
					 style="width: 70vw" accept="image/*"/>
			</div>
			
			<div style="margin: 0.2em">
				<h4 style="text-align: left; margin: 0.1em">대표 닉네임</h4>
				<input type="text" placeholder="아이디" class="join-input" name="nick"
					value="<%=user.getNick()%>" style="width: 70vw" />
			</div>
			
			<div style="margin: 0.2em">
				<h4 style="text-align: left; margin: 0.1em">자기 소개글</h4>
				<textarea class="join-input" name="profile"
					style="resize: none; height: 120px; width: 70vw"><%=user.getProfile() == null ? "" : user.getProfile()%></textarea>
			</div>
			
			<div style="margin: 0.2em">
				<button type="submit" class="join-btn" style="width: auto;">저장</button>
			</div>
		</form>
	</div>
</div>


