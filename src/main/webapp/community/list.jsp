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
#aligncenter2{
text-align:center;
}


</style>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<title>Insert title here</title>

<!-- --------header  -------- -->
<!-- <link rel="stylesheet" href="../css/main.css" /> -->

<!-- 수정된 부분 -->
<link href="../Resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="../Resources/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link href="../Resources/vendor/aos/aos.css" rel="stylesheet">
<link href="../Resources/vendor/glightbox/css/glightbox.min.css"
	rel="stylesheet">
<link href="../Resources/vendor/swiper/swiper-bundle.min.css"
	rel="stylesheet">
<!-- Template Main CSS File -->
<link href="../Resources/css/main.css" rel="stylesheet">
<!-- Vendor JS Files -->
<script src="../Resources/js/bootstrap.bundle.js"></script>
<script src="../Resources/vendor/aos/aos.js"></script>
<script src="../Resources/vendor/glightbox/js/glightbox.min.js"></script>
<script src="../Resources/vendor/purecounter/purecounter_vanilla.js"></script>
<script src="../Resources/vendor/swiper/swiper-bundle.min.js"></script>
<script src="../Resources/vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="../Resources/vendor/php-email-form/validate.js"></script>
<link rel="stylesheet" href="../css/main.css" />
<!-- ------------------------------------------- -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<style>
a {
	text-decoration: none;
	color: black;
}
div.margind{
width:65%;
margin:30px;
margin-left:auto;
margin-right:auto;
}
th{
border-top:1px solid green;
}
div.scbox{
float:right;
margin-bottom:10px;
}
</style>
<!-- ---------header --------- -->


</head>
<body>
<%
int nCurrentPage = 0;
session.setAttribute("nCurrentPage", nCurrentPage);

%>
<header id="header" class="header d-flex align-items-center">
		<jsp:include page="../mainPage/header.jsp" />
	</header>
	<jsp:include page="../apoderado/adminHeader.jsp" />
	<% 
	ClientVO vo2 = null;
	Object obj = session.getAttribute("vo");
	
	if(obj !=null){
		vo2 = (ClientVO)obj;
	}
	
	//현재 페이지 
	String cp = request.getParameter("cp");
	int currentPage = 0;
	if (cp != null) {
		currentPage = Integer.parseInt(cp);
	} else {
		currentPage = 1;
	}

	//총 게시물 수
	CommunityDAO dao = new CommunityDAO();
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
	<div class="margind">
	<div class="scbox">
	<form action="searchResult.jsp" method="get"><input type="text" name="search" id="" size="15%" placeholder="검색어"/>
			<button type="submit" style="border:none; background-color:transparent"><img width="25px" src="https://icones.pro/wp-content/uploads/2021/06/icone-loupe-vert.png" alt=""></button></form></div>
		<table class="table table-hover">
		<thead class="table-success">
			<tr>
				<th width="7%">번호</th>
				<th width="50%" id="aligncenter">제목</th>
				<th width="10%">작성자</th>
				<th width="20%" id="aligncenter2">작성일</th>
				<th width="7%">조회</th>
			</tr>
			</thead>
			<%
			//최근 작성한 게시물 10개만 가져오기
			ArrayList<CommunityVO> list = dao.selectAll(startNo, endNo);
			for (CommunityVO vo : list) {
			%>
			<tr>
				<td><%=vo.getComno()%></td>
				<td>
				<a style="text-decoration:none; color:black" href="detail.jsp?comno=<%=vo.getComno()%>" ><%=vo.getComtitle()%></a></td>
				<td><%=vo.getClid()%></td>
				<td><%=vo.getComdate()%></td>
				<td><%=vo.getHits()%></td>
			</tr>

			<%}%>
			<tr>
				<td colspan="4">
					<!-- 부트스트랩 페이지네이션 -->
					<nav aria-label="Page navigation example">
						<ul class="pagination justify-content-center">
							<%if (isPre) {%>
							<li class="page-item"><a class="page-link" style="color:rgba(25,135,84)">Previous</a></li>
							<%}for (int i = startPage; i <= endPage; i++) {%>
							<li class="page-item"><a class="page-link"  style="color:rgba(25,135,84)" href="list.jsp?cp=<%=i%>"><%=i%></a></li>
							<%}if (isNext) {%>
							<li class="page-item"><a class="page-link" style="color:rgba(25,135,84)" href="#">Next</a></li>
							<%}%>
						</ul>
					</nav>
				</td>
			
			
			<td align="right">
			<% if(vo2!=null){ %>
				<a href="write.jsp"><input type="button" value="글쓰기" class="btn btn-outline-success" /></a>
			<%} %>
				</td>
			</tr>
		</table>
		
	</div>
	
</body>
</html>