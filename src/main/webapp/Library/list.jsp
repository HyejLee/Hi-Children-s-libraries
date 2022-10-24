<%@page import="library.librDO"%>
<%@page import="java.util.ArrayList"%>
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
<title>대여 목록</title>
</head>
<body>
<jsp:useBean id="ldao" class="library.librDAO"/>
<%

	String userId = (String)session.getAttribute("sid");
	if(userId==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 해주세요.')");	
		script.println("location.href = 'login.jsp'"); 
		script.println("</script>");
	}
	
	ArrayList<librDO> lList = ldao.getAllMyBook(userId);
	
%>

<div class="header m-5">
	<div class="row row-cols-2 m-1">
		<div class="col-3">
			<h2 style="font-weight:bold">하이 어린이 도서관</h2>
		</div>
		<div class="col-1">
			<h5>대여 목록</h5>
		</div>
	</div>
</div>
<hr>


<div class="container m-5">
<table class="table table-hover">
	<thead>
		<tr>
			<th scope="col">제목</th>
			<th scope="col">저자명</th>
			<th scope="col">대출일</th>
			<th scope="col">반납일</th>
			<th scope="col">반납</th>
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
			<td width="100"><%=ldo.getRentDate()%></td>
			<td width="100"><%=ldo.getReturnDate()%></td>
			<td width="100">				
				<button type="button"
							class="btn btn-primary" 
							onclick="location.href='returnBookProc.jsp?id=<%=ldo.getId()%>'">반납하기 </button>							
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
