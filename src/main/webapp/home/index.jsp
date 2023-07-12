<%@page import="java.util.Map"%>
<%@page import="data.TweetAttach"%>
<%@page import="java.util.HashMap"%>
<%@page import="repository.TweetAttaches"%>
<%@page import="data.Tweet"%>
<%@page import="java.util.List"%>
<%@page import="repository.Tweets"%>
<%@page import="data.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
boolean logon = (boolean) session.getAttribute("logon");
if (!logon) {
	response.sendRedirect("/flow/login.jsp");
	return;
}
User user = (User) session.getAttribute("logonUser");
List<Tweet> latest = Tweets.findLatest(5);

String code = request.getParameter("code");
int cnt = 0;
if (code == null) {

	Map<String, List<TweetAttach>> attachesMap = new HashMap<>();
	for (Tweet t : latest) {
		List<TweetAttach> li = TweetAttaches.findByTweetCode(t.getCode());
		attachesMap.put(t.getCode(), li);
	}
} else {
	List<Tweet> list = Tweets.likeCnt(user.getId(), code);
	for (Tweet t : list) {
		if (code.equals(t.getTargetCode())) {
			cnt = t.getLikeCnt();
		}
	}
}
%>

<%@ include file="/commons/top.jsp"%>
<%-- 왼쪽사이드 영역 --%>
<div style="display: flex; height: 100vh; gap: 10px;">
	<%@ include file="/commons/side.jsp"%>
	<%-- 센터 영역 --%>
	<div style="flex: 5; overflow-y: scroll;">
		<%-- 서치 영역 --%>
		<div style="margin: 10px; text-align: right">
			<form action="./search.jsp" autocomplete="off"
				class="vertical-center" style="justify-content: flex-end;">
				<img src="/resource/icon/search.svg"
					style="width: 32px; height: 32px" /><input type="text" name="q"
					placeholder="Search..." style="width: 30%; font-size: 1.0em" />
			</form>
		</div>
		<%-- TWEET 쓰기 영역 --%>
		<div style="margin: 10px;">
			<form action="./tweet/create-task.jsp" autocomplete="off"
				style="width: 100%;" method="post" enctype="multipart/form-data">
				<div style="padding-right: 22px">
					<textarea style="width: 100%; resize: none; height: 90px"
						placeholder="오늘은 무슨일이 있으셨나요?" name="body"></textarea>
				</div>
				<div style="display: flex">
					<div style="flex: 1">
						<input type="file" name="attach" multiple />
					</div>
					<div>
						<button type="submit">TWEET</button>
					</div>
				</div>
			</form>
		</div>
		<%-- 최신 트윗 뷰 영역 --%>
		<div style="margin: 10px">
			<div style="display: flex; align-items: baseline;">
				<h3 style="flex: 1">최신 트윗들</h3>
				<div>
					<a href="">전체보기</a>
				</div>
			</div>
			<%
			for (Tweet tweet : latest) {
			%>
			<div
				style="padding: 10px; border: 1px solid #777; margin-bottom: 5px; border-radius: 40px;">
				<div>
					<b><%=tweet.getWriter()%></b> | <small><%=tweet.getWrited()%></small>
				</div>
				<div>
					<%=tweet.getBody() == null ? "" : tweet.getBody()%>
				</div>
				<div style="display: flex; gap: 10px; justify-content: center">
					<%
					for (TweetAttach attach : TweetAttaches.findByTweetCode(tweet.getCode())) {
					%>
					<div>
						<img src="<%=attach.getUri()%>"
							style="border-radius: 20px; max-width: 100%; max-height: 30vh" />
					</div>
					<%
					}
					%>
				</div>
				<%
				if (tweet.getWriter().equals(user.getId())) {
				%>
				<div style="text-align: right; font-size: small">
					<a href="./tweet/update-task.jsp?info=<%=tweet%>">수정</a> | <a
						href="./tweet/delete-task.jsp?code=<%=tweet.getCode()%>">삭제</a>
				</div>
				<%
				} else {
				%>
				<a href="./likes/add-task.jsp?code=<%=tweet.getCode()%>">🤍</a> 좋아요
				수 :
				<%=cnt%>
				<%
				}
				%>
			</div>
			<%
			}
			%>

		</div>
	</div>
</div>


