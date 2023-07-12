<%@page import="java.io.File"%>
<%@page import="java.util.UUID"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.InputStream"%>
<%@page import="data.User"%>
<%@page import="repository.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
User user = (User) session.getAttribute("logonUser");
String id = user.getId();

String path = application.getRealPath("/resource/profile/" + id);
File pathFile = new File(path);
if (!pathFile.exists()) {
	pathFile.mkdirs();
}

//최대 업로드 가능한 바이트
MultipartRequest multi = new MultipartRequest(request, path, 1024 * 1024 * 100, "utf-8");

String genCode = Long.toString(System.currentTimeMillis());
File ex = multi.getFile("attach");
String img = "";
if (ex == null) {
	img = user.getImg();
} else {
	ex.renameTo(new File(path, genCode));
	img = "/resource/profile/" + id + "/" + genCode;
}

String nick = multi.getParameter("nick");
String profile = multi.getParameter("profile");

int r = Users.updateOne(id, nick, profile, img);

if (r == 1) {
	session.setAttribute("logonUser", Users.findById(id));
	response.sendRedirect("./index.jsp");

} else {
	response.sendRedirect("./setting.jsp?error");
}
%>
<%--  
path : <%=path%><br/>
genCode : <%=genCode%><br/>
realFileAddress : <%=new File(path, genCode).getAbsolutePath()%><br/>
uri : <%="/resource/profile/" + id + "/" + genCode %><br/>
nick : <%=nick%><br/>
profile : <%=profile%><br/>
<img src="<%=img%>"/>
--%>