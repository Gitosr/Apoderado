<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- <div class="top_nav">
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
	<a href="main.jsp"><span class="logo">DongDong</span></a>
</div>
<%
if (obj != null) {
	ClientVO vo = (ClientVO) obj;
%>
<div class="search-box">
	<%
	String[] sport = { "축구", "야구", "풋살", "배드민턴", "테니스", "농구", "배구", "탁구" };
	int num = (int) (Math.floor(Math.random() * 8));
	String sportname = sport[num];
	%>
	<form action="searchResult.jsp">
		<input type="text" class="search-text" name="keyword"
			placeholder="<%=vo.getClname()%>님, 오늘은 <%=sportname%> 어때요?"
			onfocus="this.placeholder=''"
				onblur="this.placeholder='<%=vo.getClname()%>님, 오늘은 <%=sportname%> 어때요?'" id="text1"/>
		<input type="image" src="../images/search.png" alt="" class="search-btn" id="btn1"/>
	</form>
</div>
<%
} else {
%>
<div class="search-box">
	<form action="searchResult.jsp">
		<input type="text" class="search-text" name="keyword"
			placeholder="종목, 지역으로 검색해보세요." onfocus="this.placeholder=''"
			onblur="this.placeholder='종목, 지역으로 검색해보세요.'" id="text1" /> 
		<input type="image" src="../images/search.png" alt="" class="search-btn" id="btn1"/>
	</form>
</div>
<%
}
%> --%>

<!--  밑에부터 수정된 내용 -->

    <div class="container-fluid container-xl d-flex align-items-center justify-content-between">
      <a href="../mainPage/main.jsp" class="logo d-flex align-items-center">
        <!-- Uncomment the line below if you also wish to use an image logo -->
        <!-- <img src="assets/img/logo.png" alt=""> -->
        <h1>DongDong<span>.</span></h1>
      </a>
      <nav id="navbar" class="navbar">
        <ul>
          <li><a href="">자주 묻는 질문</a></li>
          <li><a href="../community/list.jsp">용병게시판</a></li>
          <%
	          Object obj1 = session.getAttribute("nCurrentPage");
				if (obj1 != null) {
					int nCurrentPage = (int) obj1;
					System.out.println(nCurrentPage);
					if(nCurrentPage == 0){
						
				
          %>
          <li><a href="../search/list.jsp">종목,위치별로 찾아보기!</a></li>
          <%
					}
					else if(nCurrentPage == 1){
						
					
		   %>
          <li class="dropdown"><a data-tab="-1" class="item" href="#"><span id="headevent" value="값">종목</span> <i class="bi bi-chevron-down dropdown-indicator"></i></a>
            <ul id ="eventul">
              <li><a data-tab="-1" class="item" href="#"> 전체 </a></li>
              <li><a data-tab="0" class="item" href="#"> 축구장 </a></li>
              <li><a data-tab="1" class="item" href="#"> 야구장</a></li>
              <li><a data-tab="2" class="item" href="#"> 풋살장 </a></li>
              <li><a data-tab="3" class="item" href="#"> 배드민턴장 </a></li>
              <li><a data-tab="4" class="item" href="#"> 테니스장 </a></li>
              <li><a data-tab="5" class="item" href="#"> 농구장 </a></li>
              <li><a data-tab="6" class="item" href="#"> 배구장 </a></li>
              <li><a data-tab="7" class="item" href="#"> 탁구장 </a></li>
            </ul>
          </li>
          <li class="dropdown"><a data-tab1="전체" class="item" href="#"><span id="headloc">위치</span> <i class="bi bi-chevron-down dropdown-indicator"></i></a>
            <ul class ="locul">
                <li><a data-tab1="전체" class="item" href="#">전체</a></li>
              <li class="dropdown"><a href="#"><span>강남</span> <i class="bi bi-chevron-down dropdown-indicator"></i></a>
                <ul class ="locul">
                  <li><a data-tab1="서초구&facloc=강남구&facloc=송파구&facloc=강동구" class="item" href="#">서초구,강남구,송파구,강동구</a></li>
                  <li><a data-tab1="강서구&facloc=양천구&facloc=구로구" class="item" href="#">강서구,양천구,구로구</a></li>
                  <li><a data-tab1="영등포구&facloc=동작구&facloc=관악구" class="item" href="#">영등포구,동작구,관악구</a></li>
                </ul>
              </li>
              <li class="dropdown"><a href="#"><span>강북</span> <i class="bi bi-chevron-down dropdown-indicator"></i></a>
                <ul class ="locul">
                  <li><a data-tab1="마포구&facloc=용산구&facloc=종로구" class="item" href="#">마포구,용산구,종로구</a></li>
                  <li><a data-tab1="동대문구&facloc=성동구&facloc=광진구" class="item" href="#">동대문구,성동구,광진구</a></li>
                  <li><a data-tab1="과천시" class="item" href="#">과천시</a></li>
                  
                </ul>
              </li>
              
            </ul>
          </li>
          <%
          
					}
				}
			Object obj = session.getAttribute("vo");
			if (obj != null) {
				ClientVO vo = (ClientVO) obj;
			%>
			<li><a href="#">시설 등록하기</a></li>
			<li><a href="../apoderado/mypage.jsp">마이페이지</a></li>
          	<li><a href="../apoderado/logout.jsp">로그아웃</a></li>
			<%
			} else {
			%>
			<li><a href="../apoderado/login.jsp">로그인</a></li>
			<li><a href="../apoderado/register.jsp">회원가입</a></li>		
			
			<%
			}
			%>
        </ul>
      </nav><!-- .navbar -->

      <i class="mobile-nav-toggle mobile-nav-show bi bi-list"></i>
      <i class="mobile-nav-toggle mobile-nav-hide d-none bi bi-x"></i>

    </div>

