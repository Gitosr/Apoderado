<%@page import="kr.co.dongdong.dao.ReserveDAO"%>
<%@page import="kr.co.dongdong.vo.ReserveVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- --------header  -------- -->
<link rel="stylesheet" href="../css/main.css" />

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


<title>Insert title here</title>
<style>
ul.tabs {
float: left;
	margin: 0px;
	padding: 0px;
	list-style: none;
	width: 15%;
  height: 300px;
}

ul.tabs li {
float: left;
    width: 100%;
	background: none;
	color: #222;
	padding: 22px 16px;
	cursor: pointer;
    text-align: center;
	display: inline-block;
    outline: none;
    transition: 0.3s;
  
}

ul.tabs li.current {
	background: #ededed;
	color: #222;
}

.tab-content {
width:70%;
	float: left;
	display: none;
	padding: 10px 20px;
	border-top: 3px solid #eee;
}

.tab-content.current {

	display: inherit;
}

#tab-1{
padding-top:3%;
padding-left:5%;
}
h6{
font-family: GmarketSansMedium;
}


</style>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
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
		var link = document.location.href;
		var tab = link.includes("?rl="); 
		if(tab) {
			console.log(tab);
			$("ul.tabs li").removeClass('current');
			$("#tab-1").removeClass('current');
			$("#tab-3").removeClass('current');
			$("#tab-4").removeClass('current');
			$("ul.tabs li:nth-child(2)").addClass('current');
			$("#tab-2").addClass('current');
		}
		
		var tab = link.includes("?il="); 
		if(tab) {
			console.log(tab);
			$("ul.tabs li").removeClass('current');
			$("#tab-1").removeClass('current');
			$("#tab-2").removeClass('current');
			$("#tab-4").removeClass('current');
			$("ul.tabs li:nth-child(3)").addClass('current');
			$("#tab-3").addClass('current');
		}
		
		var link = document.location.href;
		var tab = link.includes("?sign="); 
		if(tab) {
			console.log(tab);
			$("ul.tabs li").removeClass('current');
			$("#tab-1").removeClass('current');
			$("#tab-2").removeClass('current');
			$("#tab-3").removeClass('current');
			$("#tab-4").removeClass('current');
			$("ul.tabs li:nth-child(5)").addClass('current');
			$("#tab-5").addClass('current');
		}
		
		$("#btn1").on("click", function() {

			var pw = $("#pw").val();
			var pwok = $("#pwok").val();
			if (pw == pwok) {
				frm.action = "updateClient.jsp";
				frm.method = "get";
				frm.submit();

			}
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
		<jsp:include page="../mainPage/header.jsp" />
	</header>
<jsp:include page="../apoderado/adminHeader.jsp" />
	<%
	Object obj = session.getAttribute("vo");

	if (obj != null) {
		ClientVO vo = (ClientVO) obj;
	%>
	<div>
		<ul class="tabs">
			<li class="tab-link current" data-tab="tab-1">회원정보수정</li>
			<li class="tab-link" data-tab="tab-2">예약내역조회</li>
			<li class="tab-link" data-tab="tab-3">찜목록조회</li>
			<li class="tab-link" data-tab="tab-4">나의후기조회</li>
			<%if(vo.getClrank()==2) { %>
			<li class="tab-link" data-tab="tab-5">환불승인</li>
			<%} %>
		</ul>

		<div id="tab-1" class="tab-content current">
			
			<form action="modify.jsp" name="frm">
				
					<h6>비밀번호를 다시한번 입력해주세요.</h6>
					<p><input type="password" name="pw" id="pw" /> <input
							type="hidden" name="pwok" id="pwok" value="<%=vo.getClpw()%>" />　<input type="submit" value="확인" id="btn13" class="btn btn-outline-success"/>
						</form>
						</p>
			</form>
			
		</div>

		<div id="tab-2" class="tab-content">
			<jsp:include page="reserve_list.jsp" />
		</div>

		<div id="tab-3" class="tab-content">
			<jsp:include page="interests_list.jsp" />
		</div>
		<div id="tab-4" class="tab-content">
			<jsp:include page="../review/cli_rev_list.jsp" />
		</div>
		<div id="tab-5" class="tab-content">
			<jsp:include page="../refund/adminRefund.jsp" />
		</div>
	</div>
	<%
	} 
	%>
</body>
</html>