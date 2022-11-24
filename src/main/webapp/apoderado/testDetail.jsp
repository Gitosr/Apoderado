<%@page import="test.Event"%>
<%@page import="kr.co.dongdong.vo.FacilitiesVO"%>
<%@page import="kr.co.dongdong.dao.FacilitiesDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DongDong</title>

  <!-- Favicons -->
  <link href="../Resources/img/favicon.png" rel="icon">
  <link href="../Resources/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,600;1,700&family=Montserrat:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Raleway:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="../Resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="../Resources/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="../Resources/vendor/aos/aos.css" rel="stylesheet">
  <link href="../Resources/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="../Resources/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="../Resources/css/main.css" rel="stylesheet">
  
  
    <!-- Vendor JS Files -->
  <script src="../Resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="../Resources/vendor/aos/aos.js"></script>
  <script src="../Resources/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="../Resources/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="../Resources/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="../Resources/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="../Resources/vendor/php-email-form/validate.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

  <!-- Template Main JS File -->
  <script src="../Resources/js/main.js"></script>
  
  
  <meta name="viewport" content="width=device-width, initial-scale=1" >
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

  
  <style>
  .img-fluid {
    
    width: 450px;
}
ul.tabs li.current{
	background: #ededed;
	color: #222;
}
.tab-content{
	display: none;
	/* background: #ededed; */
	padding: 15px;
}

.tab-content.current{
	display: inherit;
}


  </style>
<script type="text/javascript">
	$(function() {
		$('ul.nav li').click(function() {
			console.log("클릭");
			var tab_id = $(this).attr('data-tab');
			console.log(tab_id);
	
			$('ul.nav li').removeClass('current');
			$('.tab-content').removeClass('current');
	
			/* 현재 클릭한 li에 currnet 추가 */
			$(this).addClass('current');
			/* 현재 클릭한 li에 data-tab을 id로 하는 div에 current 추가 */
			$("#" + tab_id).addClass('current');
	
		});
		
		$('#map_button').on("click", function(){

			var tab_id = $(this).attr('data-tab');
			
			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');
			$("ul.tabs li:nth-child(1)").addClass('current');
			$("#tab-1").addClass('current');
		});
	});
</script>
</head>
<body>
	<%
		String no = request.getParameter("facno");
		int facno = Integer.parseInt(no);
		
		FacilitiesDAO dao = new FacilitiesDAO();
		FacilitiesVO vo = dao.selectOne(facno);	
		//수정
		String facevent = "";
		/* if(vo.getFacevent()==0) {
			facevent = "축구장";
		}else if(vo.getFacevent()==1) {
			facevent = "야구장";
		}else if(vo.getFacevent()==2) {
			facevent = "풋살장";
		}else if(vo.getFacevent()==3) {
			facevent = "배드민턴";
		}else if(vo.getFacevent()==4) {
			facevent = "테니스";
		}else if(vo.getFacevent()==5) {
			facevent = "농구장";
		}else if(vo.getFacevent()==6) {
			facevent = "배구장";
		}else if(vo.getFacevent()==7) {
			facevent = "탁구장";
		} */
		Event e = new Event();
		facevent = e.selectEvent(vo.getFacevent());
		
		String facparking = "";
		if(vo.getFacparking()==1) {
			facparking = "있음";
		}else {
			facparking = "없음";
		}
		
		String facshower = "";
		if(vo.getFacshower()==1) {
			facshower = "있음";
		}else {
			facshower = "없음";
		}
		
		String facmark = "";
		if(vo.getFacmark() == 5){
			facmark = "★★★★★";
		}else if(vo.getFacmark() >= 4){
			facmark = "★★★★☆";
		}else if(vo.getFacmark() >= 3){
			facmark = "★★★☆☆";
		}else if(vo.getFacmark() >= 2){
			facmark = "★★☆☆☆";
		}else if(vo.getFacmark() >= 1){
			facmark = "★☆☆☆☆";
		}else{
			facmark = "☆☆☆☆☆";
		}
		
		String factype = "";
		if(vo.getFactype()==1) {
			factype = "사설시설";
		}else {
			factype = "공공시설";
		}
		int nCurrentPage = 0;
		session.setAttribute("nCurrentPage", nCurrentPage);
		%>
		
	<header id="header" class="header d-flex align-items-center">
	<jsp:include page="../mainPage/header.jsp" />
	</header>
