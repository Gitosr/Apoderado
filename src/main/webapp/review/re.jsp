

<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.dongdong.dao.ReviewDAO"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* facno 가져오기 */
/* facno 가져오기 */
/* facno 가져오기 */
	
	td{
		border: 1px solid black;
		border-collapse: collapse;
	}
	.hide{
		display:none;
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
$(function() {
	console.log(<%=facno%>);
	$.ajax({
		type : "GET",
		async : true,
		url : '../review/fac_rev_list_info.jsp',
		data : {'facno' : <%=facno%> ,'currentPage' : '1'},
			dataType : "json",
			success : function(response, status, request) {
				var review = response;
				var data = "";
				review.forEach(function(el, index){
					var revno = el.revno;
					var score = el.revscore;
					data += "<tr class='title'>";
					data += "<td>" + revno + "</td>";
					data += "<td>" + el.facname + "</td>";
					data += "<td><a href ='javascript:void(0);' onclick='toggleRow(this);' >"+el.revtitle+"</a></td>";
					
					data += "<td>" + el.clid + "</td>";
					data += "<td>" + el.revdate + "</td>";
					data += "<td>" + score + "</td>";
					
					data += "</tr>";
					data += "<tr class='conts' id='conts' style='display:none'><td colspan=5 id='con'>" + el.revcontents + "</td></tr>";
					
					

				}); 
				
				$("#dynamicTbody").empty();
				$("#dynamicTbody").append(data);
			}//success
		
		}); //ajax
		
	}); //전체 function
	
	function toggleRow(obj) {
		$(obj).parent('td').parent('tr').next('tr').toggle(); 
	}
	
	function showWrite() {
		$(".hide").toggle(); 
	}
</script>

</head>
<body>
	<div id="div1">
		<table>
			<% if(vo2!=null){ %>
			<thead>
				<input type="button" value="리뷰쓰기" id="btn2" onclick="showWrite();"/>
			<form action="../review/writeOk.jsp" method="post" name="frm">
			<tr class='hide'>	
				<td>제목</td>
				<td colspan=3><input type="text" name="title" id="" size = 40/></td>
			</tr>
				<% 
				/* 내가 예약했었던 예약번호 가져오기 */
				ReviewDAO dao = new ReviewDAO();
				ArrayList<Integer> list = dao.selectResno(vo2.getClid());
				%>
			<tr class='hide'>
				<td>시설명</td>
				<td>
					<select name="resno" id="">
					<option value="">----</option>
					<%String facname = "";
					for (int x : list) {
						facname = dao.selectNameTime(x);
					%><option value=<%= x%>><%= facname%></option>
					<% 
					}
					%>
					</select>
				</td>
			</tr>
			<tr class='hide'>
				<th>평점</th>
				<td>
					<select name="score" id="">
				    <option value="">-----------------</option>
				    <option value=1>★</option>
				    <option value=2>★★</option>
				    <option value=3>★★★</option>
				    <option value=4>★★★★</option>
				    <option value=5>★★★★★</option>
					</select>
				</td>
			</tr>
			<tr class='hide'>
				<td>내용</td>
				<td colspan=3>
					<textarea cols="40" rows="5" name = "contents"></textarea>
					<input type="hidden" name="writer" id="" value=<%=vo2.getClid()%>></td>
				<td><input type='submit' value='제출'/></td>
			</tr>
			</form>
			<%} %>
			<tr>
				<th>게시물번호</th>
				<th>시설명</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>평점</th>
			</tr>
			</thead>
			<tbody id="dynamicTbody">

			</tbody>

			<tfoot>
			</tfoot>
		</table>
	</div>
</body>
</html>
