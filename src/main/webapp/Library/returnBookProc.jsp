<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	%>
	<jsp:useBean id="ldo" class="library.librDO"/>
	<jsp:setProperty name="ldo" property="*"/>
	<jsp:useBean id="ldao" class="library.librDAO"/>
	<%
		int id = Integer.parseInt(request.getParameter("id"));
		ldao.returnBook(id);
		response.sendRedirect("list.jsp");
	%>
</body>
</html>