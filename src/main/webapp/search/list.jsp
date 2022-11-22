<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@page import="kr.co.dongdong.vo.FacilitiesVO"%>
<%@page import="kr.co.dongdong.dao.FacilitiesDAO"%>
<%@page import="test.Event"%>
<%@page import="java.util.ArrayList"%>
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
<link rel="stylesheet" href="../css/main.css" />

<!--  수정한 부분 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
	
<!--  ------------------------------------ -->

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

/* 수정함 */
#inheart{
	float:left;
	margin-bottom : 10px;
}
</style>
<script>
	$(function() {
		$("#dongdong").click
		
		$("li.mainmenu ul").hide();

		$("li.mainmenu").hover(function() {
			// 마우스가 올라오면 실행될 코드
			// 자신의 자식요소중 ul 요소 화면에 보이게 설정
			$("ul", this).stop().slideDown(500);
		}, function() {
			// 마우스를 치우면 실행될 코드
			$("ul", this).stop().slideUp(500);
		})

				
		$("#eventul .item").click(function(){
			console.log($("#headevent").text());
			console.log($(this).val());
			$("#headevent").text($(this).text());
		});
		$(".locul .item").click(function(){
			console.log($("#headloc").text());
			console.log($(this).text());
			$("#headloc").text($(this).text());
		});

		$(".item").click(function() {
							console.log($("#heventn").text);

							var esav = $("#esave").val();
							var lsav = $("#lsave").val();
							var activeTab = $(this).attr('data-tab');
							var activeTab1 = $(this).attr('data-tab1');
							var urlplus = "";
							var urlplus1 = "";
							
							if(activeTab == null){
								urlplus += esav;
							}else{
								urlplus += activeTab
							}
							if(activeTab1 == null){
								urlplus1 += lsav;
							}else{
								urlplus1 += activeTab1
							}
							var activeT = urlplus +"&"+ urlplus1;
							/* console.log(esav);
							console.log(lsav);*/
							//console.log("urlplus : "+ urlplus);
							//console.log("urlplus1 : "+ urlplus1); 
							//console.log("eventlist.jsp?fevent=" + urlplus+"&facloc="+urlplus1);
							
							$.ajax({
									type : 'GET', //get방식으로 통신
									async : true,
									url : "eventlist.jsp?fevent=" + urlplus+"&facloc="+urlplus1, //탭의 data-tab속성의 값으로 된 html파일로 통신
									dataType : "json", //html형식으로 값 읽기
									success : function(response, status,request) { //통신 성공시 탭 내용담는 div를 읽어들인 값으로 채운다.
										//console.log(response);
										//console.log(response[0].facevent);
										//var facevent = urlplus;
										if(response.empty == "empty"){
											alert("정보가 없습니다.");
										}else{
											
										
										var eventname = response[0].event; 
										//var floc = response[0].floc;
										var event = response;

										var data = "";

										data += "<h2>DongDong</h2>";
											
										data += "<p>나랑 " + eventname
													+ "가자~!</p>";
										data += "<input type='hidden' name='save' id='esave' value = '"+urlplus +"' />";
										data += "<input type='hidden' name='save' id='lsave' value = '"+urlplus1 +"' />";
										data += "<div class='row gy-4' data-aos='fade-up' data-aos-delay='100'>";
											
										event.forEach(function(el, index) {
											data += "<div class='col-lg-4 col-md-6'>";
											data += "<div class='service-item  position-relative'>";
											data += "<div id='imgdiv'><img src="+el.facimg+" alt="+el.facname+"/></div>";
											data += "<h3>"+ el.facname + "</h3>";
											data += "<p class='font-monospace'>"+ el.facaddr + "</p>";
											data += "<a href='detail.jsp?facno=" + el.facno + "' class='readmore stretched-link'>detail more <i class='bi bi-arrow-right'></i></a>";
											data += "</div>";
											data += "</div>";
										});
											data += "</div>";
											
										$("#dbody").empty();
										$("#dbody").append(data);}
										},
										error : function(request, status, error) {
											alert("code:" + request.status
													+ "\n" + "\n" + "error:"
													+ error);
										}
									});

						})
		
		
						
		
			});

</script>
</head>
<body>
	<section id="services" class="services sections-bg">
	<%
		int nCurrentPage = 1;
		session.setAttribute("nCurrentPage", nCurrentPage);
	%>
	<!-- 수정된 내용 -->
	<header id="header" class="header d-flex align-items-center">
		<jsp:include page="../mainPage/header.jsp" />
	</header> 
			<div class="container" data-aos="fade-up">

				<div class="section-header" id="dbody">
					<%
					// 종목구분 파라미터 받아오기
					String faceve = request.getParameter("facevent");
					//faceve = "3";
					// 지역 파라미터 받아오기
					//String facloc = request.getParameter("facloc");
					String facloc = "";
					String[] faclocArray = request.getParameterValues("facloc");
					//facloc = "송파구";
					String event = "";
					int cnt = 0;
					int facevent =-1;
					if(faceve == null && faclocArray == null){
						facloc = "전체";
						
					}
					else if(faceve != null && faclocArray != null){
						facevent = Integer.parseInt(faceve);
						for(String fa : faclocArray){
							facloc = fa;
							cnt ++;
							if(cnt<faclocArray.length) {
								facloc += "&facloc=";
							}
							//System.out.println(facloc);
						}
					}
					else if(faceve != null){
						facevent = Integer.parseInt(faceve);
						Event e = new Event();

						event += e.selectEvent(facevent);
						facloc = "전체";
					}else if(faclocArray != null){
						for(String fa : faclocArray){
							facloc = fa;
							cnt ++;
							if(cnt<faclocArray.length) {
								facloc += "&facloc=";
							}
							//System.out.println(facloc);
						} 
					}

					
						/* System.out.println("facevent" + facevent);
						System.out.println("facloc" + facloc); */
					%>

					<p>
						나랑
						<%=event%>
						가자~!
					</p>
					<input type="hidden" name="save" id="esave" value="<%=facevent%>" />
					<input type="hidden" name="save" id="lsave" value="<%=facloc%>" />


					<div class="row gy-4" data-aos="fade-up" data-aos-delay="100">
						<%
						FacilitiesDAO dao = new FacilitiesDAO();
						ArrayList<FacilitiesVO> list = new ArrayList<FacilitiesVO>();
						if(facevent == -1 && facloc.equals("전체")){
							list = dao.selectAll();
							System.out.println("dao.selectAll()실행");
							
						}else if(facevent != -1 && facloc.equals("전체") != true){
							list = dao.elAll(facevent, faclocArray);
							System.out.println("dao.elAll실행");
						}
						else if(facevent == -1){
							list = dao.locAll(faclocArray);
								
							System.out.println("dao.locAll실행");
						}else if(facloc.equals("전체")){
							//facevent = Integer.parseInt(fevent);
							list = dao.eventAll(facevent);
							System.out.println("dao.eventAll실행");
						}
						for (FacilitiesVO vo : list) {
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
						<div id = "inheart">
								<jsp:include page="../mainPage/interestsCheck.jsp"> 
								<jsp:param name="facno" value="<%=vo.getFacno() %>"></jsp:param>
								</jsp:include>
						</div>
						<%
						

						}
						%>

					</div>
				</div>
			</div>
	</section>

</body>
</html>