<%@page import="data.User"%>
<%@ page import="data.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User temp = (User) session.getAttribute("logonUser");
%>
<%-- 왼쪽사이드 영역 --%>
	<div style="flex: 1.0; display: flex; flex-direction: column; min-width: 200px"
		class="side">
		<ul style="list-style: none; flex: 1; line-height: 3">
			<li><a href="<%=application.getContextPath() %>/home/index.jsp">HOME</a></li>
			<li><a href="<%=application.getContextPath() %>/home/following.jsp">FOLLOWING</a></li>
			<li>MESSAGES</li>
			<li><a href="/home/setting.jsp">SETTING</a></li>
		</ul>
		<div style="padding-bottom: 15px;">
			<div
				style="display: flex; align-items: center; padding-left: 10px; gap: 7px; justify-content: center">
				<div>
					<img src="<%=application.getContextPath()%><%=temp.getImg()%>"
						style="width: 36px; height: 36px; border-radius: 50%" />
				</div>
				<div style="flex:1">
					<b><%=temp.getNick()%></b> <small> (@<%=temp.getId()%>)
					</small>
				</div>
			</div>
			<div style="text-align: right; padding-right: 10px">
				<a href="../flow/logout.jsp">로그아웃</a>
			</div>
		</div>
	</div>