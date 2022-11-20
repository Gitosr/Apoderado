<%@page import="test.Event"%>
<%@page import="kr.co.dongdong.vo.FacilityVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.dongdong.dao.FacilityDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Favicons -->
<!--  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  Google Fonts
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,600;1,700&family=Montserrat:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Raleway:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet">
 -->
<!-- Vendor CSS Files -->
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

<!-- Template Main JS File -->
<script src="../Resources/js/main.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="semantic/semantic.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"
	integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
	crossorigin="anonymous"></script>
<script src="semantic/semantic.js"></script>
<style>
img {
	width: 100%;
	height: 190px;
	border: 2px solid black;
	border-radius: 10px;
	border: 2px solid black;
}

#imgdiv {
	width: 250px;
	height: 200px;
	margin: auto;
}

.service-item {
	padding: 30px;
}

.mainmenu {
	float: left;
	width: 150px;
	list-style-type: none;
}

li.mainmenu ul {
	margin: 0;
	list-style-type: none;
	padding: 0;
}

.mainmenu a {
	width: 150px;
	color: white;
	display: block; /* 인라인요소를 블럭요소로 변경 */
	background: green;
	text-decoration: none;
	padding: 10px;
	border-bottom: 1px solid #ffffff;
}

#dropdownmenu li a:hover {
	background: black;
}

#bar {
	width: 100%;
	background: blue;
}

.section-header p {
	margin-bottom: 50px;
}
</style>
<script>
	$(function() {
		$("li.mainmenu ul").hide();

		$("li.mainmenu").hover(function() {
			// 마우스가 올라오면 실행될 코드
			// 자신의 자식요소중 ul 요소 화면에 보이게 설정
			$("ul", this).stop().slideDown(500);
		}, function() {
			// 마우스를 치우면 실행될 코드
			$("ul", this).stop().slideUp(500);
		})

		$("#emenu").click(
				function() {
					$(".ui.sidebar")
							.sidebar('setting', 'transition', 'overlay')
							.sidebar("toggle");
				})
		$("#lmenu").click(
				function() {
					$("#locmenu")
							.sidebar('setting', 'transition', 'overlay')
							.sidebar("toggle");
				})

		$(".item")
				.click(
						function() {
							

							var esav = $("#esave").val();
							var lsav = $("#lsave").val();
							var activeTab = $(this).attr('data-tab');
							var activeTab1 = $(this).attr('data-tab1');
							if(activeTab == null){
								activeTab = "fevent="+esav;
							}
							if(activeTab1 == null){
								activeTab1 = "facloc="+lsav;
							}
							var activeT = activeTab +"&"+ activeTab1;
							console.log(esav);
							console.log(lsav);
							console.log("activeTab : "+ activeTab);
							console.log("activeTab1 : "+ activeTab1);
							console.log("activeT : "+ activeT);
							
							console.log(activeTab);
							$
									.ajax({
										type : 'GET', //get방식으로 통신
										async : true,
										url : "eventlist.jsp?" + activeT, //탭의 data-tab속성의 값으로 된 html파일로 통신
										dataType : "json", //html형식으로 값 읽기
										success : function(response, status,
												request) { //통신 성공시 탭 내용담는 div를 읽어들인 값으로 채운다.
											//console.log(response);
											//console.log(response[0].facevent);
											var facevent = response[0].facevent;
											var eventname = response[0].event;
											var facloc = response[0].facloc;
											var event = response;

											var data = "";

											data += "<h2>" + eventname + "</h2>";
											
											data += "<p>나랑 " + eventname
													+ "가자~!</p>";
											data += "<input type='hidden' name='save' id='esave' value = '"+facevent +"' />";
											data += "<input type='hidden' name='save' id='lsave' value = '"+facloc +"' />";
											data += "<div class='row gy-4' data-aos='fade-up' data-aos-delay='100'>";
											
											event
													.forEach(function(el, index) {

														data += "<div class='col-lg-4 col-md-6'>";
														data += "<div class='service-item  position-relative'>";
														data += "<div id='imgdiv'><img src="+el.facimg+" alt="+el.facname+"/></div>";
														data += "<h3>"
																+ el.facname
																+ "</h3>";
														data += "<p class='font-monospace'>"
																+ el.facaddr
																+ "</p>";
														data += "<a href='detail.jsp?facno="
																+ el.facno
																+ "' class='readmore stretched-link'>detail more <i class='bi bi-arrow-right'></i></a>";
														data += "</div>";
														data += "</div>";

													});
											data += "</div>";
											
											$("#dbody").empty();
											$("#dbody").append(data);

										},
										error : function(request, status, error) {
											alert("code:" + request.status
													+ "\n" + "\n" + "error:"
													+ error);
										}
									});

						})

	})