<!-- ======= Blog Details Section ======= -->
    <section id="blog" class="blog">
      <div class="container" data-aos="fade-up">

        <div class="row g-5">

          <div class="col-lg-8">

            <article class="blog-details">

              <div class="post-img">
                <img src="<%=vo.getFacimg() %>" alt="" class="img-fluid">
              </div>

              <h2 class="title"><%=vo.getFacname() %></h2>

             <div class="meta-top">
                <ul>
                  <li class="d-flex align-items-center"><i class="bi bi-person"></i> <a href="blog-details.html"><%= facmark %></a></li>
                  <li class="d-flex align-items-center"><i class="bi bi-chat-dots"></i> <a href="blog-details.html">12 Comments</a></li>
                </ul>
              </div>
              
				<hr class="border border-danger border-2 opacity-50">
				
              	<div class="content">
              	
              	<ul class="nav nav-tabs">
					<li class="tab-link current" data-tab="tab-1">
						<a class="nav-link active" aria-current="page" href="#">지도보기</a>
					</li>
					<li class="tab-link" data-tab="tab-2">
					    <a class="nav-link" href="#">주소</a>
					</li>
					<li class="tab-link" data-tab="tab-3">
					    <a class="nav-link" href="#">이용안내</a>
					</li>
					<li class="tab-link" data-tab="tab-4">
					    <a class="nav-link" href="#">이용후기</a>
					</li>
				</ul>
               
               <div id="tab-1" class="tab-content current" >
				<h3>지도</h3>
				<jsp:include page="map.jsp">
					<jsp:param name="facno" value="<%=vo.getFacno()%>"></jsp:param> 	
				</jsp:include>
				</div>
				
				<div id="tab-2" class="tab-content" >	
				<h3>주소</h3>
				<p> <%=vo.getFacaddr() %> </p>
				</div>
				
				<div id="tab-3" class="tab-content" >
				<h3>이용안내</h3>
					<h3>시설 이용안내</h3>
					<p><%=vo.getFacexplain() %></p>
				</div>
				
				<div id="tab-4" class="tab-content">	
				
				<h3>이용후기</h3>
				<jsp:include page="../review/fac_rev_list.jsp">
						<jsp:param name="facno" value="<%=vo.getFacno() %>"></jsp:param>
				</jsp:include>
				</div>
				<hr class="border border-danger border-2 opacity-50">

              

              </div><!-- End post content -->

             

            </article><!-- End blog post -->

            

            

          </div>

          <div class="col-lg-4">

            <div class="sidebar">

              <%-- <div class="sidebar-item search-form">
                <h3 class="sidebar-title">분류</h3>
                <h4><%= facevent %></h4>
              </div> --%><!-- End sidebar search formn-->

              <!-- <div class="sidebar-item categories">
                <h3 class="sidebar-title">Categories</h3>
                <ul class="mt-3">
                  <li>General <span>(25)</span></li>
                  <li>Lifestyle <span>(12)</span></li>
                  <li>Travel <span>(5)</span></li>
                  <li><a href="#">Design <span>(22)</span></a></li>
                  <li><a href="#">Creative <span>(8)</span></a></li>
                  <li><a href="#">Educaion <span>(14)</span></a></li>
                </ul>
              </div>End sidebar categories -->

              <div class="sidebar-item recent-posts">
                <h3 class="sidebar-title">분류</h3>

                <div class="mt-3">

                  <div class="post-item mt-3">
                    <div>
                      <h4><a href="blog-details.html"><%= facevent %></a></h4>
                    </div>
                  </div><!-- End recent post item-->
				</div>
				
				
				<h3 class="sidebar-title">이용요금</h3>

                <div class="mt-3">

                  <div class="post-item mt-3">
                    <div>
                      <h4><a href="blog-details.html"><%= vo.getFacprice() %></a></h4>
                    </div>
                  </div><!-- End recent post item-->
				</div>
				
				
				
				<h3 class="sidebar-title">장소</h3>

                <div class="mt-3">

                  <div class="post-item mt-3">
                    <div>
                      <h4><a href="blog-details.html"><%= vo.getFacaddr() %></a></h4>
                    </div>
                  </div><!-- End recent post item-->
				</div>
				
				
				<h3 class="sidebar-title">시설등록일</h3>

                <div class="mt-3">

                  <div class="post-item mt-3">
                    <div>
                      <h4><a href="blog-details.html"><%= vo.getFacregister() %></a></h4>
                    </div>
                  </div><!-- End recent post item-->
				</div>
				
				
				<h3 class="sidebar-title">주차장</h3>

                <div class="mt-3">

                  <div class="post-item mt-3">
                    <div>
                      <h4><a href="blog-details.html"><%= facparking %></a></h4>
                    </div>
                  </div><!-- End recent post item-->
				</div>
				
				<h3 class="sidebar-title">샤워장</h3>

                <div class="mt-3">

                  <div class="post-item mt-3">
                    <div>
                      <h4><a href="blog-details.html"><%= facshower %></a></h4>
                    </div>
                  </div><!-- End recent post item-->
				</div>
				
				<h3 class="sidebar-title">시설종류</h3>

                <div class="mt-3">

                  <div class="post-item mt-3">
                    <div>
                      <h4><a href="blog-details.html"><%= factype %></a></h4>
                    </div>
                  </div><!-- End recent post item-->
				</div>
				
				

              	</div><!-- End sidebar recent posts-->
              	
              	
              	
              	
              	
              	
                  <!-- <div class="post-item">
                    <img src="../Resources/img/blog/blog-recent-2.jpg" alt="">
                    <div>
                      <h4><a href="blog-details.html">Quidem autem et impedit</a></h4>
                      <time datetime="2020-01-01">Jan 1, 2020</time>
                    </div>
                  </div>End recent post item

                  <div class="post-item">
                    <img src="../Resources/img/blog/blog-recent-3.jpg" alt="">
                    <div>
                      <h4><a href="blog-details.html">Id quia et et ut maxime similique occaecati ut</a></h4>
                      <time datetime="2020-01-01">Jan 1, 2020</time>
                    </div>
                  </div>End recent post item

                  <div class="post-item">
                    <img src="../Resources/img/blog/blog-recent-4.jpg" alt="">
                    <div>
                      <h4><a href="blog-details.html">Laborum corporis quo dara net para</a></h4>
                      <time datetime="2020-01-01">Jan 1, 2020</time>
                    </div>
                  </div>End recent post item

                  <div class="post-item">
                    <img src="../Resources/img/blog/blog-recent-5.jpg" alt="">
                    <div>
                      <h4><a href="blog-details.html">Et dolores corrupti quae illo quod dolor</a></h4>
                      <time datetime="2020-01-01">Jan 1, 2020</time>
                    </div>
                  </div>End recent post item -->

                

              <!-- <div class="sidebar-item tags">
                <h3 class="sidebar-title">Tags</h3>
                <ul class="mt-3">
                  <li><a href="#">App</a></li>
                  <li><a href="#">IT</a></li>
                  <li><a href="#">Business</a></li>
                  <li><a href="#">Mac</a></li>
                  <li><a href="#">Design</a></li>
                  <li><a href="#">Office</a></li>
                  <li><a href="#">Creative</a></li>
                  <li><a href="#">Studio</a></li>
                  <li><a href="#">Smart</a></li>
                  <li><a href="#">Tips</a></li>
                  <li><a href="#">Marketing</a></li>
                </ul>
              </div>End sidebar tags -->

            </div><!-- End Blog Sidebar -->

          </div>
        </div>

      </div>
    </section><!-- End Blog Details Section -->
</body>
</html>