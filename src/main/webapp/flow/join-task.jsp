<%--
	join.jsp 에서 제출된 내용을 토대로 
	DataBase에 신규 유저 정보를 등록하는 처리를 하는 곳 	
 --%>
<%@page import="repository.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8"); 

	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String nick = request.getParameter("nick");

	int r = Users.create(id, pass, nick);

	if(r == 1) {
		// 가입과 동시에 로그온 상태 변경 
		// 방안 1.
		// response.sendRedirect("./login-task.jsp?userId="+id+"&password="+pass);
		// 방안 2.
		session.setAttribute("logon", true);
		session.setAttribute("logonUser", Users.findById(id));
		response.sendRedirect("/home/index.jsp");
	
		
		// 이게 아니면 로그인부터 하라고 보내는 방법
		// response.sendRedirect("./login.jsp");
		return;
	}
%>
<%@ include file="/commons/top.jsp" %>
<div class="root">
	<%if(r==1) { %>
		<h1>환영합니다.</h1>
	<%}else { %>
		<h1>가입처리에 실패하였습니다</h1>
		<p>
			이미 사용중인 아이디 혹은 일시적인 서버 장애로 처리가 되지 않았습니다.
		</p>
	<%} %>
</div>
<%@ include file="/commons/bottom.jsp" %>
