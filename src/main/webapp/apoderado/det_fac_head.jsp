<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="top_nav">
	<%
	Object obj = session.getAttribute("vo");
	if (obj != null) {
		ClientVO vo = (ClientVO) obj;
	%>
	<div class="personal">
		<a href="../apoderado/mypage.jsp">마이페이지 </a><a href="../apoderado/logout.jsp">| 로그아웃</a>
	</div>
	<%
	} else {
	%>
	<div class="personal">
		<a href="../apoderado/login.jsp">로그인</a> <a href="../apoderado/register.jsp"> | 회원가입</a> 		
	</div>
	<%
	}
	%>
</div>
<div class="menubar">
	<button class="btn btn-light" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasWithBothOptions" aria-controls="offcanvasWithBothOptions">
		<img src="../images/menu1.png" alt="" id="menu" />
	</button>

	<div class="offcanvas offcanvas-start" data-bs-scroll="true" tabindex="-1" id="offcanvasWithBothOptions" aria-labelledby="offcanvasWithBothOptionsLabel">
		<div class="offcanvas-header">
			<h3 class="offcanvas-title" id="offcanvasWithBothOptionsLabel">DongDong</h3>
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
		</div>
		<div class="offcanvas-body">
			<a href="">종목별 찾기</a><br />
			<a href="">지역별 찾기</a><br /> 
			<a href="../community/list.jsp">용병게시판</a><br />
			<hr />
			<a href="">프로젝트 소개</a><br /> 
			<a href="">자주 묻는 질문</a><br /> 
			<a href="">시설 등록하기</a><br />
		</div>
	</div>
	<a href="../mainPage/main.jsp"><span class="logo">DongDong</span></a>
</div>