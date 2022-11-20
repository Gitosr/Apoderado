
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@page import="kr.co.dongdong.dao.ReviewDAO"%>
<%@page import="kr.co.dongdong.vo.ReviewVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
table, tr, td{
border : 1px solid black;
}
</style>
<title>Insert title here</title>

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

	String no = request.getParameter("revno");
	
	if (no != null) {
		int comno = Integer.parseInt(no);
		
		ReviewDAO dao = new ReviewDAO();
		ReviewVO vo = dao.selectOne(comno);
		String clid = dao.selectID(vo.getResno());
		int score = vo.getRevscore();

	%>
	<div class="container">
	<table>
		<tr>
			<th>작성자</th>
			<td><%=clid%></td>
			
			<th>평점</th>
			<td><%if(score==1){%>★<%}
			if(score==2){%>★★<%}
			if(score==3){%>★★★<%}
			if(score==4){%>★★★★<%}
			if(score==5){%>★★★★★<%}
			%></td>
			<th>작성일시</th>
			<td><%=vo.getRevdate() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="6"><%= vo.getRevtitle() %></td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="6"><%=vo.getRevcontents() %></td>
		</tr>
		<tr>
			<td colspan="6">
			<a href="../review/list.jsp"><input type="button" value="목록"/></a>
			
			<%
			String clid2 ="";
			if(vo2!=null){
			clid2 = vo2.getClid();}
			
			if(clid2.equals(clid)){ %>
			
			<a href="../review/modify.jsp?revno=<%=vo.getRevno()%>">
			<input type="button" value="수정"/></a>
			<a href="../review/deleteOk.jsp?revno=<%=vo.getRevno()%>">
			<input type="button" value="삭제"/></a><%} %>
			</td>
		</tr>
	</table>
	</div>
<%} %>

</body>
</html>