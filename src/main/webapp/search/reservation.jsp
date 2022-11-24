<%@page import="kr.co.dongdong.vo.FacilitiesVO"%>
<%@page import="kr.co.dongdong.dao.FacilitiesDAO"%>
<%@page import="kr.co.dongdong.vo.UseVO"%>
<%@page import="kr.co.dongdong.dao.UseDAO"%>
<%@page import="test.Event"%>

<%@page import="kr.co.dongdong.vo.ClientVO"%>

<%@page import="kr.co.dongdong.dao.ClientDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#container{
		width : 1000px;
		border : 1px solid grey;
		margin : auto;
		text-align : center;
	}
	#head span{
		color : red;
	}
	
	#head{
		border : 1px solid grey;
		width : 500px;
		margin : auto;
		text-align : center;
	}
	#body{
		
	}
	ol{
		list-style-type : none;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function(){
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
	    }else{
	       $('.ckbox').prop('checked',false);
	    }
	});
	
	$(document).on('click','.ckbox',function(){
	    if($('input[class=ckbox]:checked').length==$('.ckbox').length){
	        $('#ckboxall').prop('checked',true);
	    }else{
	       $('#ckboxall').prop('checked',false);
	    }
	});
</script>
</head>
<body>

	<%
		String fno = request.getParameter("facno");
		String clid = request.getParameter("clid"); 
		String facmark = request.getParameter("facmark");
		Object obj = session.getAttribute("vo");
		String res = request.getParameter("resdate");
		String year = res.substring(6);
		String date = res.substring(0, 5);
		String resdate = year+"/"+date;
		String restime = request.getParameter("restime");

		
		if(fno != null){
			int facno = Integer.parseInt(fno);
			
			ClientVO cvo = (ClientVO)obj;
			
			ClientDAO cdao = new ClientDAO();
			
			FacilitiesDAO fdao = new FacilitiesDAO();
			
			FacilitiesVO fvo = fdao.selectOne(facno);
			
			Event e = new Event();
			
			String event = e.selectEvent(fvo.getFacevent());
			
			UseDAO udao = new UseDAO();
			int useorder = Integer.parseInt(restime);
			UseVO uvo = udao.selecttime(facno, useorder);
			
			//out.println(uvo.getUsetime());
		
	%>
	
	
	<div id="container">
	<form action="" name = "frm">
		<input type="hidden" name="resdate" value = "<%= resdate %>" />
		<input type="hidden" name="facno" value="<%= fvo.getFacno()%>"/>
		<input type="hidden" name="restime" value=""/>
	<div id ="head">
		<h2><%=fvo.getFacname() %><span><%=event %></span></h2>
		<p><%=fvo.getFacaddr() %></p>
		<br/>
		<p><%=year %>년 <%=date.substring(0, 2) %>월 <%=date.substring(3) %>일</p>
		
		<p><%=uvo.getUsetime() %> 차</p>
		<hr/>
		<p>총 결제 금액 <span><%=fvo.getFacprice() %></span></p>
	</div>
	<div id="body">
		<div>
			<p>카드 번호 <span><%=cvo.getClcardno() %></span></p>
			<p>신청자명 <%=cvo.getClname() %></p>
			<p>연락처  <%=cvo.getClmp() %></p>
		</div>
			<hr />
			<ol>
			<li><input type="checkbox" id="ckboxall" />전체동의</li>
			<li><input type="checkbox" name = "ckbox1" class="ckbox" id="ckbox1"  />개인정보 제 3자제공방침</li>
			<li><input type="checkbox" name = "ckbox2" class="ckbox" id="ckbox2" />개인정보 취급 방침</li>
			<li><input type="checkbox" name = "ckbox3" class="ckbox" id="ckbox3" />시설 이용 약관</li>
			</ol>
			
			<input type="button" id="reserve" value="예약하기" />
			<a href="back.jsp"><input type="button" id="back" value="돌아가기" /></a>
	</div>
	
	
		
	</form>
		
</div> 

	<%
		}
	%>



</body>
</html>