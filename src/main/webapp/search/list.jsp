<%@page import="kr.co.dongdong.dao.InterestsDAO"%>
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

<link rel="stylesheet" href="../css/footer.css" />
<link rel="stylesheet" href="../css/search_bar.css?after" />

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
/* 폰트 수정 */
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
.facName-font {
	font-family: 'GmarketSansMedium';
}
img {
	width: 100%;
	height: 190px;
	border: 2px solid darkgrey;
	border-radius: 10px;
}
/* 하트 이미지 테두리 제거*/
img.heart {
	border: none;
	width : 30px;
	height : 30px;
}

#imgdiv {
	width: 250px;
	height: 200px;
	margin: 10px auto;
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

/* 수정함 
#inheart img{
	float:left;
	margin-bottom : 10px;
	width : 30px;
	height : 30px;
}*/

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

				
		$("#eventul .item").click(function(){
			//console.log($("#headevent").text());
			//console.log($(this).val());
			$("#headevent").text($(this).text());
		});
		$(".locul .item").click(function(){
			/* console.log($("#headloc").text());
			console.log($(this).text()); */
			$("#headloc").text($(this).text());
		});
		
		/* $("#inheart .heart").on("click" , function(){
			console.log("test");
		}) */
		
		$(document).on("click", "#inheart .heart", function() {
			console.log($(this).attr("src"));
			var images = $(this);
			console.log(images);
			console.log($(this).attr("id"));
			
			var clid = $("#cvoclid").val();
			var facno = $(this).attr("id");
			
			$.ajax({
				url : "../mainPage/interestsOk.jsp",
				type : "GET",
				data : {
					"clid" : clid,
					"facno" : facno
				},
				success : function(data) {
					//console.log(data+"상태");
					var result = data;
					if (result == 0) { // 데이터가 없는 경우
						
						images.attr("src", "../images/heart.png"); // 하트 채우기
					} else {
						
						images.attr("src", "../images/empty-heart.png"); // 하트 비우기
					}
				},
				error : function(data) {
					alert("에러 발생");
				}
			});	
				  
		})
		
		
		//$(".item").click(function()

		$(document).on("click", ".item", function() {
			console.log($("#heventn").text);

			var esav = $("#esave").val();
			var lsav = $("#lsave").val();
			var activeTab = $(this).attr('data-tab');
			var activeTab1 = $(this).attr('data-tab1');
			var dataPage = $(this).attr('data-page');
			console.log(dataPage);
			var urlplus = "";
			var urlplus1 = "";
			var urlpage = "";
			if(dataPage == null){
				urlpage = "1";
			}else{
				urlpage = dataPage;
				
			}
							
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
			console.log("urlplus : "+ urlplus);
			console.log("urlplus1 : "+ urlplus1); 
			//console.log("eventlist.jsp?fevent=" + urlplus+"&facloc="+urlplus1);
							
			$.ajax({
					type : 'GET', //get방식으로 통신
					async : true,
					url : "eventlist.jsp?fevent=" + urlplus+"&facloc="+urlplus1+"&cp="+urlpage, //탭의 data-tab속성의 값으로 된 html파일로 통신
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

						data += "<input type='hidden' name='save' id='esave' value = '"+urlplus +"' />";
						data += "<input type='hidden' name='save' id='lsave' value = '"+urlplus1 +"' />";
						data += "<div class='row gy-4' data-aos='fade-up' data-aos-delay='100'>";
											
						event.forEach(function(el, index) {
							//console.log(el.facno);
							data += "<div class='col-lg-4 col-md-6'>";
							data += "<div class='service-item  position-relative'>";
							data += "<div id='imgdiv'><a href='../apoderado/detailFacilities.jsp?facno=" + el.facno + "'><img src="+el.facimg+" alt="+el.facname+"/></a></div>";
							data += "<h3>"+ el.facname + "</h3>";
							data += "<p class='font-monospace'>"+ el.facaddr + "</p>";
							data += "<a href='../apoderado/detailFacilities.jsp?facno=" + el.facno + "' class='readmore'>detail more <i class='bi bi-arrow-right'></i></a>";
							data += "<div id = 'inheart'>";
							if(el.cvoclid != null){
								if(el.heart == true){
									data += "<img src='../images/heart.png' alt='' id='heart"+ el.facno +"' class='heart'/> ";
								}else{
									data += "<img src='../images/empty-heart.png' alt='' id='"+ el.facno +"' class='heart'/> ";
								}
								data += "<input type='hidden' name='clid' id='cvoclid' value = '"+el.cvoclid+"' />";
							data += "<input type='hidden' name='facno' id='facilityno' value = '"+el.facno+"' />";
							}
							data += "</div>";
							data += "</div>";
											
							data += "</div>";
											
									
									
						});
							data += "</div>";
							
							
							data += "<table class='table table-striped'>";
							data += "<tr>";
							data += "<td colspan='4'>";
							data += "<nav aria-label='Page navigation example'>";
							data += "<ul class='pagination justify-content-center'>";
							if(response[0].isPre){
								data += "<li class='page-item disabled'><a class='page-link'>Previous</a></li>";
								
							}
							for(var i = response[0].startPage; i<= response[0].endPage; i++){
								data += "<li class='page-item'><span class='page-link'><a class='item' href='#' data-page='" +i +"' >"+ i +"</a></span></li>";
							}
							if(response[0].isNext){
								data += "<li class='page-item'><a class='page-link' href='#'>Next</a></li>";
							}
							data += "</ul>";
							data += "</nav>";
							data += "</td>";
							data += "</tr>";
							data += "</div>";
							data += "</div>";
							data += "</table>";
							
							
											
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
		Object obj = session.getAttribute("vo");

		
	%>
	<!-- 수정된 내용 -->
	<header id="header" class="header d-flex align-items-center">
		<jsp:include page="../mainPage/header.jsp" />
	</header> 
	<div>
		<jsp:include page="../mainPage/search_bar.jsp" />
	</div>
		<div class="container" data-aos="fade-up">
				<div class="section-header" id="dbody">
					<%
					// 종목구분 파라미터 받아오기
					String keyword = request.getParameter("keyword");
						
					String[] keywordArr = null;
					if(keyword != null) {
						String re = keyword.replaceAll("[.,/]", " ");
						String re1 = re.replaceAll("\\s+", " ");
						
						keywordArr = re1.split(" ");
						
					}
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

					<input type="hidden" name="save" id="esave" value="<%=facevent%>" />
					<input type="hidden" name="save" id="lsave" value="<%=facloc%>" />


					<div class="row gy-4" data-aos="fade-up" data-aos-delay="100">
						<%
						
						
						//-------------------------------------------------
						
						InterestsDAO dao2 = new InterestsDAO();
						
						ClientVO vo3 = new ClientVO();
						vo3 = (ClientVO) obj;
						
						FacilitiesDAO dao = new FacilitiesDAO();
						//-------------------------------------------------
						// 수정 내용
						
						// 현재 페이지
						String cp = request.getParameter("cp");
						int currentPage = 0;
						
						if( cp != null){
							currentPage = Integer.parseInt(cp);
						}else{
							currentPage = 1;
						}
						// 1페이지당 게시물 수
						int recoredPerPage = 9;
						// 시작 번호와 끝번호를 계산
						// 현재페이지가 1이면
						// 시작번호 : 1부터 끝번호 : 10
						
						// 현재페이지가 2이면
						// 시작번호 11부터 끝번호 : 20
						
						int startNo = (currentPage - 1) * recoredPerPage + 1;
						int endNo = currentPage * recoredPerPage;
						
						
						// 총 게시물 수
						int totalCount = 0;
						if(keyword != null) {
							totalCount = dao.selectKeywordTotal(keywordArr);
						}else {
							totalCount = dao.getTotal();
						}
						
						
						// 총페이지 수
						int totalPage = (totalCount % recoredPerPage == 0)?totalCount/recoredPerPage : totalCount/recoredPerPage +1;
						System.out.println(totalPage);
						// 시작 페이지
						int startPage = 1;
						// 끝페이지
						int endPage = totalPage;
						
						// 시작페이지 미세조정
						if(currentPage <= 5){
							startPage = 1;
						}else if(currentPage >= 6){
							startPage = currentPage -4;
						}
						
						// 끝 페이지 미세 조정
						if(totalPage - currentPage <= 5){
							endPage = totalPage;
						}else if(totalPage - currentPage > 5){
							if(currentPage <= 5){
								if(totalPage > 10){
									endPage = 10;
								}else{
									endPage = totalPage;
								}
							}else{
								endPage = currentPage+4;
							}
						}
						
						boolean isPre = false;
						boolean isNext = false;
						
						// 이전값이 존재하면 true;
						// 다음값이 존재하면 true;
						
						// 현재페이지 번호에서 5를 뺸값이 0이상이면 이전값이 존재
						if(currentPage - 5 > 0){
							isPre = true;
						}
						
						// 현재페이지번호에서 5를 더한값이 끝페이지번호보다 작으면 다음값이 존재
						if(currentPage+5 <= totalPage){
							isNext = true;
						}
						ArrayList<FacilitiesVO> list = new ArrayList<FacilitiesVO>();
						// -----------------------------------------------------
						if(keyword != null) {	
							System.out.println( "번 / 예약번호 ");
							ArrayList<Integer> list2 = dao.selectKeyword(keywordArr, startNo, endNo);
							for (Integer vo : list2) {
								FacilitiesVO vo2 = dao.selectOne(vo);
								list.add(vo2);
							}
						}else {
							
							if(facevent == -1 && facloc.equals("전체")){
								list = dao.selectAll(startNo, endNo);
								System.out.println("list/dao.selectAll()실행");
								System.out.println(list);
								
							}else if(facevent != -1 && facloc.equals("전체") != true){
								list = dao.elAll(facevent, faclocArray, startNo,endNo);
								System.out.println("list/dao.elAll실행");
							}
							else if(facevent == -1){
								list = dao.locAll(faclocArray, startNo, endNo);
									
								System.out.println("list/dao.locAll실행");
							}else if(facloc.equals("전체")){
								//facevent = Integer.parseInt(fevent);
								list = dao.eventAll(facevent, startNo, endNo);
								System.out.println("list/dao.eventAll실행");
							}
						}
						
							

						for (FacilitiesVO vo : list) {
						%>
						<div class="col-lg-4 col-md-6">
							<div class="service-item  position-relative">
								<div id="imgdiv">
								<a href="../apoderado/detailFacilities.jsp?facno=<%=vo.getFacno()%>">
									<img src="<%=vo.getFacimg()%>" alt="<%=vo.getFacname()%>" class="facImg"/>
								</a>
								</div>
								<h3 class="facName-font"><%=vo.getFacname()%></h3>
								<p><%=vo.getFacaddr()%></p>
								
								<a href="../apoderado/detailFacilities.jsp?facno=<%=vo.getFacno()%>"
									class="readmore ">detail more <i
									class="bi bi-arrow-right"></i></a>
						
						<div id = "inheart">
								
								<%
								
								if (vo3 != null) { 
							
									String clid = vo3.getClid();
									
									int number = dao2.isExists(clid, vo.getFacno());
									if (number == 1) {
									%>
										<img src="../images/heart.png" alt="" id="heart<%=vo.getFacno() %>" class="heart"/> 
									<%	
									} else {
									%>
										<img src="../images/empty-heart.png" alt="" id="<%=vo.getFacno() %>" class="heart"/>
									<%
									}
									%>
									<input type="hidden" name="clid" id="cvoclid" value="<%=vo3.getClid()%>" /> 
									<input type="hidden" name="facno" id="facilityno" value="<%=vo.getFacno()%>" />
									<%
								}
								%>
						</div>
							</div>
									
						</div>
						<%
						

						}
						dao.close();
						dao2.close();
						%>
					</div>
					<table class="table table-striped">
					<tr>
						<td colspan="4">
						
						<nav aria-label="Page navigation example">
							  <ul class="pagination justify-content-center">
							  	<%
							  		if(isPre){
							  	%>
							    <li class="page-item disabled"><a class="page-link">Previous</a></li>
							    <%
							  		}
							    %>
							    <%
									System.out.println("startPage"+startPage);
									System.out.println("endPage"+endPage);
								for(int i = startPage; i<= endPage; i++){
									if(keyword != null) {
								%>
							    <li class="page-item"><span class="page-link"><a class="item" href="../search/list.jsp?keyword=<%=keyword %>&cp=<%=i %>" data-page="<%= i %>" ><%= i %></a></span></li>
							    <%-- href="list2.jsp?cp=<%= i %> --%>
							    <%
									}else {
								%>
								<li class="page-item"><span class="page-link"><a class="item" href="../search/list.jsp?cp=<%=i %>" data-page="<%= i %>" ><%= i %></a></span></li>
								<%
									}
								}
								%>
								<%
							  		if(isNext){
							  	%>
							    <li class="page-item"><a class="page-link" href="#">Next</a></li>
							    <%
							  		}
							    %>
							  </ul>
							</nav>
						
						
						</td>
					</tr>
					</table>
				</div> <!-- id = 'dbody' end -->
			</div>
	</section>
	<footer> 
		<jsp:include page="../mainPage/footer.jsp" />
	</footer>			

</body>
</html>