<%@page import="data.TweetAttach"%>
<%@page import="data.Tweet"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="data.User"%>
<%@page import="java.util.UUID"%>
<%@page import="repository.TweetAttaches"%>
<%@page import="repository.Tweets"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.FilePart"%>
<%@page import="com.oreilly.servlet.multipart.ParamPart"%>
<%@page import="com.oreilly.servlet.multipart.Part"%>
<%@page import="com.oreilly.servlet.multipart.MultipartParser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String code = UUID.randomUUID().toString().split("-")[0];
String body = null;

User logonUser = (User) session.getAttribute("logonUser");
String writer = logonUser.getId();

List<String> uris = new ArrayList<>();

MultipartParser parser = new MultipartParser(request, 1024 * 1024 * 50);
parser.setEncoding("utf-8");

while (true) {
	Part part = parser.readNextPart();
	if (part == null) {
		break;
	}
	out.println("<p>" + part + "</p>");
	if (part.isParam()) {
		ParamPart param = (ParamPart) part;

		switch (param.getName()) {
		case "body":
			body = param.getStringValue();
			break;
		}
	} else {
		FilePart file = (FilePart) part;

		if (file.getFileName() == null) {
			continue;
		}
		String baseURI = "/resource/attaches/" + code;
		String path = application.getRealPath(baseURI);

		new File(path).mkdirs();
		String fileName = UUID.randomUUID().toString();
		File target = new File(path, fileName);
		file.writeTo(target); // 업로드 진행
		uris.add(baseURI + "/" + fileName);
	}
}

int r = Tweets.create(code, writer, body);
int cnt = 0;
for (String uri : uris) {
	int idx = TweetAttaches.findLastIdx();
	cnt += TweetAttaches.create(idx, uri, code);
}

if (r == 1 && cnt == uris.size()) {
	response.sendRedirect("/home/index.jsp");
} else {
	out.println("<h1>Error</h1>");
}

%>