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
<style>
a {
	text-decoration: none;
	color: black;
}
</style>
<script type="text/javascript">
$(function(){

	$("#text1").keydown(function(key){
		if(key.keyCode == 13) {
			console.log("엔터");
			if($("#text1").val()=="") {
				key.preventDefault();
				
				alert("검색어를 입력해주세요");
			}
		}
	});
	
	$("#btn1").on("click", function(e){
		console.log("클릭");
		if($("#text1").val()=="") {
			alert("검색어를 입력해주세요");
			e.preventDefault();
		}else {
			
		}
	});
});

</script>
</head>
<body>
	<%
	String keyword = request.getParameter("keyword");
	%>
	<header>
		<jsp:include page="header.jsp" />
	</header>
	<div class="result-list">
		<%
		if (keyword != null) {
		%>
		<h3>'<%=keyword%>'로 검색한 결과입니다.</h3>
		<div class="row row-cols-1 row-cols-md-3 g-4">
		<%
			FacilitiesDAO dao = new FacilitiesDAO();
			ArrayList<FacilitiesVO> list = dao.selectKeyword(keyword);

			for (FacilitiesVO vo : list) {
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