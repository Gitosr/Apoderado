<%@page import="kr.co.dongdong.vo.UseVO"%>
<%@page import="kr.co.dongdong.vo.FacilitiesVO"%>
<%@page import="kr.co.dongdong.dao.FacilitiesDAO"%>
<%@page import="kr.co.dongdong.dao.UseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="bootLink.jsp"></jsp:include>
<head>
<meta charset="UTF-8">
<jsp:include page="../apoderado/adminHeader.jsp"></jsp:include>
<style>
	ul {
		list-style:none;
	}
	
	#info * {
		text-align: center;
	}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
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
		String no = request.getParameter("facno");
		String time = request.getParameter("restime");
		String resdate = request.getParameter("resdate");
		
		int facno = Integer.parseInt(no);
		int restime = Integer.parseInt(time);
		
		FacilitiesDAO dao = new FacilitiesDAO();
		FacilitiesVO vo = new FacilitiesVO();
		vo = dao.selectOne(facno);
		
		UseDAO dao2 = new UseDAO();
		UseVO vo2 = dao2.getUseTime(facno, restime);
		
	%>
	
	<ul>
		<li>
			<input type="checkbox" id="ckboxall" />전체동의
		</li>
		<li>
			<input type="checkbox" name = "ckbox1" class="ckbox" id="ckbox1"  />동동 이용약관 동의
		</li>
		<li>	
			<textarea name="" id="" cols="50" rows="10">여러분을 환영합니다.
동동의 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 동동의 서비스 이용과 관련하여 동동의 서비스를 제공하는 동동 주식회사(이하 ‘동동’)와 이를 이용하는 네이버 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 동동 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다. 동동 서비스를 이용하시거나 네이버 서비스 회원으로 가입하실 경우 여러분은 본 약관 및 관련 운영 정책을 확인하거나 동의하게 되므로, 잠시 시간을 내시어 주의 깊게 살펴봐 주시기 바랍니다.
			</textarea>
		</li>
		<li>
			<input type="checkbox" name = "ckbox2" class="ckbox" id="ckbox2" />개인정보 수집 밑 동의
		</li>
		<li>
			<textarea name="" id="" cols="50" rows="10">개인정보보호법에 따라 동동의 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다. 이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 네이버 서비스를 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 네이버는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다. 회원가입 시점에 네이버가 이용자로부터 수집하는 개인정보는 아래와 같습니다.
			</textarea>
		</li>	
	</ul>
	<div id="info">
	<form action="../search/reservationOk.jsp">
		<h3>장소 : <%=vo.getFacname() %></h3>		
		<h3>예약날짜 : <%=resdate %></h3>
		<h3>이용시간 : <%=vo2.getUsetime() %></h3>
		<input type="hidden" name="facno" value='<%=facno%>'/>
		<input type="hidden" name="restime" value='<%=restime%>'/>
		<input type="hidden" name="resdate" value='<%=resdate%>'/>			
		<input type="submit" id="reserve" value="예약하기" class="btn btn-success" style="width:200pt;height:50pt; font-size : 30px"/>
	</form>
	</div>
</body>
</html>