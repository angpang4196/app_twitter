<%@ page import="data.Follow"%>
<%@ page import="repository.Follows"%>
<%@ page import="java.util.List"%>
<%@ page import="repository.Users"%>
<%@ page import="data.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	User logon =(User)session.getAttribute("logonUser");
	List<Follow> list =Follows.findByOwner(logon.getId());
%>
<%@ include file="/commons/top.jsp"%>
<%-- 왼쪽사이드 영역 --%>
<div style="display: flex; height: 100vh; gap: 10px;">
	<%@ include file="/commons/side.jsp" %> 
	<%-- 센터 영역 --%>
	<div style="flex: 5">
		<div style="margin: 10px; text-align: center">
			<form action="./search.jsp" autocomplete="off"
				class="vertical-center" style="justify-content: flex-start;">
				<img src="/resource/icon/search.svg" 
				style="width: 32px; height: 32px"/>
				<input type="text" name="q" placeholder="Search..."
					style="width: 30%; font-size: 1.3em"/>
			</form>
		</div>
		<div>
			<h2>#팔로우중인 사람들 </h2>
			<%if(list.isEmpty()) {%>
				<p>
					아직 팔로우하는 사람이 없습니다. 팔로우할 사람들을 찾아보시는건 어떨까요?
				</p>
			<%}else { %>
				<h3>Following</h3>
				<div>
					<%for(Follow f : list) {%>
					<div class="people-card">
							<div>
								<img src="<%=f.getTargetUser().getImg() %>" style="width: 50px; height:50px; border-radius: 15%"/>
							</div>
							<div style="flex:1">
								<div>
									<span><%=f.getTargetUser().getNick() %></span> <small>@<%=f.getTarget() %></small> | <%=f.getFollowed() %> ~
								</div>
								<div>
									<%=f.getTargetUser().getProfile() == null? "" : f.getTargetUser().getProfile() %>
								</div>
							</div>
							<div>
								<a href="/home/follow/remove-task.jsp?code=<%=f.getCode() %>" style="background-color: silver; ">팔로우해제</a>
							</div>
						</div>						
									
					<%} %>				
				</div>
			<%} %>
				
		</div>
	
	</div>
</div>


