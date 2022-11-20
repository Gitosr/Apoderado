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
</head>
<body>
	<%Object obj = session.getAttribute("vo");
	RefundDAO dao = new RefundDAO();
	ClientVO vo =null;
		vo = (ClientVO)obj;
	if(obj !=null){
	ArrayList<Integer> list = dao.selectResno(vo.getClid());
	%>
	<div class="container">
		<form action="deleteOk.jsp">	
		<p>신청내역</p>
		<select name="resno" id="resno" >
				<option value="">----</option>
				<%String facname = "";
				for (int x : list) {  //예약번호
					facname = dao.selectNameTime(x);
				%>
				<option value=<%= x%>><%= facname%></option>
				
				<% }}%>
			</select>
			
			<p>환불사유</p>
			<textarea name="refreason" rows="4" cols="50"></textarea>
			
			<input type="submit" value="환불신청" onclick="checkForm(this);"/>
			</form>
			<div>환불 안내
			<ul>
			<li>일주일 전 취소 : 전액 환불</li>
			<li>3일전 취소 : 금액의 50% 환불</li>
			<li>24시간 전 취소 : 30% 환불</li>
			<li>당일 취소 : 환불 불가</li>
			</ul>
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