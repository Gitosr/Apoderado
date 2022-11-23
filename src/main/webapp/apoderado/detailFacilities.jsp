<%@page import="kr.co.dongdong.vo.FacilitiesVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.dongdong.dao.FacilitiesDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/main.css" />
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

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap"
	rel="stylesheet">
	
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


<style>
	* {
		margin: 0px;
		padding: 0px;
	}
	
	a {
		text-decoration: none;
		color: black;
	}
	
	.top_nav {
		width: 1080px;
		height: 30px;
		margin: 10px auto;
	}
	
	.personal {
		font: sans-serif;
		float: right;
		font-size: 12px;
		float: right;
	}
	
	.menubar {
		width: 1080px;
		height: 80px;
		margin: 0px auto;
	}
	
	#menu {
		width: 30px;
		height: 30px;
		margin: 15px;
	}
	
	.logo {
		font-family: 'Jua', sans-serif;
		font-size: 30px;
		width: 200px;
		height: 80px;
		position: relative;
		left: 350px;
		position: relative;
		height: 80px;
		width: 200px;
	}
	img {
		width: 550px;
		height: 300px;
	}
	
	ul.tabs {
		margin: 0px;
		padding: 0px;
		list-style: none;
	}
	
	ul.tabs li {
		background: none;
		color: #222;
		display: inline-block;
		padding: 10px 25px;
		cursor: pointer;
	}
	
	ul.tabs li.current {
		background: #ededed;
		color: #222;
	}
	
	.tab-content {
		display: none;
		padding: 15px 0;
		border-top: 3px solid #eee;
	}
	
	.tab-content.current {
		display: inherit;
	}
	#tab-1, #tab-2, #tab-3 {
		width: 1000px;
		heigth: 500px;
	}
	
	img.heart {
		width: 30px;
		height : 30px;
	}
	
	.custom_calendar_table td {
		width: 80px;
		height: 20px;
	}
	
	#heart_loc {
		text-align: right;
	}
		

</style>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$('ul.tabs li').click(function() {
	
			var tab_id = $(this).attr('data-tab');
	
			$('ul.tabs li').removeClass('current');
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
		
		String facevent = "";
		if(vo.getFacevent()==0) {
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
		}
		
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
		
		String factype = "";
		if(vo.getFactype()==1) {
			factype = "사설시설";
		}else {
			factype = "공공시설";
		}
	%>
	<%
	int nCurrentPage = 0;
	session.setAttribute("nCurrentPage", nCurrentPage);
	%>
		<header id="header" class="header d-flex align-items-center">
			<jsp:include page="../mainPage/header.jsp" />
		</header>
	<div class="container">
		<table class="table table-striped">
			<tr>
				<td rowspan="4">
					<img src="<%=vo.getFacimg() %>" alt="" />
				</td>
				<td colspan="2" id='heart_loc'><jsp:include page="../mainPage/interestsCheck.jsp" /></td>
			</tr>
			<tr>
				<th>분류</th>
				<td>: <%=facevent %></td>
			</tr>
			<tr>
				<th>평점</th>
				<td>: <%=vo.getFacmark() %></td>
			</tr>
			<tr>
				<th>이용요금</th>
				<td>: <%=vo.getFacprice() %></td>
			</tr>
			
			<tr>
				<td rowspan="6"><jsp:include page="calendar.jsp" /></td>
				<th>장소</th>
				<td>: <%=vo.getFacname() %> &nbsp; <a href="#tab-1"><input type="button" value="지도보기" id="map_button"/></a></td>
			</tr>
			<tr>
				<th>시설등록일</th>
				<td>: <%=vo.getFacregister() %></td>
			</tr>
			<tr>
				<th>관리자 아이디</th>
				<td>: <%=vo.getClid() %></td>
			</tr>
			<tr>
				<th>주차장</th>
				<td>: <%=facparking %></td>
			</tr>
			<tr>
				<th>샤워장</th>
				<td>: <%=facshower %></td>			
			</tr>
			<tr>
				<th>시설종류</th>				
				<td>: <%=factype %></td>
			</tr>
		</table>

		<ul class="tabs">
			<li class="tab-link current" data-tab="tab-1">지도보기</li>
			<li class="tab-link " data-tab="tab-2">이용안내</li>
			<li class="tab-link" data-tab="tab-3">이용후기</li>
		</ul>
		
		<div id="tab-1" class="tab-content current" style="width: 1000px; height: 500px;">
			<jsp:include page="map.jsp">
				<jsp:param name="facno" value="<%=vo.getFacno()%>"></jsp:param> 	
			</jsp:include>
			<h3>주소</h3>
			<p> <%=vo.getFacaddr() %> </p>
		</div>
		
		<div id="tab-2" class="tab-content" style="width: 1000px; height: 500px;">
			<h3>시설 이용안내</h3><%=vo.getFacexplain() %>
		</div>
		
		<div id="tab-3" class="tab-content" style="width: 1000px; height: 500px;">
			<jsp:include page="../review/fac_rev_list.jsp">
				<jsp:param name="facno" value="<%=vo.getFacno() %>"></jsp:param>
			</jsp:include>
		</div>
	</div>
</body>
</html>