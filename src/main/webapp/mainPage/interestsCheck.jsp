<%@page import="kr.co.dongdong.vo.FacilitiesVO"%>
<%@page import="kr.co.dongdong.dao.FacilitiesDAO"%>
<%@page import="kr.co.dongdong.dao.InterestsDAO"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜하기 테스트용 상세페이지입니다.</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<style>
	img.heart {
		width: 30px;
		height: 30px;
	}
</style>
<script>
<%
String param = request.getParameter("facno");
int facno = Integer.parseInt(param);
%>
	$(function() {
		$("#heart<%=facno %>").on("click", function() {
			var clid = $("#clid").val();
			var facno =  $("#facno<%=facno %>").val();
			console.log(<%=facno %>+"facno");
			console.log(facno+"hidden");
			
			$.ajax({
				url : "../mainPage/interestsOk.jsp",
				type : "GET",
				data : {
					"clid" : clid,
					"facno" : facno
				},
				success : function(data) {
					console.log(data+"상태");
					var result = data;
					if (result == 0) { // 데이터가 없는 경우
						$("#heart<%=facno %>").attr("src", "../images/heart.png"); // 하트 채우기
					} else {
						$("#heart<%=facno %>").attr("src", "../images/empty-heart.png"); // 하트 비우기
					}
				},
				error : function(data) {
					alert("에러 발생");
				}
			});
		})
	})
</script>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	param = request.getParameter("facno");

	if (param != null) {
		facno = Integer.parseInt(param);

		FacilitiesDAO dao = new FacilitiesDAO();
		FacilitiesVO vo = dao.selectOne(facno);
		
		InterestsDAO dao2 = new InterestsDAO();
		Object obj = session.getAttribute("vo");

		if (obj != null) { // 로그인한 상태에서만 찜할 수 있음
			ClientVO vo3 = (ClientVO) obj;
			
			String clid = vo3.getClid(); // 로그인한 사용자의 id
			// 사용자 id + 현재 페이지의 시설번호와 일치하는 데이터가 있는지 확인 
			int number = dao2.isExists(clid, facno); 

			if (number == 1) { // 데이터가 존재한다면 (==> 현재 사용자가 이미 찜하기를 누른 시설이라면)
			%>
				<img src="../images/heart.png" alt="" id="heart<%=facno %>" class="heart"/> 
			<%
			} else {
			%>
				<img src="../images/empty-heart.png" alt="" id="heart<%=facno %>" class="heart"/>
			<%
			}
			%>
				<input type="hidden" name="clid" id="clid" value="<%=vo3.getClid()%>" /> 
				<input type="hidden" name="facno" id="facno<%=vo.getFacno() %>" value="<%=vo.getFacno()%>" />
			<%
		}
		
	}
	%>
</body>
</html>