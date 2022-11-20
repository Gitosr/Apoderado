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
<style>
	img {
		width: 450px;
		height: 400px;
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
	%>
	<div class="container">
		<table class="table table-striped">
			<tr>
				<td rowspan="11">
					<img src="<%=vo.getFacimg() %>" alt="" />
					<jsp:include page="calendar.jsp" />
				</td>
				<td>시설번호 : <%=vo.getFacno() %> <jsp:include page="../mainPage/interestsCheck.jsp" /></td>
				
			</tr>
			<tr>
				<td>시설의 운동종목 : <%=vo.getFacevent() %></td>
			</tr>
			<tr>
				<td>시설 이름 : <%=vo.getFacname() %></td>
			</tr>
			<tr>
				<td>시설 평점 : <%=vo.getFacmark() %></td>
			</tr>
			<tr>
				<td>시설 대여 가격 : <%=vo.getFacprice() %></td>
			</tr>
			<tr>
				<td>시설 주소 : <%=vo.getFacaddr() %> <input type="button" value="지도보기" id="map_button"/></td>
			</tr>
			<tr>
				<td>시설 등록일 : <%=vo.getFacregister() %></td>
			</tr>
			<tr>
				<td>시설 등록자 아이디 : <%=vo.getClid() %></td>
			</tr>
			<tr>
				<td>주차장 여부 : <%=vo.getFacparking() %></td>
			</tr>
			<tr>
				<td>샤워장 여부 : <%=vo.getFacshower() %></td>			
			</tr>
			<tr>				
				<td>공공, 사설여부 : <%=vo.getFactype() %></td>
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