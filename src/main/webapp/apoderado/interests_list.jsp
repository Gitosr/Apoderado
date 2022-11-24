<%@page import="kr.co.dongdong.vo.InterestsVO"%>
<%@page import="kr.co.dongdong.dao.InterestsDAO"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	.tablehd{
	background:rgb(209,231,221);
	}
	img#x{
	width:20px;
	}
</style>
</head>
<body>
<%
	// 현재 페이지
	String il = request.getParameter("il");
	int currentPage = 0;

	if (il != null) {
		currentPage = Integer.parseInt(il);
	} else {
		currentPage = 1;
	}

	// 1페이지당 게시물 수
	int recoredPerPage = 10;

	// 시작번호와 끝번호를 계산
	// 현재 페이지가 1이면
	// 시작 번호 : 1부터 끝번호 : 10

	// 현재 페이지가 2이면
	// 시작번호 : 11부터 끝번호 : 20
	// startNO = (1-1)*10 + 1
	int startNo = (currentPage - 1) * recoredPerPage + 1;
	int endNo = currentPage * recoredPerPage;
	
	Object obj = session.getAttribute("vo");
	ClientVO voi = (ClientVO)obj;
	
	// 총 게시물 수
	InterestsDAO dao = new InterestsDAO();
	int totalCount = dao.getTotal(voi.getClid()); 

	// 총페이지 수
	// 420 / 10 ==> 21
	int totalPage = 0;
	if (totalCount > recoredPerPage) {
		totalPage = (totalCount % recoredPerPage == 0) ? totalCount / recoredPerPage : totalCount / recoredPerPage + 1;
		
	} else {
		totalPage = 1;				
	}
	
	// 시작 페이지번호
	int startPage = 1;

	// 끝 페이지번호
	int endPage = totalPage;

	// 시작 페이지 미세조정
	if (currentPage <= 5) {
		startPage = 1;
	} else if (currentPage >= 6) {
		startPage = currentPage - 4;
	}

	// 끝 페이지 미세조정
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

	// 이전값이 존재하면 true;
	// 다음값이 존재하면 true;

	// 현재 페이지 번호에서 5을 뺀값이 0이상이면 이전 값이 존재
	if (currentPage - 5 > 0) {
		isPre = true;
	}

	// 현재 페이지 번호에서 5을 더한 값이 끝페이지 번호보다 작으면 다음값이 존재
	if (currentPage + 5 <= totalPage) {
		isNext = true;
	}
	%>
	
	<div class="margind">
		<table class="table table-hover">
			<tr class="tablehd">
				<th>시설명</th>
				<th>찜한 날짜</th>
				<th>삭제</th>
			</tr>
			<!-- db 연결해서 데이터를 가져온 후 완성 -->
			<%
			
			// 최근 작성한 게시물 20개만 가져오기
			ArrayList<InterestsVO> list = dao.selectAll(voi.getClid(), startNo, endNo);
			for (InterestsVO vo : list) {
				
				
			%>
			<tr>
				<td><a href="detailFacilities.jsp?facno=<%=vo.getFacno()%>"><%=vo.getFacno()%>  .  
				<%=dao.selectFacname(vo.getFacno())%></a></td>
				<td align="center"><%=vo.getIntdate()%></td>
				<td align="center"><a href="deleteHeart.jsp?facno=<%=vo.getFacno()%>"><img id="x" src="https://icones.pro/wp-content/uploads/2022/05/icone-fermer-et-x-rouge-1.png" alt="" /></a></td>
			</tr>
			<%
			}
			%>

			<tr>
				<td colspan="3">
					<nav aria-label="Page navigation example">
						<ul class="pagination justify-content-center">
							<%
							if (isPre) {
							%>
							<li class="page-item"><a class="page-link">Previous</a></li>
							<%
							}
							%>
							<%
							for (int i = startPage; i <= endPage; i++) {
							%>
							<li class="page-item"><a class="page-link" href="mypage.jsp?il=<%=i%>"><%=i%></a></li>
							<%
							}
							%>
							<%
							if (isNext) {
							%>
							<li class="page-item"><a class="page-link" href="#">Next</a></li>
							<%
							}
							%>
						</ul>
					</nav>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>