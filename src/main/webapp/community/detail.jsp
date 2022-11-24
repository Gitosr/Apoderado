
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
text-align:right;
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
			if(clid2.equals(clid)|clid2.equals("admin")){ %>
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
					if(vo2.getClid().equalsIgnoreCase(x.getClid())|(vo2.getClid().equals("admin"))){ %>
					
					<a href="deletecomOk.jsp?clistno=<%=x.getClistno()%>&comno=<%=comno%>">
					<button type='button' style='border:none; background-color:transparent'><img width='25px' src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAkFBMVEX///8AgAAAewAAfgAAfADO5s7p9ekAeACgwqD7/vv1+/U2lDbb7dtRolEjjSOTw5N1tHW73LtiqmJoqmi927230bc2jTbE38QtkS2iyKJCmkLU6dSozah/t39ZpVkAhACWxZa+377r9euLwIuy1bKmzabj8uMXihdInUh5t3mizqKTxpODu4Nhq2Gaw5rY6NgPu2czAAAEfUlEQVR4nO3da3uaMACGYUjAFEE8dlih4hClta79//9uKO3aJjgOBpNyvc+nXRvD3AWBMHSG0UnOMBns3+xgMU3TNDr18NFd3vsv89/O/3i6COzQGyTDbobSRY69XcUm+4xc7nMh05+nA9VDr9Vw55qEms2jFoknnurhV/cSt+K9R8hIc2Posva8c5Y5dlQr/lNEr9h+H7FRotpxsS253pdHlnvVkguNr91DP7IyPbdiKmcLnolPOp4cvVjCe/Aj8qyaU9Ja3ibMY6Fqj9BC1puwiLqqQUJLifvoKZKqFnEFllygSUeqSVwz2ULT1OudOIilA8lRNepbko8zp+hKNepbk5KdlJJiZmiJ8ZNDUjYfITrNFp1MGCGlo83CtsMw9MTCIjsvmE7Tw8vzSjybkp1q1pc8EejbjdbgHIW9wJp3NNo2TYUtQKcNV+G4/E+JLjsZa7s2vJD6jddxEH5KsUaX3xN+dNas8To88XCs0aHmD/8mIq/NVyIIiUYTYUHI7puvRLhoYBrdlBKFQfOVCIcachth8hak0e5wGG/Gp7aP5ybnZufWo7XP//jpaNa4diuJrrwzF6zN0nvWXy9QaNkNNlpyJVNRu5Uwd3eN8YXKnzLIjhK3/VllI/96uotI1vagG6oeet1I87Nv0VzqvaUuY2+tgIn8WW1XkW0rYfRjNmHDy2BnWOR0cOuls2j4Puo6h9X7bFn0c3bSPP990HXu0N0zWqR60M0qxmz9qiVUPdgrohBCqH0QQqh/EEKofxBCqH8Q9kBY5zGcxP7J6fUAB0IIoT6VDLRNzkczxGd5tInJecxWZ+Gi70LS9NkyCLULQgghVB+EEEKoPgghhFB9EEIIofoghBDCL1G+FkvUWUSZMHO5lsIi/BKu8DEnYSXCEuqE4vcfeNxT8NQX7r/znzu1hK8z+V35RIFKITd86gsP0Y+5RciEX2IKIYQQQgghhBBCCCGEEEIIIYQQQgghhBBCCCGEEEIIIYQQQgghhBBCCCGEEEIIIYQQQgghhBBCCCGEEEIIIYQQQgghhBBCCCGEfRTe6pshIexMaEEIIYQQQgghhBDWFq4ghBBCCCGEEEIIFQppAGG9niCEEEIIIYSwslHvhWtthabddyGF8JbCTr4L+mZC059ziX9lxi8iXM8v+SUqj3A3FJoWV8l3slcvUr2EkCThzKp+KUVJ+m+4IVQYhDWb91440VYYexDW65FUv5aa4n3fhaYk4VFbYZbIEW57L+RnAdpUMidrV6qtcCXMydo1UC25FHmUAzSMyn+aURSRNHnKd9PqW0Iqor4soOHEqjGlsVdpQl3P+QN5Qk/HjUiEW1fXpONlTSxxExrGMNPucMo2MoEaHk6pK+ls/6+ZZvsplTQ1/Gy40moeTCLZQMPY+xoR2Vg+MD9lZNoQ2bELoGEkrh7vRUoO3QBz4lwHIsnSroB5kanaSNla0sT+QvuJpdJI2bLLDVjkTWKi5gKHErrayT7Pl7Y/rGPGyG3LX9B9Dm7iO5fYafRwd7seomi6b8f7Cyhu6Otq7xNSAAAAAElFTkSuQmCC' alt=''></button></a><%}} %>
					
					</td>
					
					</tr>
					<tr><td colspan=2 class='comscon'><%=x.getComscontents()%></td></tr>
					<tr class='line'><td  colspan=2 class='comsdate'><%=x.getComsdate()%></td></tr>
					<%} %>
				
					
			</tbody>
		</table>
	</div>
	<%}%>

</body>
</html>