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
	Object obj = session.getAttribute("vo");

	if (obj != null) {
		ClientVO vo = (ClientVO) obj;
	%>
	<div class="container">
		<ul class="tabs">
			<li class="tab-link current" data-tab="tab-1">회원정보수정</li>
			<li class="tab-link" data-tab="tab-2">예약내역조회</li>
			<li class="tab-link" data-tab="tab-3">찜목록조회</li>
			<li class="tab-link" data-tab="tab-4">나의후기조회</li>
		</ul>

		<div id="tab-1" class="tab-content current">

			<form action="" name="frm">
				<table>
					<tr>
						<th>PW</th>
						<td><input type="password" name="pw" id="pw" /> <input
							type="hidden" name="pwok" id="pwok" value="<%=vo.getClpw()%>" />
						</td>
					</tr>
					<tr>
						<td colspan="2"><input type="button" value="확인" id="btn1" />
						</td>
					</tr>
				</table>
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
	</div>
	<%
	} 
	%>
</body>
</html>