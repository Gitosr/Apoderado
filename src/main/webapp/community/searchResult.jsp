<%@page import="kr.co.dongdong.dao.CommunityDAO"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@page import="kr.co.dongdong.vo.CommunityVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>

#aligncenter{
text-align:center;
}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<title>Insert title here</title>

</head>
<body>
	<% 
	ClientVO vo2 = null;
	Object obj = session.getAttribute("vo");
	String search = request.getParameter("search");
	CommunityDAO dao = new CommunityDAO();
	if(obj !=null){
		vo2 = (ClientVO)obj;
	}
	
	%>

	<div class="container">
	<div class="row">
    <div class="col-sm-8">
		<table class="table table-hover">
		<thead class="table-success">
			<tr>
				<th>번호</th>
				<th id="aligncenter">제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			</thead>
			<%
			//최근 작성한 게시물 10개만 가져오기
			ArrayList<CommunityVO> list = dao.searchRev(search);
			for (CommunityVO vo : list) {
			%>
			<tr>
				<td><%=vo.getComno()%></td>
				<td><a style="text-decoration:none; color:black" href="detail.jsp?comno=<%=vo.getComno()%>" ><%=vo.getComtitle()%></a></td>
				<td><%=vo.getClid()%></td>
				<td><%=vo.getComdate()%></td>
				<td><%=vo.getHits()%></td>
			</tr>

			<%}%>
			
			<tr>
			<td></td><td align="center" colspan=3>
			<form action="searchResult.jsp" method="get"><input type="text" name="search" id="" size="30%"/>
			<button type="submit" style="border:none;"><img width="30px" src="https://icones.pro/wp-content/uploads/2021/06/icone-loupe-vert.png" alt=""></button></form></td>
			<td align="right">
			<% if(vo2!=null){ %>
				<a href="write.jsp"><input type="button" value="글쓰기" class="btn btn-outline-success" /></a>
			<%} %>
				</td>
			</tr>
		</table>
		
		
	</div>
	</div>
	</div>
	
	
</body>
</html>