<%@page import="repository.Users"%>
<%@page import="data.User"%>
<%@page import="java.util.UUID"%>
<%@ page import="repository.Follows"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%
	String code = UUID.randomUUID().toString().split("-")[0];
	User logon =(User)session.getAttribute("logonUser");
	String owner = logon.getId(); 
	
	String target= request.getParameter("target");

	User targetUser = Users.findById(target);
	int status = 0;
	if(targetUser!= null) {
		status = Follows.create(code, owner, target);
	}else {
		status = 9;
	}
	
%>
<%@ include file="/commons/top.jsp"%>
<%-- 왼쪽사이드 영역 --%>
<div style="display: flex; height: 100vh; gap: 10px;">
	<%@ include file="/commons/side.jsp" %> 
	<%-- 센터 영역 --%>
	<div style="flex: 5">
		<div style="margin-top : 20vh">
			<%if(status==1) { %>
				"<%=target %>" 님을 팔로우 합니다.
			
			<%}else { %>
				"<%=target %>" 님은 이미 팔로우 대상이거나 없는 아이디입니다.
			<%} %>
			
		</div>	
	</div>
</div>


