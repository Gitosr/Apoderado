<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!--  밑에부터 수정된 내용 -->

    <div class="container-fluid container-xl d-flex align-items-center justify-content-between">
      <a href="../mainPage/main.jsp" class="logo d-flex align-items-center">
        <!-- Uncomment the line below if you also wish to use an image logo -->
        <!-- <img src="assets/img/logo.png" alt=""> -->
        <h1>DongDong<span>.</span></h1>
      </a>
      <nav id="navbar" class="navbar">
        <ul>
          <li><a href="../notice/list.jsp">공지사항</a></li>
          <li><a href="../community/list.jsp">용병게시판</a></li>
          <%
	          Object obj1 = session.getAttribute("nCurrentPage");
				if (obj1 != null) {
					int nCurrentPage = (int) obj1;
					System.out.println(nCurrentPage);
					if(nCurrentPage == 0){
						
				
          %>
          <li><a href="../search/list.jsp">종목/지역별로 찾아보기!</a></li>
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
          <li class="dropdown"><a data-tab1="전체" class="item" href="#"><span id="headloc">지역</span> <i class="bi bi-chevron-down dropdown-indicator"></i></a>
            <ul class ="locul">
                <li><a data-tab1="전체" class="item" href="#">전체</a></li>
              <li class="dropdown"><a href="#"><span>강남</span> <i class="bi bi-chevron-down dropdown-indicator"></i></a>
                <ul class ="locul">
                  <li><a data-tab1="송파구&facloc=강동구" class="item" href="#">강동/송파</a></li>
                  <li><a data-tab1="서초구&facloc=강남구" class="item" href="#">강남/서초</a></li>
                  <li><a data-tab1="강서구&facloc=양천구&facloc=구로구" class="item" href="#">강서/양천/구로</a></li>
                  <li><a data-tab1="영등포구&facloc=동작구&facloc=관악구" class="item" href="#">영등포/동작/관악</a></li>
                </ul>
              </li>
              <li class="dropdown"><a href="#"><span>강북</span> <i class="bi bi-chevron-down dropdown-indicator"></i></a>
                <ul class ="locul">
                  <li><a data-tab1="마포구&facloc=용산구&facloc=종로구" class="item" href="#">마포/용산/종로</a></li>
                  <li><a data-tab1="동대문구&facloc=성동구&facloc=광진구&facloc=중랑" class="item" href="#">동대문/성동/광진/중랑</a></li>
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
			<li><a href="../mainPage/fac_Register.jsp">시설 등록하기</a></li>
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

