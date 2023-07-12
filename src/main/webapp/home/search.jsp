<%@ page import="java.util.List"%>
<%@ page import="repository.Users"%>
<%@ page import="data.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String q = request.getParameter("q");
	List<User> list =Users.findByKeyword(q);


%>
<%@ include file="/commons/top.jsp"%>
<%-- 왼쪽사이드 영역 --%>
<div style="display: flex; height: 100vh; gap: 10px;">
	<%@ include file="/commons/side.jsp" %> 
	<%-- 센터 영역 --%>
	<div style="flex: 5">
		<div style="margin: 10px; text-align: right">
			<form action="./search.jsp" autocomplete="off"
				class="vertical-center" style="justify-content: flex-end;">
				<img src="/resource/icon/search.svg" 
				style="width: 32px; height: 32px"/>
				<input type="text" name="q" placeholder="Search..." value="<%=q %>" 
					style="width: 30%; font-size: 1.3em"/>
			</form>
		</div>
		<div>
			<h1>검색결과 </h1>
			<%if(list.isEmpty()) {%>
				<p>
					"<%=q %>"와 일치하는 결과가 없습니다.
				</p>
			<%}else { %>
				<h3>People</h3>
				<div>
					<%for(User u : list) {%>
						<div class="people-card">
							<div>
								<img src="<%=u.getImg() %>" style="width: 50px; height:50px; border-radius: 15%"/>
							</div>
							<div style="flex:1">
								<div>
									<span><%=u.getNick().replaceAll(q, "<b>"+q+"</b>") %></span> <small>@<%=u.getId().replaceAll(q, "<b>"+q+"</b>") %></small>
								</div>
								<div>
									<%=u.getFollowerCnt() %> <b>Follows</b>
								</div>
								<div>
									<%=u.getProfile() == null? "" : u.getProfile().replaceAll(q, "<b>"+q+"</b>")%>
								</div>
							</div>
							<div>
								<a href="/home/follow/add-task.jsp?target=<%=u.getId()%>">팔로우</a>
							</div>
						</div>						
					<%} %>				
				</div>
			<%} %>
				
		</div>
	
	</div>
</div>


