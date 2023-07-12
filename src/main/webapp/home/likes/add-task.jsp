<%@page import="data.Tweet"%>
<%@page import="java.util.List"%>
<%@page import="repository.Tweets"%>
<%@page import="data.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String code = request.getParameter("code");

User user = (User) session.getAttribute("logonUser");
String id = user.getId();
int r = Tweets.makeLike(id, code);

if (r == 1) {
	response.sendRedirect("../index.jsp?code=" + code);
}
%>