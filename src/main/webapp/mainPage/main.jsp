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
<head>
<meta charset="UTF-8">
<title>체육시설 쉐어 플랫폼, 동동</title>
<link rel="stylesheet" href="../css/main.css" />

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<style>
	a {
		text-decoration: none;
		color: black;
	}
</style>
<script>
	navigator.geolocation.getCurrentPosition(function(position) {
		var lat = position.coords.latitude; // 위도
		var lon = position.coords.longitude; // 경도
		
		console.log(lat+" : "+lon);

		$(function() {
			// 날씨 api
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
			if (num == 4) num = 1;
				$(".ad").attr("src", "../images/ad" + num + ".png"); num++;
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
		
		// 종목 이미지 클릭시 name의 값을 읽어 event의 parameter로
		$("img.sport").click(function() {
			var value = $(this).attr("name");
			console.log(value);
			location.href = "facList.jsp?event=" + value;
		});
		
		<!-- 11/18 16:00 수정-->
		// 지역 이미지 클릭시 name의 값을 읽어 event의 parameter로
		$("img.region").click(function() {
			var value = $(this).attr("name");
			console.log(value);
			location.href = "facList.jsp?region=" + value;
		});
	});	
</script>
</head>
<body>
	<header>
		<jsp:include page="header.jsp" />
	</header>
	<div class="main">
		<div class="main1">
			<div class="weather">
				<p class="location"><img src="../images/location.png" alt="" /></p>
				<p class="weatherIcon"></p>
				<p class="temp"></p>
				<p class="humidity">습도</p>
			</div>
			<div>
				<img src="../images/ad1.png" alt="" class="ad" />
			</div>
		</div>
		<div class="main2">
			<div class="search-title">
				<h3>종목으로 찾기</h3>
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
					<img src="../images/tabletennis.png" alt="탁구" class="sport" name= "7" /><br />
					<p>탁구</p>
				</div>
			</div>
		</div>
		<div class="main3">
			<div class="search-title">
				<h3>지역으로 찾기</h3>
			</div>
			<div class="search-location">
				<img src="../images/prev.png" alt="이전 버튼" class="btn1" />
				<div class="wrap">
					<!-- 11/18 16:00 수정-->
					<ul class="img_list">
						<li><img src="../images/gangbuk.png" alt="강북" class="region" name="강북"></li>
						<li><img src="../images/nowon.png" alt="노원" class="region" name="노원"></li>
						<li><img src="../images/dobong.png" alt="도봉" class="region" name="도봉"></li>
						<li><img src="../images/seongbuk.png" alt="성북" class="region" name="성북"></li>
						<li><img src="../images/gwangjin.png" alt="광진" class="region" name="광진"></li>
						<li><img src="../images/dongdaemun.png" alt="동대문" class="region" name="동대문"></li>
						<li><img src="../images/seongdong.png" alt="성동" class="region" name="성동"></li>
						<li><img src="../images/jungnang.png" alt="중랑" class="region" name="중랑"></li>
						<li><img src="../images/yongsan.png" alt="용산" class="region" name="용산"></li>
						<li><img src="../images/jongro.png" alt="종로" class="region" name="종로"></li>
						<li><img src="../images/junggu.png" alt="중구" class="region" name="중구"></li>
						<li><img src="../images/mapo.png" alt="마포" class="region" name="마포"></li>
						<li><img src="../images/seodaemun.png" alt="서대문" class="region" name="서대문"></li>
						<li><img src="../images/eunpyeong.png" alt="은평" class="region" name="은평"></li>
						<li><img src="../images/gangdong.png" alt="강동" class="region" name="강동"></li>
						<li><img src="../images/songpa.png" alt="송파" class="region" name="송파"></li>
						<li><img src="../images/gangnam.png" alt="강남" class="region" name="강남"></li>
						<li><img src="../images/seocho.png" alt="서초" class="region" name="서초"></li>
						<li><img src="../images/gangseo.png" alt="강서" class="region" name="강서"></li>
						<li><img src="../images/yangcheon.png" alt="양천" class="region" name="양천"></li>
						<li><img src="../images/guro.png" alt="구로" class="region" name="구로"></li>
						<li><img src="../images/yeongdeungpo.png" alt="영등포" class="region" name="영등포"></li>
						<li><img src="../images/gwanak.png" alt="관악" class="region" name="관악"></li>
						<li><img src="../images/geumcheon.png" alt="금천" class="region" name="금천"></li>
						<li><img src="../images/dongjak.png" alt="동작" class="region" name="동작"></li>
					</ul>
				</div>
				<img src="../images/next.png" alt="다음 버튼" class="btn2" />
			</div>
		</div>
		<div class="main4">
			<h3>예약 BEST</h3>
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
				<p>★<%=vo.getFacmark()%> / 5</p>
				
			</div>
			<%
			}
			%>
		</div>
		<div class="main5">
			<a href="../community/list.jsp"><h3>용병게시판</h3></a>
			<p>~~를 자유롭게 구하고 함께 뛰어요!</p>
			<hr />
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
	</div>
	<footer>
	</footer>
</body>
</html>