<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 1. 사용중인 세션을 애초에 죽이는 -- 일반적인
	session.invalidate();


	// 2. 다른방법은 사용중이던 값들을 변경
	// session.setAttribute("logon", false);
	// session.removeAttribute("logonUser");
	
	// 1이나 2 중에 하나만 하면 됨.

	response.sendRedirect("/flow/login.jsp");
%>