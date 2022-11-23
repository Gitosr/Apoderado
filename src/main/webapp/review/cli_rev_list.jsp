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

<title>Insert title here</title>
<style>
	table,tr,td{
		border:1px solid black;
	}
	
	ul li{
		list-style-type:none; display:inline;
	}
	.select_num {
		color: red;
	}
	.page_bar * {
		text-align: center;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
<% 
	Object obj = session.getAttribute("vo");
	ClientVO vo2 = null;
	
	if(obj != null) {
		vo2 = (ClientVO)obj;
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
	
	function cp_click(currentPage) {
		
		console.log(currentPage+"현재 페이지");

		$.ajax({
			
			url : (type==0) ? "../review/cli_rev_list_info.jsp" : "../review/cli_search_list_info.jsp",
			data : (type==0) ?  { "currentPage" : currentPage , "count" : count } : { "currentPage" : currentPage, "search" : search , "count" : count },
							
			dataType : "json",
			success : function(response){
				console.log(response);
				var res = response;
				
				var data = "";
				if(res.length==0) {
					$("#tbody").empty();
				}else {
					for(var i=0; i < res.length; i++) {
						console.log(res[i].revno);
	
						data += "<tr>";
						data += "<td>" + res[i].revno + "</td>";
						data += "<td>" + res[i].clid + "</td>";
						data += "<td><a href ='javascript:void(0);' onclick='toggleRow(this);' >" + res[i].revtitle + "</a></td>";
						data += "<td>" + res[i].revdate + "</td>";
						data += "<td>" + res[i].scoreStar + "</td>";
						data += "</tr>";
						data += "<tr style='display:'><td colspan=5 id='con'>" + res[i].revcontents + "</td></tr>";

						
						data += "<tr style='display:'><td colspan='5'><a href ='../review/modify.jsp?revno="+res[i].revno+"'>";
						data += "<input type='button' value='수정'/></a>";
						
						data += "<input type='button' value='삭제' onclick='drop("+res[i].revno+")'/></a>"
						data += "</td></tr>";
	
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
		$(obj).parent('td').parent('tr').next('tr').next('tr').toggle(); 
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
	
	function drop(num) {
		$.ajax({
			url : "../review/deleteOk.jsp",
			data : {'revno' : num },
			success : function(){	
			}
		});
		cp_click(currentPage);
	}

</script>
</head>
<body>
	<div class="container">
		<table>
		<thead>
			<%		
			if(obj != null) {
			%>
			<tr>
				<td colspan="5">
					<a href="../review/write.jsp"> <input type="button" value="글쓰기" class="btn btn-primary" /></a>
				</td>
			</tr>
			<%
			}
			%>
			<tr>
				<th>게시물번호</th>
				<th>시설명</th>
				<th>제목</th>
				<th>날짜</th>
				<th>평점</th>				
			</tr>
		</thead>
		<tbody id="tbody">
		</tbody>
		<tfoot id="tfoot">		
			<tr>
				<td  colspan="5">
					<input type="text" name="search" id="search_data" placeholder="검색어"/>
					<input type="button" value="검색" onclick="search_run();"/>
					<input type="button" value="목록" onclick="reset();" />
				</td>
			</tr>
		</tfoot>
		</table>
	</div>
</body>
</html>