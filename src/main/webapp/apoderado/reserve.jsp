<%@page import="kr.co.dongdong.dao.UseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function(){
		 $("#reserve").attr('disabled',true);
		$("#reserve").on("click",function(){
			console.log("클릭");
			console.dir($("#ckboxall"));
			if (!$("input:checked[id='ckboxall']").is(":checked")){ 
				alert("이용약관에 동의해주세요");
			}
			else{
				document.frm.action = "reservationOk.jsp";
				document.frm.method = "get";
				document.frm.submit();
			}
		})
		$("#back").on("click",function(){
			
		})
		
	})
	
	$(document).on('click','#ckboxall',function(){
	    if($('#ckboxall').is(':checked')){
	       $('.ckbox').prop('checked',true);
	       $("#reserve").attr('disabled',false);
	    }else{
	       $('.ckbox').prop('checked',false);
	       $("#reserve").attr('disabled',true);
	    }
	});
	
	$(document).on('click','.ckbox',function(){
	    if($('input[class=ckbox]:checked').length==$('.ckbox').length){
	        $('#ckboxall').prop('checked',true);
	        $("#reserve").attr('disabled',false);
	    }else{
	       $('#ckboxall').prop('checked',false);
	       $("#reserve").attr('disabled',true);
	    }
	});
</script>
</head>
<body>
	<%
		String data = request.getParameter("facno");
		String data1 = request.getParameter("restime");
		String data2 = request.getParameter("resdate");
		UseDAO dao = new UseDAO();
		
	%>
	
	<ol>
		<li>
			<input type="checkbox" id="ckboxall" />전체동의
		</li>
		<li>
			<input type="checkbox" name = "ckbox1" class="ckbox" id="ckbox1"  />개인정보 제 3자제공방
		</li>
		<li>	
			<textarea name="" id="" cols="50" rows="10">개인정보 제 3자제공방</textarea>
		</li>
		<li>
			<input type="checkbox" name = "ckbox2" class="ckbox" id="ckbox2" />개인정보 취급 방침
		</li>
		<li>
			<textarea name="" id="" cols="50" rows="10">개인정보 취급 방침</textarea>
		</li>	
		<li>
			<input type="checkbox" name = "ckbox3" class="ckbox" id="ckbox3" />시설 이용 약관
		</li>
		<li>
			<textarea name="" id="" cols="50" rows="10">시설 이용 약관</textarea>
		</li>
	</ol>
	<h3><%=data %></h3>
	<h3><%=data2 %></h3>
	<h3><%=data1 %></h3>
	
	<input type="button" id="reserve" value="예약하기" />
</body>
</html>