<%@page import="library.librDO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" 
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<meta charset="UTF-8">
<title>대여하기</title>
</head>
<body>
<jsp:useBean id="ldao" class="library.librDAO"/>
<%
	request.setCharacterEncoding("utf-8");

	String userId = (String)session.getAttribute("sid");
	if(userId==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 해주세요.')");	
		script.println("location.href = 'login.jsp'"); 
		script.println("</script>");
	}

	int id = Integer.parseInt(request.getParameter("id"));
	librDO ldo = ldao.getBookOne(id);
%>


<div class="header m-5">
	<div class="row row-cols-2 m-1">
		<div class="col-3">
			<h2 style="font-weight:bold">하이 어린이 도서관</h2>
		</div>
		<div class="col-1">
			<h5>대여하기</h5>
		</div>
	</div>
</div>
<hr>


<div class="container m-5">
<form action="rentProc.jsp" method="post">
	<div class="mb-1">
		<label for="exampleInputEmail1" class="form-label">제목</label>
		<input type="text"
				class="form-control"
				name="title"
				value="<%=ldo.getTitle() %>"
				readonly>
	</div>
   	<div class="mb-1">
		<label for="exampleInputEmail1" class="form-label">저자명</label>
		<input type="text"
				class="form-control"
				name="writer"
				value="<%=ldo.getWriter()%>"
				readonly="readonly"
				>
	</div>
	<div class="mb-1">
		<label for="exampleInputEmail1" class="form-label">대출일</label>
		<input type="date"
				class="form-control"
				name="rent_date">
	</div>
	<input type="hidden" value="<%=ldo.getId()%>" name="id">
	<input type="hidden" value="<%=ldo.getCount()%>" name="count">
	<input type="hidden" value="<%=userId%>" name="userId">
	<button type="submit" class="btn btn-primary">대출</button>
	<button type="reset" class="btn btn-danger">취소</button>
</form>
</div>


</body>
</html>