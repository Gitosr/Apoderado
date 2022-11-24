<%@page import="kr.co.dongdong.dao.ReviewDAO"%>
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
/* ul.tabs li.current{
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
} */


element.style {
    padding-right: 0px;
    padding-left: 0px;
}


  </style>
<script type="text/javascript">
	$(function() {
		/* $('ul.nav li').click(function() {
			console.log("클릭");
			var tab_id = $(this).attr('data-tab');
			console.log(tab_id);
	
			$('ul.nav li').removeClass('current');
			$('.tab-content').removeClass('current');
			$('.tab-link').css("background","black");
	
			/* 현재 클릭한 li에 currnet 추가 */
			$(this).addClass('current');
			/* 현재 클릭한 li에 data-tab을 id로 하는 div에 current 추가 */
			$("#" + tab_id).addClass('current');
	
		}); */
		
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
		
		
		ReviewDAO rdao = new ReviewDAO();
		
		int rcnt = rdao.getTotal_facno(vo.getFacno());
		
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
                  <li class="d-flex align-items-center"><i class="bi bi-person"></i><%= facmark %></li>
                  <li class="d-flex align-items-center"><i class="bi bi-chat-dots"></i><%= rcnt %> Comments</li>
                </ul>
              </div>
              
				<hr class="border border-danger border-2 opacity-50">
				
              	<div class="content">
              	
              	
              	<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
				  <li class="nav-item" role="presentation">
				    <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">지도보기</button>
				  </li>
				  <li class="nav-item" role="presentation">
				    <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">주소</button>
				  </li>
				  <li class="nav-item" role="presentation">
				    <button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill" data-bs-target="#pills-contact" type="button" role="tab" aria-controls="pills-contact" aria-selected="false">이용안내</button>
				  </li>
				  <li class="nav-item" role="presentation">
				    <button class="nav-link" id="pills-disabled-tab" data-bs-toggle="pill" data-bs-target="#pills-review" type="button" role="tab" aria-controls="pills-review" aria-selected="false">이용후기</button>
				  </li>
				</ul>
				<div class="tab-content" id="pills-tabContent">
				  <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab" tabindex="0">
				  <h3>지도</h3>
					<jsp:include page="map.jsp">
						<jsp:param name="facno" value="<%=vo.getFacno()%>"></jsp:param> 	
					</jsp:include>
				  </div>
				  <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab" tabindex="0">
				  <h3>주소</h3>
					<p class="fw-bold"> <%=vo.getFacaddr() %> </p>
				  </div>
				  <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab" tabindex="0">
				  <h3>이용안내</h3>
					<h3>시설 이용안내</h3>
					<p class="fw-bold"><%=vo.getFacexplain() %></p>
				  </div>
	  				<div class="tab-pane fade" id="pills-review" role="tabpanel" aria-labelledby="pills-review-tab" tabindex="0">
	  				<h3>이용후기</h3>
						<jsp:include page="../review/fac_rev_list.jsp">
								<jsp:param name="facno" value="<%=vo.getFacno() %>"></jsp:param>
						</jsp:include>
	  				</div>
				  
				</div>
				<hr class="border border-danger border-2 opacity-50" side>

              </div><!-- End post content -->
              
              <div class="meta-bottom">
                <i class="bi bi-folder"></i>
                <ul class="cats">
                  <li><a href="#">Business</a></li>
                </ul>

                <i class="bi bi-tags"></i>
                <ul class="tags">
                  <li><a href="#">Creative</a></li>
                  <li><a href="#">Tips</a></li>
                  <li><a href="#">Marketing</a></li>
                </ul>
              </div><!-- End meta bottom -->

             

            </article><!-- End blog post -->

            

            

          </div>

          <div class="col-lg-4">

            <div class="sidebar">
            
            <div class="table-responsive">
			  <table class="table">
			  <tr>
				<td colspan="2"><jsp:include page="calendar.jsp" /></td>
				
			</tr>
			  <tr>
			  	<th>분류</th>
			  	<td><%= facevent %></td>
			  </tr>
			   <tr>
			  	<th>이용요금</th>
			  	<td><%= vo.getFacprice() %></td>
			   </tr>
			   <tr>
			  	<th>장소</th>
			  	<td><%= vo.getFacname() %></td>
			   </tr>
			   <tr>
			  	<th>주차장</th>
			  	<td><%= facparking %></td>
			   </tr>
			   <tr>
			  	<th>샤워장</th>
			  	<td><%= facshower %></td>
			   </tr>
			   <tr>
			  	<th>시설종류</th>
			  	<td><%= factype %></td> 
			   </tr>
			  
			  </table>
			</div>
			
			
					
			
			
			
			
			

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

              <%-- <div class="sidebar-item recent-posts">
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
				
				

              	</div><!-- End sidebar recent posts--> --%>
            

            </div><!-- End Blog Sidebar -->

          </div>
        </div>

      </div>
    </section><!-- End Blog Details Section -->
</body>
</html>