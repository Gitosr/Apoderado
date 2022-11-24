
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


<style>
.mini{
font-size: 0.5rem;
color : gray;
text-align:right;
width:40%;
}
a {
	text-decoration: none;
	color: black;
}
.facnametd{
font-size: 0.9rem;
color : gray;
}
div.margind{
width:65%;
margin:30px;
margin-left:auto;
margin-right:auto;
}
#title{
font-size:1.2rem;
}
</style>

<title>Insert title here</title>

<!-- --------header  -------- -->
<link rel="stylesheet" href="../css/main.css" />

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

</head>
<body>

<header id="header" class="header d-flex align-items-center">
		<jsp:include page="../mainPage/header.jsp" />
	</header>
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
	<div class="margind">
	<table class="table">
	<thead class="table-success">
		<tr>
			<th width="60%" id="title"><%= vo.getNottitle()%></th>
		<td class='mini'>작성자 | <%=vo.getClid()%> |	조회수 | 
			<%=vo.getNothits()%> | 작성일시 | <%=vo.getNotdate()%></td></tr>
		<%int facno = vo.getFacno();
				String facname = dao.selectFacname(facno);
				%>
		<tr><td class='facnametd' colspan=2>시설명 : <%=facname %></td></tr></thead>
		
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
			if(clid2.equals(clid)|(clid2.equals("admin"))){ %>
			<a href="modify.jsp?notno=<%=vo.getNotno()%>">
			<input type="button" value="수정" class="btn btn-outline-success"/></a>
			<a href="deleteOk.jsp?notno=<%=vo.getNotno()%>">
			<input type="button" value="삭제" class="btn btn-outline-success"/></a><%} %>
			</td>
		</tr>
	</table>
	</div>
	
	
	<%}%>

</body>
</html>