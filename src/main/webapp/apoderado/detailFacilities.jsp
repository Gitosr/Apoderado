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
<link rel="stylesheet" href="../css/detailFacilities.css" />

<script type="text/javascript">
<%
	Object obj2 = session.getAttribute("vo");
	int ch = -1;
	
	if(obj2 !=null) {
		ch = 0;
	}else {
		ch = 1;
	}
%>

	function openReserve() {
		var popupWidth = 460;
		var popupHeight = 800;

		var popupX = 2600;
		var popupY= 100;
		
		if(<%=ch%> == 0) {
			window.open("", "popOpen", 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY);
			reserve.target="popOpen";
			reserve.action="reserve.jsp";
			reserve.submit( );	
		}else {
			alert("???????????? ??????????????????.");
		}
		
	}
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
		
		//??????
		String facevent = "";
		
		Event e = new Event();
		facevent = e.selectEvent(vo.getFacevent());
		
		String facparking = "";
		if(vo.getFacparking()==1) {
			facparking = "??????";
		}else {
			facparking = "??????";
		}
		
		String facshower = "";
		if(vo.getFacshower()==1) {
			facshower = "??????";
		}else {
			facshower = "??????";
		}
		
		String facmark = "";
		if(vo.getFacmark() == 5){
			facmark = "???????????????";
		}else if(vo.getFacmark() >= 4){
			facmark = "???????????????";
		}else if(vo.getFacmark() >= 3){
			facmark = "???????????????";
		}else if(vo.getFacmark() >= 2){
			facmark = "???????????????";
		}else if(vo.getFacmark() >= 1){
			facmark = "???????????????";
		}else{
			facmark = "???????????????";
		}
		
		String factype = "";
		if(vo.getFactype()==1) {
			factype = "????????????";
		}else {
			factype = "????????????";
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
	
					<h2 class="title"><%=vo.getFacname() %> <jsp:include page="../mainPage/interestsCheck.jsp" /> </h2>
	
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
						    	<button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">????????????</button>
							</li>
							<li class="nav-item" role="presentation">
						    	<button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill" data-bs-target="#pills-contact" type="button" role="tab" aria-controls="pills-contact" aria-selected="false">????????????</button>
							</li>
							<li class="nav-item" role="presentation">
								<button class="nav-link" id="pills-disabled-tab" data-bs-toggle="pill" data-bs-target="#pills-review" type="button" role="tab" aria-controls="pills-review" aria-selected="false">????????????</button>
							</li>
						</ul>
						<div class="tab-content" id="pills-tabContent">
							<div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab" tabindex="0">
							<h3>??????</h3>
							<jsp:include page="map.jsp">
								<jsp:param name="facno" value="<%=vo.getFacno()%>"></jsp:param> 	
							</jsp:include>
							<h3>??????</h3>
							<h4><%=vo.getFacaddr() %></h4> 
						</div>
						<div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab" tabindex="0">
							<h3>?????? ????????????</h3>
							<p class="fw-bold"><%=vo.getFacexplain() %></p>
						</div>
						<div class="tab-pane fade" id="pills-review" role="tabpanel" aria-labelledby="pills-review-tab" tabindex="0">
				  			<h3>????????????</h3>
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
									<th>??????</th>
									<td><%= facevent %></td>
								</tr>
								<tr>
									<th>????????????</th>
									<td><%= vo.getFacprice() %> ???</td>
								</tr>
								<tr>
									<th>??????</th>
									<td><%= vo.getFacname() %></td>
								</tr>
								<tr>
									<th>?????????</th>
									<td><%= facparking %></td>
								</tr>
								<tr>
									<th>?????????</th>
									<td><%= facshower %></td>
								</tr>
								<tr>
									<th>????????????</th>
									<td><%= factype %></td> 
								</tr>
								<tr>
									<th>????????????</th>
									<td id="select_time" colspan="2">????????? ????????? ?????????</td>	
								</tr>
								<tr>
									<td colspan="2" id="btn_bar">
										<input type="button" value="????????????" onclick="openReserve();" type="button" class="btn btn-outline-primary" style="width:120pt;height:30pt;" />
									</td>
								</tr>
				  			</table>
						</div>
					</div><!-- End Blog Sidebar -->
				</div>
			</div>
		</div>
    </section><!-- End Blog Details Section -->
</body>
</html>