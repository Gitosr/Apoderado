
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.dongdong.vo.CommentsVO"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@page import="kr.co.dongdong.dao.CommentsDAO"%>
<%@page import="kr.co.dongdong.vo.CommunityVO"%>
<%@page import="kr.co.dongdong.dao.CommunityDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table, td, tr{
border : 1px solid black;
}

</style>

</head>
<body>
	<%
	
	ClientVO vo2 = null;
	Object obj = session.getAttribute("vo");
	if(obj !=null){
		// 로그인 아이디 가져오기
		vo2 = (ClientVO)obj;
	}
	//1. 파라미터값 가져오기
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");

	// 용병게시판 번호 가져오기
	String no = request.getParameter("comno");
	if (no != null) {
		int comno = Integer.parseInt(no);
		
		CommunityDAO dao = new CommunityDAO();
		dao.raiseHits(comno); //조회수 1 증가시킴
		CommunityVO vo = dao.selectOne(comno);
	%>
	<div class="container">
		<table >
			<tr>
				<th>작성자</th>
				<td><%=vo.getClid()%></td>
				<th>조회수</th>
				<td><%=vo.getHits() %></td>
				<th>작성일시</th>
				<td><%=vo.getComdate() %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="5"><%= vo.getComtitle() %></td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="5"><%=vo.getComfield() %></td>
			</tr>
			<tr>
				<td colspan="6">
				<a href="list.jsp"><input type="button" value="목록"/></a>
				
				<%
				String clid2 ="";
				if(vo2!=null){
				clid2 = vo2.getClid();}
				
				String clid = vo.getClid();
				if(clid2.equals(clid)){ %>
				<a href="modify.jsp?comno=<%=vo.getComno()%>"><input type="button" value="수정"/></a>
				<a href="deleteOk.jsp?comno=<%=vo.getComno()%>"><input type="button" value="삭제"/></a>
				<%} %>
				</td>
			</tr>
		</table>
	
		<div id="div1">
			<table>
				<thead>
				<%
				if(obj!=null){ %>
				<tr>
					<form action="writecomOk.jsp" method="post" name="frm">
						<td colspan=4><input type='text' name='txtComscontents' size = 80 id='txtComscomtents' /></td>
						 <input type="hidden" name="comno" value="<%=vo.getComno()%>" />
						<td><input type='submit' value='댓글쓰기'/></td>
					</form>
				</tr>
				<%} %>
				<tr>
					<th>댓글번호</th>
					<th>작성자</th>
					<th>내용</th>
					<th>작성일</th>	
				</tr>
				</thead>
	
				<tbody id="dynamicTbody">
				
				<% 
				CommentsDAO dao2 = new CommentsDAO();
				CommentsVO vo3 = new CommentsVO();
				ArrayList<CommentsVO> list = dao2.selectOne(comno); 
					for (CommentsVO x : list) { %>
					<tr>
						<td><%=x.getClistno()%></td>
						<td><%=x.getClid()%></td>
						<td><%=x.getComscontents()%></td>
						<td><%=x.getComsdate()%></td>
						
						<td>
						<% 
						if(vo2!=null){
							if(vo2.getClid().equalsIgnoreCase(x.getClid())){ 
						%>
							<a href="deletecomOk.jsp?clistno=<%=x.getClistno()%>&comno=<%=comno%>"><input type="button" value="삭제" /></a>
						<%  }
						}
					} 
					%>
						</td>
					</tr>
				</tbody>
				<tfoot>
				</tfoot>
			</table>
		</div>
	</div>
	<%
	}
	%>
</body>
</html>