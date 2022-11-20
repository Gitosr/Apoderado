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
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
<% 
	Object obj = session.getAttribute("vo");
	String no = request.getParameter("facno");
	ClientVO vo2 = null;
	int facno = -1;
	
	if(obj !=null){
		vo2= (ClientVO)obj;
	}
	if(no != null){
		facno = Integer.parseInt(no);
	}
%>		

	var currentPage = 1;
	var count = 1;
	
	$(function(){
		cp_click(currentPage)
	});
	
	function cp_click(currentPage) {
		
		console.log(currentPage+"현재 페이지");

		$.ajax({
			url : "../review/fac_rev_list_info.jsp",
			data : { "facno" : <%=facno%> , "currentPage" : currentPage },
			dataType : "json",
			success : function(response){
				console.log(response);
				var res = response;
				
				var data = "";
				
				for(var i=0; i < res.length; i++) {
					console.log(res[i].revno);
					
					
					data += "<tr>";
					data += "<td>" + res[i].revno + "</td>";
					data += "<td>" + res[i].facname + "</td>";
					data += "<td><a href='../review/detail.jsp?revno=" + res[i].revno + "'>" + res[i].revtitle + "</a></td>";
					data += "<td>" + res[i].clid + "</td>";
					data += "<td>" + res[i].revdate + "</td>";
					data += "<td>" + res[i].scoreStar + "</td>";
					data += "</tr>" 

				} 
				
				
				data += "<tr>";
				data += "<td colspan='6'>";
				data += "<ul>";
				if(res[0].isPre) {
					data += "<li><a>Previous</a></li>";
				}
				for(var i=res[0].startPage; i <= res[0].endPage; i++) {
					data += "<li><a href='javascript:void(0);' id='"+i+"' onclick='cp_click(this.id)'>"+i+"</a>"
				}
				
				if(res[0].isNext) {
					data += "<li><a>Next</a></li>";
				}
				data += "</ul></td></tr>";
				
				$("#tbody").empty();
				$("#tbody").append(data);	
			}
		});	
	}

</script>
</head>
<body>
	<div class="container">
		<table>
		<thead>
		
			<%
			if(vo2.getClid() != null) {
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
				<th>작성자</th>
				<th>날짜</th>
				<th>평점</th>
			</tr>
		</thead>
		<tbody id="tbody">

		</tbody>
		<tfoot id="tfoot">			
			<form action="../review/list4.jsp">
			<tr>
				<input type="text" name="search" id="search" placeholder="검색어"/>
				<input type="submit" value="검색"/>
			</tr>
			</form>
		</tfoot>
		</table>
	</div>
</body>
</html>