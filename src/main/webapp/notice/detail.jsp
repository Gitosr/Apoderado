
<%@page import="kr.co.dongdong.vo.NoticeVO"%>
<%@page import="kr.co.dongdong.dao.NoticeDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<style>
.mini{
font-size: 0.5rem;
color : gray;
width:40%;
}
</style>

</head>
<body>
	<%
	
	ClientVO vo2 = null;
	Object obj = session.getAttribute("vo");
	if(obj !=null){
	vo2 = (ClientVO)obj;
	}
	//1. 파라미터값 가져오기
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");

	
	String no = request.getParameter("notno");
	if (no != null) {
		int comno = Integer.parseInt(no);
		
		NoticeDAO dao = new NoticeDAO();
		dao.raiseHits(comno); //조회수 1 증가시킴
		NoticeVO vo = dao.selectOne(comno);

	%>
	<div class="container">
	<div class="row">
    <div class="col-sm-8">
	<table class="table">
	<thead class="table-success">
		<tr>
			<th width="60%"><%= vo.getNottitle()%></th>
		<td class='mini'>작성자 | <%=vo.getClid()%> |	조회수 | 
			<%=vo.getNothits()%> | 작성일시 | <%=vo.getNotdate()%></td></tr>
		<%int facno = vo.getFacno();
				String facname = dao.selectFacname(facno);
				%>
		<tr><td colspan=2>시설명 <%=facname %></td></tr></thead>
		
		<tr>
		
			<td colspan="2"><%=vo.getNotcontents() %></td>
		</tr>
		<tr>
			<td></td>
			<td align="right">
			<a href="list.jsp"><input type="button" value="목록" class="btn btn-outline-success"/></a>
			
			<%
			String clid2 ="";
			if(vo2!=null){
			clid2 = vo2.getClid();}
			
			String clid = vo.getClid();
			if(clid2.equals(clid)){ %>
			<a href="modify.jsp?notno=<%=vo.getNotno()%>">
			<input type="button" value="수정" class="btn btn-outline-success"/></a>
			<a href="deleteOk.jsp?notno=<%=vo.getNotno()%>">
			<input type="button" value="삭제" class="btn btn-outline-success"/></a><%} %>
			</td>
		</tr>
	</table>
	</div>
	</div>
	
	<%}%>

</body>
</html>