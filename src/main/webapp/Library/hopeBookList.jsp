<%@page import="library.librDO"%>
<%@page import="java.util.ArrayList"%>
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
<title>대여 목록</title>
</head>
<body>
<jsp:useBean id="ldao" class="library.librDAO"/>
<%
	ArrayList<librDO> lList = ldao.getAllHopeBook();
	
%>

<div class="header m-5">
	<div class="row row-cols-2 m-1">
		<div class="col-3">
			<h2 style="font-weight:bold">하이 어린이 도서관</h2>
		</div>
		<div class="col-1">
			<h5>도서 신청</h5>
		</div>
	</div>
</div>
<hr>

	
<div class="container m-5">
<button type="button" class="btn btn-outline-success" 
		onclick="location.href='hopeBook.jsp'">도서 신청하기 </button>
	
<table class="table table-hover">
	<thead>
		<tr>
			<th scope="col">제목</th>	
			<th scope="col">저자명</th>
			<th scope="col">신청사유</th>
		</tr>
	</thead>
	<tbody>
	<%
		for (int i = 0; i < lList.size(); i++) {
			librDO ldo = lList.get(i);
		%>
		<tr height="40">
			<td width="100"><%=ldo.getTitle()%></td>
			<td width="100"><%=ldo.getWriter()%></td>
			<td width="100"><%=ldo.getContents()%></td>
		</tr>
		<%
		}
		%>
	</tbody>
</table>
</div>
</body>
</html>
