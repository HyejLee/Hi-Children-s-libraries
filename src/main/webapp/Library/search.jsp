<%@page import="java.util.ArrayList"%>
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
<title>검색</title>
</head>
<body>
<jsp:useBean id="ldao" class="library.librDAO"/>
<%
	request.setCharacterEncoding("utf-8");

	String fliter = request.getParameter("fliter");
	String keyword = request.getParameter("keyword");
	
	ArrayList<librDO> lList = ldao.getKeywordBook(fliter, keyword);
	System.out.println(lList.size());
%>

<div class="header m-5">
	<div class="row row-cols-2 m-1">
		<div class="col-3">
			<h2 style="font-weight:bold">하이 어린이 도서관</h2>
		</div>
		<div class="col-1">
			<h5>검색</h5>
		</div>
	</div>
</div>
<hr>


<div class="container m-5">
<mytag:search></mytag:search>

<table class="table table-hover">
	<thead>
		<tr>
			<th scope="col">제목</th>
			<th scope="col">저자명</th>
			<th scope="col">대출</th>
		</tr>
	</thead>
	<tbody>
	<%
		for (int i = 0; i < lList.size(); i++) {
			librDO ldo = lList.get(i);
	%>
		<tr height="40">
			<td width="100" style="font-weight: bold;"><%=ldo.getTitle()%></td>
			<td width="100"><%=ldo.getWriter()%></td>
			<td width="100">
				
			<%
					if (ldo.isRent() == true){
			%>
						대출 불가
			<%
					}else{
			%>
						<button type="button"
							class="btn btn-primary" 
							onclick="location.href='rent.jsp?id=<%=ldo.getId()%>'">대출 가능 </button>
		
	 		<% 
					} 
			%>
			</td>
		</tr>
		<%
		}
		%>
	</tbody>
</table>
</div>
</body>
</html>