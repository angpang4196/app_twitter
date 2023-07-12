<%@page import="repository.Tweets"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String code = request.getParameter("code");
	int r = Tweets.delete(code);
	if(r==1){
		response.sendRedirect("../index.jsp");
	}
%>