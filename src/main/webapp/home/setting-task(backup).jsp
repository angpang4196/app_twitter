<%@page import="data.User"%>
<%@page import="repository.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	User user = (User)session.getAttribute("logonUser");	

	String id = user.getId();
	String nick = request.getParameter("nick");
	String profile = request.getParameter("profile");
	String img = user.getImg();
	
	int r = Users.updateOne(id, nick, profile, img);
	
	
	if(r == 1) {
		session.setAttribute("logonUser", Users.findById(id));
		response.sendRedirect("./index.jsp");
	
	} else {
		response.sendRedirect("./setting.jsp?error");
	}
%>