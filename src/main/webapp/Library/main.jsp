<%@page import="library.librDO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="mytag"%>

<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" 
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<meta charset="UTF-8">
<title>main</title>
</head>
<body>
<jsp:useBean id="ido" class="library.librDO"/>

<%
	request.setCharacterEncoding("utf-8");
%>



<div class="header m-5">
	<div class="row row-cols-2 m-1">
		<div class="col-3">
			<h2 style="font-weight:bold">하이 어린이 도서관</h2>
		</div>
		<div class="col-5">
			<mytag:search></mytag:search>
		</div>
	</div>
</div>


<div class="container m-5" >
	<div class="row  m-5" >
	    <div class="col">
	    	<button type="button" class="btn btn-light" onclick="location.href='chart.jsp'">모아보기</button>
	    </div>
	    <div class="col">
	    	<button type="button" class="btn btn-light" onclick="location.href='list.jsp'">대여 목록</button>
	    </div>
	    <div class="col">
	    	<button type="button" class="btn btn-light" onclick="location.href='hopeBookList.jsp'">도서 신청</button>
	    </div>
	    <div class="col">
	      <%
				
				String userId = (String)session.getAttribute("sid");
				if(userId==null){	
			%>
					<button type="button" claxss="btn btn-primary" onclick="location.href='login.jsp'">Login</button>
			<%
				}else{
			%>
					<%=userId%>님 환영합니다.
					<button type="button" class="btn btn-primary" onclick="location.href='logoutProc.jsp'">Logout</button>
			<%
				}
			%>
		</div>
	</div>
	
	<div class="contents">
	<img class="main" 
		width="900"
		src="./img/main_img.jpg" 
		alt="main image">
	</div>

</div>


</body>
</html>