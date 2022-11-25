<%@page import="kr.co.dongdong.dao.FacilitiesDAO"%>
<%@page import="kr.co.dongdong.vo.ToprankVO"%>
<%@page import="kr.co.dongdong.vo.CommunityVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.dongdong.dao.CommunityDAO"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="../apoderado/bootLink.jsp"></jsp:include>
<head>
<meta charset="UTF-8">
<jsp:include page="../apoderado/adminHeader.jsp"></jsp:include>

<link rel="stylesheet" href="../css/main.css?after" />
<link rel="stylesheet" href="../css/search_bar.css" />
<link rel="stylesheet" href="../css/footer.css" />

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

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<style>
a {
	text-decoration: none;
	color: black;
}
</style>
<script>
	$(function() {
		// 날씨 api
		navigator.geolocation.getCurrentPosition(function(position) {
			var lat = position.coords.latitude; // 위도
			var lon = position.coords.longitude; // 경도
				
			console.log(lat+" : "+lon);
			
			var url = "https://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" 
					+ lon + "&units=metric&appid=c3c66caefd984bab1a92a38d3a97d5eb";
			
			$.getJSON(url, function(data) {
				var iconUrl = '<img src= "http://openweathermap.org/img/wn/'
                		+ data.weather[0].icon + '@4x.png" alt="' 
                		+ data.weather[0].description + '"/>'

				$(".weatherIcon").html(iconUrl);
				$(".location").append(data.name);
				$(".temp").append(data.main.temp.toFixed(1)+ "°");
				$(".humidity").append(data.main.humidity + "%");
				
				// 지역으로 찾기 
				$('.img_list li').last().prependTo('.img_list');	
			    $('.img_list').css('left',-240);
			    
				setInterval(function(){
					$('.img_list').animate({left:'-='+240},'slow',function(){
				    	$('.img_list li').first().appendTo('.img_list');
				        $('.img_list').css('left',-240);
				   	});
				},3000);
	
				$(".btn1").on("click", function(){
				   	$('.img_list')
				    $('.img_list').animate({left:'+='+240},'slow',function(){
				    	$('.img_list li').last().prependTo('.img_list');
				        $('.img_list').css('left',+240);
				    });
				});
				    
				$(".btn2").on("click", function(){
					$('.img_list').animate({left:'-='+240},'slow',function(){
				       	$('.img_list li').first().appendTo('.img_list');
				        $('.img_list').css('left',-240);
					});
				});
			});

		});
		
		// 검색창 유효성 검사 
		$("#text1").keydown(function(key){
			if(key.keyCode == 13) {
				if($("#text1").val()=="") {
					key.preventDefault();
					alert("검색어를 입력해주세요");
				}
			}
		});
		
		$("#btn1").on("click", function(e){
			if($("#text1").val()=="") {
				alert("검색어를 입력해주세요");
				e.preventDefault();
			}
		});
		
		
		// 광고
		var num = 1;
		
		setInterval(function() {
			if (num == 3) num = 1;
				$(".ad").attr("src", "../images/facad" + num + ".png"); num++;
		}, 3000);
			
		// 종목 이미지 마우스 오버 시 크기변경
		$("img.sport").hover(function() {
			$(this).animate({
					width : "90px",
					height : "90px"
			}, 300)
		}, function() {
			$(this).stop().animate({
					width : "80px",
					height : "80px"
			}, 300)
		});
		
		// 종목 이미지 클릭시 name의 값을 읽어 facevent의 parameter로
		$("img.sport").on("click", function() {
			var value = $(this).attr("name");
			console.log(value);
			location.href = "../search/list.jsp?facevent=" + value; // 파라미터 전달 페이지 링크 수정
		});
		
		<!-- 11/18 16:00 수정-->
		// 지역 이미지 클릭시 name의 값을 읽어 facloc의 parameter로
		$("img.loc").on("click", function() {
			var value = $(this).attr("name");
			console.log(value);
			location.href = "../search/list.jsp?facloc=" + value;
		});
	});	
