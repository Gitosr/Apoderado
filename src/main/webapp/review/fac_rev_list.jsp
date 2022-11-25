<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@page import="kr.co.dongdong.vo.ReviewVO"%>
<%@page import="kr.co.dongdong.dao.ReviewDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>


<title>Insert title here</title>
<style>
	
	ul li{
		list-style-type:none; display:inline;
	}
	.select_num {
		color: red;
	}
	.page_bar * {
		text-align: center;
	}
	th{
	text-align:center;
	}
	#btn10{
	width:25px;
	height:25px;
	}
	a {
	text-decoration: none;
	color: black;
	}
	#btn5,#list10{
	float:right;
	}
	#con{
	font-size:0.9rem;
	padding-left:8%;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
<% 
	Object obj = session.getAttribute("vo");
	String no = request.getParameter("facno");
	
	int facno = -1;

	if(no != null){
		facno = Integer.parseInt(no);
	}
%>		

	var currentPage = 1;
	var search = "";
	var type = 0;
	var count = 0;
	var lastcount = 0;
	
	$(function(){
		cp_click(currentPage);
		console.log(currentPage);		
	});
	
	// 현재 시설에 리뷰들 출력
	function cp_click(currentPage) {
		
		$.ajax({
			url : (type==0) ? "../review/fac_rev_list_info.jsp" : "../review/fac_search_list_info.jsp",
			data : (type==0) ?  { "facno" : <%=facno%> , "currentPage" : currentPage , "count" : count } : { "facno" : <%=facno%> , "currentPage" : currentPage, "search" : search , "count" : count },
		
			dataType : "json",
			success : function(response){
				console.log(response);
				var res = response;
				
				var data = "";
				if(res.length==0) {
					console.log("비어있음");
					$("#tbody").empty();
				}else {
					for(var i=0; i < res.length; i++) {
						console.log(res[i].revno);
	
						data += "<tr>";
						data += "<td>" + res[i].revno + "</td>";
						data += "<td><a href ='javascript:void(0);' onclick='toggleRow(this);' >" + res[i].revtitle + "</a></td>";
						data += "<td>" + res[i].clid + "</td>";
						data += "<td>" + res[i].revdate + "</td>";
						data += "<td>" + res[i].scoreStar + "</td>";
						data += "</tr>";
						data += "<tr style='display:none'><td colspan=5 id='con'>" + res[i].revcontents + "</td></tr>";
		
					} 
	
					data += "<tr class='page_bar'>";
					data += "<td colspan='5' >";
					data += "<a href='javascript:void(0);' onclick='pre_click()'><</a>";
					
					for(var i=res[0].startPage; i <= res[0].endPage; i++) {
						if(currentPage==i) {
							data += "<a href='javascript:void(0);' id='"+i+"' onclick='cp_click(this.id)' class='select_num'>"+i+"</a>"
						}else { 
							data += "<a href='javascript:void(0);' id='"+i+"' onclick='cp_click(this.id)'>"+i+"</a>"
						}
					}
					
					
					data += "<a href='javascript:void(0);' onclick='next_click()'>></a>";
					data += "</td></tr>";
					
					lastcount = res[0].totalPage;
					
					$("#tbody").empty();
					$("#tbody").append(data);	
				}
			}
		});	
	}
	
	
	function toggleRow(obj) {
		$(obj).parent('td').parent('tr').next('tr').toggle(); 
	}
	
	function reset() {
		type = 0;
		count = 0;
		cp_click(1);
	}
	
	function search_run() {
		search = $("#search_data").val();
		type = 1;
		count = 0;
		cp_click(1);
	}
	
	function pre_click() {
		
		if(count > 0) {
			count--;
			cp_click(count*10+1)
		}
		console.log(count+"pre");
		console.log(lastcount+"마지막");
	}
	function next_click() {
		count++;
		if(count*10 < lastcount) {
			cp_click(count*10+1);
			
		}else {
			count--;
		}
		console.log(count+"next");
		console.log(lastcount+"마지막");
	}

</script>
</head>
<body>
	<div class="container">
	<div id="btn5"><!-- <input type="button" id="list10" value="목록" onclick="reset();" class="btn btn-outline-success" /> -->
	<input type="text" name="search" id="search_data" placeholder="검색어"/>
	<button type="button" onclick="search_run();" style="border:none; background-color:transparent" onclick="search_run();" ><img id="btn10" src="https://icones.pro/wp-content/uploads/2021/06/icone-loupe-vert.png" alt=""></button>
					
		</div>
		<table class="table">
		<thead class="table">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>ID</th>
				<th>날짜</th>
				<th>평점</th>				
			</tr>
		</thead>
		<tbody id="tbody">
		</tbody>
		<tfoot id="tfoot">				
			
		</tfoot>
		</table>
		
	</div>
</body>
</html>
