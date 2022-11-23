
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

<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<style>
.comsdate{
font-size: 0.8rem;
color : gray;
}
.comscon{
font-size: 0.9rem;
}
.mini{
font-size: 0.5rem;
color : gray;
width:40%;
}

.comtitle{
font-size: 1.2rem;
}

.line{border-bottom:0.5px solid rgba(209,231,221);}

div.margind{
width:65%;
margin-top:30px;
margin-left:auto;
margin-right:auto;
}

</style>

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

	
	String no = request.getParameter("comno");
	if (no != null) {
		int comno = Integer.parseInt(no);
		
		CommunityDAO dao = new CommunityDAO();
		dao.raiseHits(comno); //조회수 1 증가시킴
		CommunityVO vo = dao.selectOne(comno);

	%>
	<div class="margind">
	<table class="table table-hover">
	<thead class="table-success">
		<tr>
			<th width="60%" class='comtitle'><%= vo.getComtitle() %></th>
			<td class='mini'>작성자 | <%=vo.getClid()%> |	조회수 | 
			<%=vo.getHits()%> | 작성일시 | <%=vo.getComdate()%></td>
		</tr>
		</thead>
		<tr>
			<td colspan="2" class='comfield'><%=vo.getComfield() %></td>
		</tr>
		<tr>
			<td></td><td align="right">
			<a href="list.jsp"><button type="button" class="btn btn-outline-success">목록</button></a>
			
			<%
			String clid2 ="";
			if(vo2!=null){
			clid2 = vo2.getClid();}
			
			String clid = vo.getClid();
			if(clid2.equals(clid)){ %>
			<a href="modify.jsp?comno=<%=vo.getComno()%>">
			<button type="button" class="btn btn-outline-success">수정</button></a>
			<a href="deleteOk.jsp?comno=<%=vo.getComno()%>">
			<button type="button" class="btn btn-outline-success">삭제</button></a><%} %>
			</td>
		</tr>
	</table>
</div>
	<br>
	
	<div class="margind">
		<table>
			<thead>
			<tr>
					<th>댓글</th>
					<th colspan=3></th>
				</tr>
			<%
			if(obj!=null){ %>
			<tr>
				<form action="writecomOk.jsp" method="post" name="frm">
					<td colspan="3"><input type='text' name='txtComscontents' size="80%" id='txtComscomtents' /></td>
					 <input type="hidden" name="comno" value="<%=vo.getComno()%>" />
					<td><input type='submit' value='등록' class="btn btn-outline-success"/></td>
				</form>
				</tr><%} %>
				
				
			</thead>

			<tbody id="dynamicTbody">
			
			<% CommentsDAO dao2 = new CommentsDAO();
			CommentsVO vo3 = new CommentsVO();
			ArrayList<CommentsVO> list = dao2.selectOne(comno); 
				for (CommentsVO x : list) { %>
				<tr>
					<td rowspan=3 width="10%"><img width="60%" src="https://ssl.pstatic.net/static/cafe/cafe_pc/default/cafe_profile_77.png?type=c77_77" alt="" /></td>
					<th colspan=2><%=x.getClid()%></th>
						<td rowspan=3 width="20%">
					<% if(vo2!=null){
					if(vo2.getClid().equalsIgnoreCase(x.getClid())){ %>
					
					<a href="deletecomOk.jsp?clistno=<%=x.getClistno()%>&comno=<%=comno%>">
					<input type="button" value="삭제"  class="btn btn-outline-success"/></a><%}} %>
					
					</td>
					
					</tr>
					<tr><td  colspan=2 class='comscon'><%=x.getComscontents()%></td></tr>
					<tr class='line'><td  colspan=2class='comsdate'><%=x.getComsdate()%></td></tr>
					<%} %>
				
					
			</tbody>
		</table>
	</div>
	<%}%>

</body>
</html>