</script>
</head>
<body>
	<%
	int nCurrentPage = 0;
	session.setAttribute("nCurrentPage", nCurrentPage);
	%>
	<header id="header" class="header d-flex align-items-center">
		<jsp:include page="header.jsp" />
	</header>
	<div>
		<jsp:include page="search_bar.jsp" />
	</div>
	<div class="main">
		<div class="main1">
			<div class="weather">
				<div class="weather-loc">
					<p class="location">
						<img src="../images/location.png" alt="" />
					</p>
				</div>
				<div class="weather-disc">
					<p class="weatherIcon"></p>
					<p class="temp"></p>
					<p class="humidity">습도 </p>
				</div>
			</div>
			<div>
				<img src="../images/facad1.png" alt="" class="ad" />
			</div>
		</div>
		<div class="main2">
			<div class="search-title">
				<h3>종목으로 찾기<span>.</span></h3>
			</div>
			<div class="search-event">
				<div class="event">
					<img src="../images/soccer.png" alt="축구" class="sport" name="0" /><br />
					<p>축구</p>
				</div>
				<div class="event">
					<img src="../images/baseball.png" alt="야구" class="sport" name="1" /><br />
					<p>야구</p>
				</div>
				<div class="event">
					<img src="../images/futsal.png" alt="풋살" class="sport" name="2" /><br />
					<p>풋살</p>
				</div>
				<div class="event">
					<img src="../images/badminton.png" alt="배드민턴" class="sport"
						name="3" /><br />
					<p>배드민턴</p>
				</div>
				<div class="event">
					<img src="../images/tennis.png" alt="테니스" class="sport" name="4" /><br />
					<p>테니스</p>
				</div>
				<div class="event">
					<img src="../images/basketball.png" alt="농구" class="sport" name="5" /><br />
					<p>농구</p>
				</div>
				<div class="event">
					<img src="../images/volleyball.png" alt="배구" class="sport" name="6" /><br />
					<p>배구</p>
				</div>
				<div class="event">
					<img src="../images/tabletennis.png" alt="탁구" class="sport"
						name="7" /><br />
					<p>탁구</p>
				</div>
			</div>
		</div>
		<div class="main3">
			<div class="search-title">
				<h3>지역으로 찾기<span>.</span></h3>
			</div>
			<div class="search-location">
				<img src="../images/prev.png" alt="이전 버튼" class="btn1" />
				<div class="wrap">
					<!-- 11/18 16:00 수정-->
					<ul class="img_list">
						<li><img src="../images/gangnam-1.png" alt="강동/송파" class="loc" name="송파구&facloc=강동구"></li>
						<li><img src="../images/gangnam-2.png" alt="강남/서초" class="loc" name="서초구&facloc=강남구"></li>
						<li><img src="../images/gangnam-3.png" alt="강서/양천/구로" class="loc" name="강서구&facloc=양천구&facloc=구로구"></li>
						<li><img src="../images/gangnam-4.png" alt="영등포/동작/관악" class="loc" name="영등포구&facloc=동작구&facloc=관악구"></li>
						<li><img src="../images/gangbuk-1.png" alt="마포/용산/종로" class="loc" name="마포구&facloc=용산구&facloc=종로구"></li>
						<li><img src="../images/gangbuk-2.png" alt="동대문/성동/광진/중랑" class="loc" name="동대문구&facloc=성동구&facloc=광진구&facloc=중랑구 "></li>
					</ul>
				</div>
				<img src="../images/next.png" alt="다음 버튼" class="btn2" />
			</div>
		</div>
		<div class="main4">
			<h3>예약 BEST<span>.</span></h3>
			<p>이번주 가장 인기있는 시설을 만나보세요!</p>
			<hr />
			<%
			FacilitiesDAO dao = new FacilitiesDAO();
			ArrayList<ToprankVO> list = dao.selectToprank();
			for (ToprankVO vo : list) {
			%>
			<div class="reservation-best">
				<%=vo.getRownum()%>
				<a href="../apoderado/detailFacilities.jsp?facno=<%=vo.getFacno()%>">
					<img src="<%=vo.getFacimg()%>" alt="" class="best" />
					<p><%=vo.getFacname()%></p>
				</a>
				<p>★<%=vo.getFacmark()%></p>
			</div>
			<%
			}
			%>
		</div>
		<div class="main5">
			<h3><a href="../community/list.jsp">용병게시판<span>.</span></a></h3>
			<p>함께 뛰면 즐거움이 두 배!</p><hr />
			<%
			CommunityDAO dao2 = new CommunityDAO();
			ArrayList<CommunityVO> list2 = dao2.selectAll(1, 5);
			for (CommunityVO vo : list2) {
			%>
			<div class="community-list">
				<a href="../community/detail.jsp?comno=<%=vo.getComno()%>"><%=vo.getComtitle()%></a>
			</div>  
			<%
			}
			%>
		</div>
		<div class="main6">
			<a href="fac_Register.jsp"><img src="../images/facad5.png" alt="시설등록 광고배너" class="regi-ad"/></a>
		</div>
	</div>
	<footer> 
		<jsp:include page="footer.jsp" />
	</footer>
</body>
</html>