</script>
</head>
<body>

	<section id="services" class="services sections-bg">


		<div class="ui sidebar inverted vertical menu">
			<a data-tab="fevent=-1" class="item"> 전체 </a>
			<a data-tab="fevent=0" class="item"> 축구장 </a>
			<a data-tab="fevent=1" class="item"> 야구장 </a>
			<a data-tab="fevent=2" class="item"> 풋살장 </a>
			<a data-tab="fevent=3" class="item"> 배드민턴장 </a>
			<a data-tab="fevent=4" class="item"> 테니스장 </a>
			<a data-tab="fevent=5" class="item"> 농구장 </a>
			<a data-tab="fevent=6" class="item"> 배구장 </a>
			<a data-tab="fevent=7" class="item"> 탁구장 </a>
		</div>
		<div class="ui sidebar inverted vertical menu" id = "locmenu">
			<a data-tab1="facloc=" class="item"> 전체</a>
			<a data-tab1="facloc=서초구" class="item"> 서초구</a>
			<a data-tab1="facloc=송파구" class="item"> 송파구 </a>
			<a data-tab1="facloc=광진구" class="item"> 광진구 </a>
			<a data-tab1="facloc=성동구" class="item"> 성동구 </a> 
			<a data-tab1="facloc=마포구" class="item"> 마포구 </a>
			<a data-tab1="facloc=영등포구" class="item"> 영등포구 </a>
			<a data-tab1="facloc=양천구" class="item"> 양천구 </a>
			<a data-tab1="facloc=구로구" class="item"> 구로구 </a>
		</div>
		<div class="pusher">
			<button id="emenu" class="ui button">종목</button>
			<button id="lmenu" class="ui button">지역</button>


			<div class="container" data-aos="fade-up">

				<div class="section-header" id="dbody">
	<%
	// 종목구분 파라미터 받아오기
	String faceve = request.getParameter("facevent");
	//faceve = "3";
	// 지역 파라미터 받아오기
	String facloc = request.getParameter("facloc");
	facloc = "송파구";
	String event ="";

	if(faceve != null || facloc != null){
		int facevent = -1;
		if(faceve != null){
			facevent = Integer.parseInt(faceve);
		}
			Event e = new Event();
			
			event += e.selectEvent(facevent);
		
		if(facloc == null){
			facloc = "";
		}
		System.out.println("facevent"+facevent);
		System.out.println("facloc"+facloc);
		
		
	%>

					<h2><%=event%></h2>
					<h3><%= facloc %></h3>
					<p>
						나랑
						<%=event%>
						가자~!
					</p>
					<input type="hidden" name="save" id="esave" value = "<%=facevent %>" />
					<input type="hidden" name="save" id="lsave" value = "<%=facloc %>" />


					<div class="row gy-4" data-aos="fade-up" data-aos-delay="100">
						<%
						FacilityDAO dao = new FacilityDAO();
						ArrayList<FacilityVO> list = new ArrayList<FacilityVO>();
						if(facevent == -1){ // 첫화면 지역 클릭시
							list = dao.locAll(facloc);
							
						}else if(facloc == ""){ // 첫화면 종목 클릭시
							list = dao.eventAll(facevent);
						}
						for (FacilityVO vo : list) {
						%>
						<div class="col-lg-4 col-md-6">
							<div class="service-item  position-relative">
								<div id="imgdiv">
									<img src="<%=vo.getFacimg()%>" alt="<%=vo.getFacname()%>" />
								</div>
								<h3><%=vo.getFacname()%></h3>
								<p class="font-monospace"><%=vo.getFacaddr()%></p>
								<a href="detail.jsp?facno=<%=vo.getFacno()%>"
									class="readmore stretched-link">detail more <i
									class="bi bi-arrow-right"></i></a>
							</div>
						</div>
						<%
						}
						
						
	}
						%>

					</div>
				</div>
			</div>
			</div>
	</section>

</body>
</html>