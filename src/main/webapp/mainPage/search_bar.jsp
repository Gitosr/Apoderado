<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function(){

	$("#text1").keydown(function(key){
		if(key.keyCode == 13) {
			console.log("엔터");
			if($("#text1").val()=="") {
				key.preventDefault();
				
				alert("검색어를 입력해주세요");
			}
		}
	});
	
	$("#btn1").on("click", function(e){
		console.log("클릭");
		if($("#text1").val()=="") {
			alert("검색어를 입력해주세요");
			e.preventDefault();
		}else {
			
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
	<div class="search-box">
		<%
		String[] sport = { "축구", "야구", "풋살", "배드민턴", "테니스", "농구", "배구", "탁구" };
		int num = (int) (Math.floor(Math.random() * 8));
		String sportname = sport[num];
		%>
		<form action="../search/list.jsp">
			<input type="text" class="search-text" name="keyword"
				placeholder="<%=vo.getClname()%>님, 오늘은 <%=sportname%> 어때요?"
				onfocus="this.placeholder=''"
					onblur="this.placeholder='<%=vo.getClname()%>님, 오늘은 <%=sportname%> 어때요?'" id="text1"/>
			<input type="image" src="../images/search_btn3.png" alt="" class="search-btn" id="btn1"/>
		</form>
	</div>
	<%
	} else {
	%>
	<div class="search-box">
		<form action="../search/list.jsp">
			<input type="text" class="search-text" name="keyword"
				placeholder="종목, 지역으로 검색해보세요." onfocus="this.placeholder=''"
				onblur="this.placeholder='종목, 지역으로 검색해보세요.'" id="text1" /> 
			<input type="image" src="../images/search_btn3.png" alt="" class="search-btn" id="btn1"/>
		</form>
	</div>
	<%
	}
	%>
</body>
</html>