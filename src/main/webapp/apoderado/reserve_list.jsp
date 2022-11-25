<%@page import="kr.co.dongdong.dao.ReviewDAO"%>
<%@page import="kr.co.dongdong.dao.ReserveDAO"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@page import="kr.co.dongdong.vo.ReserveVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>


<style>
.btnref{
float:right;
}
	table{
	width:100%;
	}
	.tablehd{
	background:rgb(209,231,221);
	}
</style>
</head>
<body>
<%
	// 현재 페이지
	String rl = request.getParameter("rl");
	int currentPage = 0;

	if (rl != null) {
		currentPage = Integer.parseInt(rl);
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
	ReserveDAO dao = new ReserveDAO();
	int totalCount = dao.getTotal(voi.getClid()); // 420

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
				<th>예약번호</th>
				<th>예약시설</th>
				<th>예약날짜</th>
				<th>이용회차</th>
				<th>상태</th>
			</tr>
			<!-- db 연결해서 데이터를 가져온 후 완성 -->
			<%
			ReviewDAO dao2 = new ReviewDAO();
			// 최근 작성한 게시물 20개만 가져오기
			ArrayList<ReserveVO> list = dao.selectAll(voi.getClid(), startNo, endNo);
			for (ReserveVO vo : list) {
				String state = "";
				if(vo.getResstate()==0) {
					state = "예약중";
				}else if(vo.getResstate()==1) {
					state = "이용완료";
				}else if(vo.getResstate()==2) {
					state = "환불신청중";
				}else if(vo.getResstate()==3) {
					state = "환불완료";
				}
			%>
			<tr>
				<td align="center"><a href="detailFacilities.jsp?facno=<%=vo.getFacno()%>"><%=vo.getResno()%></a></td>
				<td><a href="detailFacilities.jsp?facno=<%=vo.getFacno()%>"><%=dao2.selectFacname(vo.getResno()) %></a></td>
				<td align="center"><%=vo.getResdate()%></td>
				<td align="center"><%=vo.getRestime()%></td>
				<td align="center"><%=state%></td>
			
			</tr>
			<%
			}
			%>
			<tr>
				<td colspan="5">
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
							<li class="page-item"><a class="page-link"
								href="mypage.jsp?rl=<%=i%>"><%=i%></a></li>
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
			<tr>
				<td colspan="5">
				<div class="btnref">
				<a href="../refund/refRequest.jsp"> 
					<input type="button" value="환불신청" class="btn btn-success"/>
				</a></div></td>
			</tr>
		</table>
	</div>
</body>
</html>