<%--
	이 페이지의 목적은 로그인을 처리해주는 작업
 --%>
<%@page import="data.User"%>
<%@page import="data.User"%>
<%@page import="repository.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userId = request.getParameter("id");
	String password = request.getParameter("pass");
	String destination = request.getParameter("desti");
	
	User one = Users.findById(userId);
	if(one == null) {
		response.sendRedirect("./login.jsp?error");
	} else {
	
		String dbPass = one.getPass();
		if(dbPass.equals(password)) {
			session.setAttribute("logon", true);
			
			session.setAttribute("logonUser", one);
			response.sendRedirect(destination);
		}else {
			response.sendRedirect("./login.jsp?error");
		}
	}
%>