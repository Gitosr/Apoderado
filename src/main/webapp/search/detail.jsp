<%@page import="kr.co.dongdong.vo.FacilitiesVO"%>
<%@page import="kr.co.dongdong.dao.FacilitiesDAO"%>

<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#container{
		width: 1000px;
		margin: auto;
	}
	
	#pic{
		width: 500px;
		float: left;
	}
	
	#pic>img{
		width: 100%;
		height: 50%;
	}
	
	table{
		width:80%;
		border-top: 3px solid gray;
		border-bottom: 3px solid gray;
	}
	
	#info{
		width: 450px;
		margin-left: 50px;
		float: left;
	}
	
	#desc{
		clear : both;
	}
	
	/* 
	td > img : td의 직계자손인 img 
	td img : td의 자손인 img
	*/
	td img{
		widows: 50px;
		height: 50px;
	}
	#feedback { font-size: 1.4em; }
  #selectable .ui-selecting { background: #FECA40; }
  #selectable .ui-selected { background: #F39814; color: white; }
  #selectable { list-style-type: none; margin: 0; padding: 0; width: 40%; }
  #selectable li { margin: 3px; padding: 0.4em; font-size: 1.4em; height: 18px; }
</style>

<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script> -->
<script>
	/* id가 cart인 엘리먼트를 클릭하면 양식을 cart.jsp 전달 get 방식 */
	
	$(function(){
		//var reserve = document.getElementById("reserve");
		$( "#datepicker" ).datepicker();
		$( "#selectable" ).selectable({
		      stop: function() {
		        $( ".ui-selected", this ).each(function() {
		          var index = $( "#selectable li" ).index( this );
		          $("#restime").val(index + 1);
		          
		          console.log($("#restime").val());
		        });
		      }
		    });
		$("#reserve").on("click",function(){
			document.frm.action = "reservation.jsp";
			document.frm.method = "get";
			document.frm.submit();
		})
	})
</script>
</head>
<body>
	<%
		String fno = request.getParameter("facno");
	
	
	if(fno != null){
		
		int facno = Integer.parseInt(fno);
		
		// 4. dao 객체
		FacilitiesDAO dao = new FacilitiesDAO();
		
		// 5. 상품번호로 vo 객체 얻어오기
		FacilitiesVO vo = dao.selectOne(facno);
			
		/* out.println("<h2>" + vo.getFacno() + "</h2>");
		out.println("<h2>" + vo.getFacname() + "</h2>");  */
	
	%>
	<form action="" name ="frm">
		<input type="hidden" name="facno" value="<%=vo.getFacno() %>" />
		<p>Date: <input type="text" name = "resdate" id="datepicker"></p>
		<input type="hidden" name="restime" id="restime" value="" />
	</form>
		<!-- 6. 상품 페이지를 출력 (표형태) : 왼쪽에 큰 이미지 오른쪽에 표(상품명 판매각격 구매버튼 이미지 장바구니 이미지)  -->
		<div id="container">
			<div id="pic"><img src="<%= vo.getFacimg() %>" alt="<%= vo.getFacname() %>" /></div>
			
			<div id="info">
			
			
				<table>
					<tr>
						<td colspan = "2"> <%= vo.getFacname() %></td>
					</tr>
					<tr>
						<td>금액</td>
						<td> <%= vo.getFacprice()%></td>
					</tr>
					<tr>
						<td>장소</td>
						<td> <%= vo.getFacaddr() %></td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="button" value="예약하기" id="reserve" />
							<a href="list.jsp">
							돌아가기
							</a>
						</td>
					</tr>
				</table>
				<ol id="selectable">
				  <li class="ui-widget-content" value = "Item 1">Item 1</li>
				  <li class="ui-widget-content">Item 2</li>
				  <li class="ui-widget-content">Item 3</li>
				  <li class="ui-widget-content">Item 4</li>
				</ol>
			</div>
				<div id= "desc">
					<p><%= vo.getFacexplain()%></p>
				</div>
		</div>
		
			<a href="https://www.flaticon.com/kr/free-icons/" title="구입아이콘">구입아이콘 제작자:Freepik-Flaticon</a>
			<a href="https://www.flaticon.com/kr/free-icons/" title="구입아이콘">구입아이콘 제작자:Uniconlabs-Flaticon</a>
	
	<%
		}
	
	%>

</body>
</html>