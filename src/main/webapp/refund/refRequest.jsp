<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.Duration"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="kr.co.dongdong.dao.RefundDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<style>
a {
	text-decoration: none;
	color: black;
}
div.margind{
width:50%;
margin:30px;
margin-left:auto;
margin-right:auto;
}
#btn1{
margin-left:88%;
}
textarea{
width:100%;
}

</style>
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

</head>
<body>
<header id="header" class="header d-flex align-items-center">
		<jsp:include page="../mainPage/header.jsp" />
	</header>
	<%
	Object obj = session.getAttribute("vo");
	RefundDAO dao = new RefundDAO();
	ClientVO vo = (ClientVO)obj;
	if(obj !=null){
	ArrayList<Integer> list = dao.selectResnoSysdate(vo.getClid());
	%>
	<form action="deleteOk.jsp">
	<div class="margind">
	
	<h5>환불 안내</h5></td></tr>
			<ul>
			<li>일주일 전 취소 : 전액 환불</li>
			<li>3일전 취소 : 금액의 50% 환불</li>
			<li>24시간 전 취소 : 30% 환불</li>
			<li>당일 취소 : 환불 불가</li>
			</ul>
	<h5>예약내역 선택</h5>
	
	<table class="table table-hover">
	<thead class="table-success">
	<tr align="center">
	<td></td><td>예약일</td><td>시설명</td><td>이용회차</td><td>결제금액</td><td>환불예정금액</td></tr></thead>
	
	<%String facname = "";
	
	int facprice = -1;
	int restime = -1;
	int refundprice = -1;
	Date resdate;
	String sdfresdate;
				for (int x : list) {  //예약번호
					facname = dao.selectNameTime(x);
					resdate = dao.selectResdate(x);
					restime = dao.selectRestime(x);
					facprice = dao.selectPrice(x);
					
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
					sdfresdate = sdf.format(resdate);
					
					
					//날짜계산
					Calendar today = Calendar.getInstance(); //현재 오늘 날짜넣을 객체
					Calendar dday = Calendar.getInstance(); //디데이 객체
					Date d = new Date();
					
					dday.set(resdate.getYear(),resdate.getMonth(),resdate.getDay());
					today.set(d.getYear(),d.getMonth(),d.getDay());

					
					long tday = today.getTimeInMillis();
					long day = dday.getTimeInMillis();
					long count = (day - tday)/86400000; //일수
					System.out.println(count);
					int facp = facprice;
					if(count>=7){
						facp = facprice*1;
					}else if(count>=3){
						facp = facprice/2;
					}else if(count>=1){
						facp = facprice/10*3;
					}else{facp=0;}
					
					%>
	
	<tr>
	<td><input type='radio' name="resno" id="resno" value="<%=x%>" class="checkSelect"></td>
	<td><%=sdfresdate%></td>
	<td><%=facname %></td>
	<td><%= restime%></td>
	<td><%=facprice %></td>
	<td><%=facp %></td>
	</tr>
			<% }}%>
			</td></tr>
			</table>
			
		<h5>환불사유</h5>
		<textarea name="refreason" rows="3"></textarea>
		<br>
	
	<input type="submit" value="환불신청" onclick="checkForm(this);" id="btn1" class="btn btn-outline-success"/>
			
			</div>
			</form>
	
		<script>
		
		
		</script>
</body>
</html>
