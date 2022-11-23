<%@page import="kr.co.dongdong.vo.ReviewVO"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@page import="kr.co.dongdong.vo.FacilitiesVO"%>
<%@page import="kr.co.dongdong.dao.FacilitiesDAO"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>검색결과</title>

<link rel="stylesheet" href="../css/searchResult.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

</head>
<body>
	<%
		String keyword = request.getParameter("keyword");
		String re = keyword.replaceAll("[.,/]", " ");
		String re1 = re.replaceAll("\\s+", " ");
		String[] keywordArr = re1.split(" ");

	%>
	<header>
		<jsp:include page="header.jsp" />
		<jsp:include page="search_bar.jsp" />
	</header>
	<div class="result-list">
		<%
		if (keyword != null) {
			FacilitiesDAO dao = new FacilitiesDAO();
			
			ArrayList<Integer> list = dao.selectKeywordArr(keywordArr);
			ArrayList<FacilitiesVO> list2 = new ArrayList<FacilitiesVO>();
						
			for (Integer vo : list) {
				FacilitiesVO vo2 = dao.selectOne(vo);
				list2.add(vo2);
				System.out.println(vo2.getFacno() + "번 / 예약번호 ");
			}
			
		%>
		<h3>'<%=keyword%>'로 검색한 결과입니다.</h3>
		<div class="row row-cols-1 row-cols-md-3 g-4">
		<%
			for(FacilitiesVO vo : list2 ){
		%>
			 <div class="col">
	   			<div class="card h-100">
	   			<a href="../apoderado/detailFacilities.jsp?facno=<%=vo.getFacno() %>" class="btn btn-light">
					<img src=<%=vo.getFacimg()%> class="card-img-top" alt="...">
	   				<div class="card-body">
						<h5 class="card-title"><%=vo.getFacname()%></h5>
						<p class="card-text"><%=vo.getFacaddr()%></p>
					</div>
				</a>
				<jsp:include page="interestsCheck.jsp"> 
						<jsp:param name="facno" value="<%=vo.getFacno() %>"></jsp:param>
				</jsp:include>
				</div>
			</div>
		<%
			}	
		}else {	
		%>	
		<h1>검색어를 입력해주세요.</h1>
		</div>
	</div>
	<%
	}
	%>
</body>
</html>