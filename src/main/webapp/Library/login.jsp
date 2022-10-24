<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" 
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	session.invalidate();
%>
<jsp:useBean id="idao" class="library.librDAO"/>

<div class="header m-5">
	<div class="row row-cols-2 m-1">
		<div class="col-3">
			<h2 style="font-weight:bold">하이 어린이 도서관</h2>
		</div>
		<div class="col-1">
			<h5>로그인</h5>
		</div>
	</div>
</div>

<hr>

<div class="container m-5">
<form action="loginProc.jsp" method="post">
	<div class="input-group mb-1">
		<span class="input-group-text" id="basic-addon1">ID</span>
		<input type="text"
				class="form-control"
				name="userId"
				aria-describedby="basic-addon1">
	</div>
   	<div class="input-group mb-1">
		<span class="input-group-text" id="basic-addon2">PASSWORD</span>
		<input type="password"
				class="form-control"
				name="password"
				aria-describedby="basic-addon2">
	</div>

	<button type="submit" class="btn btn-primary">로그인</button>
</form>
</div>



</body>
</html>