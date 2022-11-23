
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
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
	
	var tab = link.includes("?rewl="); 
	if(tab) {
		console.log(tab);
		$("ul.tabs li").removeClass('current');
		$("#tab-1").removeClass('current');
		$("#tab-2").removeClass('current');
		$("#tab-3").removeClass('current');
		$("ul.tabs li:nth-child(2)").addClass('current');
		$("#tab-2").addClass('current');
	}

});

</script>
</head>
<body>

	<%
	Object obj = session.getAttribute("vo");

	if (obj != null) {
		ClientVO vo = (ClientVO) obj;
		if(vo.getClrank()==2) {
	%>
	<div class="container">
		<ul class="tabs">
			<li class="tab-link current" data-tab="tab-1">관리자대시보드</li>
			<li class="tab-link" data-tab="tab-2">매출총액</li>
			<li class="tab-link" data-tab="tab-3">기타</li>
			<li class="tab-link" data-tab="tab-4">등등</li>
		</ul>

		<div id="tab-1" class="tab-content current">
			관리자대시보드
		</div>

		<div id="tab-2" class="tab-content">
			매출총액
		</div>

		<div id="tab-3" class="tab-content">
			기타
		</div>
		<div id="tab-4" class="tab-content">
			등등
		</div>
	</div>
	<%
		} 
	}
	%>
</body>
</html>