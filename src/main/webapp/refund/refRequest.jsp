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
#btn1{
margin-left : 85%;
}
</style>
</head>
<body>
	<%
	Object obj = session.getAttribute("vo");
	RefundDAO dao = new RefundDAO();
	ClientVO vo =null;
		vo = (ClientVO)obj;
	if(obj !=null){
	ArrayList<Integer> list = dao.selectResno(vo.getClid());
	%>
	<div class="container">
	
	<div class="row">
    <div class="col-sm-7">
	<div>
	<h5>환불 안내</h5></td></tr>
			<ul>
			<li>일주일 전 취소 : 전액 환불</li>
			<li>3일전 취소 : 금액의 50% 환불</li>
			<li>24시간 전 취소 : 30% 환불</li>
			<li>당일 취소 : 환불 불가</li>
			</ul>
		</div>	
		<div>
	<h5>예약내역 선택</h5>
	<table class="table table-hover">
	<thead class="table-success">
	<form action="">
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
	<td><input type='checkbox' name="resno" value="<%=x%>"></td>
	<td><%=sdfresdate%></td>
	<td><%=facname %></td>
	<td><%= restime%></td>
	<td><%=facprice %></td>
	<td><%=facp %></td>
	</tr>
			<% }}%>
			</td></tr>
			</form></table></div>
			
			<div>
		<h5>환불사유</h5>
		<textarea name="refreason" rows="5" cols="95%"></textarea>
		<br>
	
	<input type="submit" value="환불신청" onclick="checkForm(this);" align="right" id="btn1" class="btn btn-outline-success" />
			</form>
			</div>
			
	</div>
	</div>
	</div>
	
		<script>
		function checkForm(x){
			var resno = x.form[0].value;
	         var refreason = x.form[1].value;
	         if(resno==''){  
	             alert("환불받으실 내역을 선택해주세요.");
	             x.form[0].focus();
	             return; 

	         }else if(refreason==''){  
	             alert("환불 사유를 입력해 주세요.");
	             x.form[1].focus();  
	             return; 
	         }
	         x.form.action = "deleteOk.jsp";
	         x.form.method="post";
	         x.form.submit();
	         alert('환불신청이 접수되었습니다.');
	         
		}
		
		</script>
</body>
</html>
