
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@page import="kr.co.dongdong.vo.ReviewVO"%>
<%@page import="kr.co.dongdong.dao.ReviewDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table,tr,td{
border:1px solid black;
}
ul li{list-style-type:none; display:inline;}
</style>

</head>
<body>
	<% 
	Object obj = session.getAttribute("vo");
	ClientVO vo2 = null;
	if(obj !=null){
	 vo2= (ClientVO)obj;
	}
	
	//현재 페이지 
	String cp = request.getParameter("cp");
	String search = request.getParameter("search");
	int currentPage = 0;
	if (cp != null) {
		currentPage = Integer.parseInt(cp);
	} else {
		currentPage = 1;
	}

	//총 게시물 수
	ReviewDAO dao = new ReviewDAO();
	int totalCount = dao.getTotal();
	//1페이지당 게시물 수  : 10
	int recordPerPage = 10;
	int startNo = (currentPage - 1) * recordPerPage + 1;
	int endNo = currentPage * recordPerPage;

	//총 페이지 수
	int totalPage = (totalCount % recordPerPage == 0) ? totalCount / recordPerPage : totalCount / recordPerPage + 1;

	//시작페이지번호
	int startPage = 1;
	//끝페이지번호
	int endPage = totalPage;

	//시작페이지 미세조정
	if (currentPage <= 5) {
		startPage = 1;
	} else if (currentPage >= 6) {
		startPage = currentPage - 4;
	}

	//끝페이지 미세조정
	if (totalPage - currentPage <= 5) {
		endPage = totalPage;
	} else if (totalPage - currentPage > 5) {
		if (currentPage <= 5) {
			if (totalPage > 10) {
		endPage = 10;
			} else {
		endPage = totalPage;
			}
		} else {
			endPage = currentPage + 4;
		}
	}

	boolean isPre = false;
	boolean isNext = false;

	//이전값이 존재하면 true;
	//다음값이 존재하면 true;
	//현재 페이지 번호에서 5을 뺀 값이 0이상이면 이전값이 존재
	if (currentPage - 5 > 0) {
		isPre = true;
	}
	//현재 페이지 번호에서 5를 더한 값이 끝페이지 번호보다 작으면 다음값이 존재
	if (currentPage + 5 <= totalPage) {
		isNext = true;
	}

	%>

	<div class="container">
		<table>
		<tr><% if(vo2!=null){ %>
		<td colspan="5"><a href="../review/write.jsp"> <input type="button"
						value="글쓰기" class="btn btn-primary" /><%} %>
				</a></td></tr>
			<tr>
				<th>게시물번호</th>
				<th>시설명</th>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
				<th>평점</th>
			</tr>
			<%
			if(search!=null){
			ArrayList<ReviewVO> list = dao.searchRev(search);
			for (ReviewVO vo : list) {
				String clid = dao.selectID(vo.getResno());
				String facname = dao.selectFacname(vo.getResno());
				int score = vo.getRevscore();
			%>
			<tr>
				<td><%=vo.getRevno()%></td>
				<td><%=facname %></td>
				<td><a href="../review/detail.jsp?revno=<%=vo.getRevno()%>"><%=vo.getRevtitle()%></a></td>
				<td><%=clid%></td>
				<td><%=vo.getRevdate()%></td>
				<td><%if(score==1){%>★<%}
			if(score==2){%>★★<%}
			if(score==3){%>★★★<%}
			if(score==4){%>★★★★<%}
			if(score==5){%>★★★★★<%}
			%></td>
			</tr>


			<%
			}
			%>
			<tr>
				<td colspan="5">
					<!-- 부트스트랩 페이지네이션 -->
					<nav aria-label="Page navigation example">
						<ul>
							<%if (isPre) {%>
							<li><a>Previous</a></li>
							<%}
							for (int i = startPage; i <= endPage; i++) {%>
							<li><a href="../review/list.jsp?cp=<%=i%>"><%=i%></a></li>
							<%}if (isNext) {%>
							<li><a href="#">Next</a></li>
							<%}%>
						</ul>
					</nav>
				</td>
			</tr>
			<tr>
			
			</tr>
		</table>
	</div>
	<%} %>
</body>
</html>