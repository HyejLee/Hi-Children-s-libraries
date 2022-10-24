<%@ tag language="java" pageEncoding="UTF-8"%>

<%@ attribute name="border" %>


<form action="search.jsp" method="post">
	<div class="input-group ">
	<select name="fliter" id="fliter" class="form-select">
		<option value="title">제목</option>
		<option value="writer">저자명</option>
	</select>
		<input type="text" name="keyword" class="form-control"
		<%
		if(request.getParameter("keyword")!=null){
		%>
		value='<%=request.getParameter("keyword")%>'
		<%
		}
		%>
		>
		<button type="submit" class="btn btn-primary">검색 </button>
	</div>
</form>