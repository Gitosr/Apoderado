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
<link href="../css/mypage.css" rel="stylesheet">
<title>Insert title here</title>
<style>
	th{
		border-top:1px solid green;
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
	
	div.btns{
	padding:0px;
	float:right;
	}
	tr>th{
	text-align: center;
	
	}
	a {
	text-decoration: none;
	color: black;
	}
	#con{
	font-size:0.9rem;
	}
	.scbox{
	margin-bottom:10px;
	float:right;
	}
	#btnlist{
	float:left;
	padding:5px 10px 5px 10px;
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
						data += "<td><a href ='javascript:void(0);' onclick='toggleRow(this);' >" + res[i].facname + "</a></td>";
						data += "<td><a href ='javascript:void(0);' onclick='toggleRow(this);' >" + res[i].revtitle + "</a></td>";
						data += "<td>" + res[i].revdate + "</td>";
						data += "<td>" + res[i].scoreStar + "</td>";
						data += "</tr>";
						data += "<tr style='display:none'><td class='hid' colspan=4 id='con' style='border-right:none;'>" + res[i].revcontents + "</td>";

						
						data += "<td style='border-left: none;'><a href ='../review/modify.jsp?revno="+res[i].revno+"'>";
						data += "<button type='button' style='border:none; background-color:transparent' ><img width='25px' src='https://cdn-icons-png.flaticon.com/512/211/211968.png' alt=''></button></a>";
						data += "<button type='button' style='border:none; background-color:transparent' onclick='drop("+res[i].revno+")' ><img width='25px' src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAkFBMVEX///8AgAAAewAAfgAAfADO5s7p9ekAeACgwqD7/vv1+/U2lDbb7dtRolEjjSOTw5N1tHW73LtiqmJoqmi927230bc2jTbE38QtkS2iyKJCmkLU6dSozah/t39ZpVkAhACWxZa+377r9euLwIuy1bKmzabj8uMXihdInUh5t3mizqKTxpODu4Nhq2Gaw5rY6NgPu2czAAAEfUlEQVR4nO3da3uaMACGYUjAFEE8dlih4hClta79//9uKO3aJjgOBpNyvc+nXRvD3AWBMHSG0UnOMBns3+xgMU3TNDr18NFd3vsv89/O/3i6COzQGyTDbobSRY69XcUm+4xc7nMh05+nA9VDr9Vw55qEms2jFoknnurhV/cSt+K9R8hIc2Posva8c5Y5dlQr/lNEr9h+H7FRotpxsS253pdHlnvVkguNr91DP7IyPbdiKmcLnolPOp4cvVjCe/Aj8qyaU9Ja3ibMY6Fqj9BC1puwiLqqQUJLifvoKZKqFnEFllygSUeqSVwz2ULT1OudOIilA8lRNepbko8zp+hKNepbk5KdlJJiZmiJ8ZNDUjYfITrNFp1MGCGlo83CtsMw9MTCIjsvmE7Tw8vzSjybkp1q1pc8EejbjdbgHIW9wJp3NNo2TYUtQKcNV+G4/E+JLjsZa7s2vJD6jddxEH5KsUaX3xN+dNas8To88XCs0aHmD/8mIq/NVyIIiUYTYUHI7puvRLhoYBrdlBKFQfOVCIcachth8hak0e5wGG/Gp7aP5ybnZufWo7XP//jpaNa4diuJrrwzF6zN0nvWXy9QaNkNNlpyJVNRu5Uwd3eN8YXKnzLIjhK3/VllI/96uotI1vagG6oeet1I87Nv0VzqvaUuY2+tgIn8WW1XkW0rYfRjNmHDy2BnWOR0cOuls2j4Puo6h9X7bFn0c3bSPP990HXu0N0zWqR60M0qxmz9qiVUPdgrohBCqH0QQqh/EEKofxBCqH8Q9kBY5zGcxP7J6fUAB0IIoT6VDLRNzkczxGd5tInJecxWZ+Gi70LS9NkyCLULQgghVB+EEEKoPgghhFB9EEIIofoghBDCL1G+FkvUWUSZMHO5lsIi/BKu8DEnYSXCEuqE4vcfeNxT8NQX7r/znzu1hK8z+V35RIFKITd86gsP0Y+5RciEX2IKIYQQQgghhBBCCCGEEEIIIYQQQgghhBBCCCGEEEIIIYQQQgghhBBCCCGEEEIIIYQQQgghhBBCCCGEEEIIIYQQQgghhBBCCCGEfRTe6pshIexMaEEIIYQQQgghhBDWFq4ghBBCCCGEEEIIFQppAGG9niCEEEIIIYSwslHvhWtthabddyGF8JbCTr4L+mZC059ziX9lxi8iXM8v+SUqj3A3FJoWV8l3slcvUr2EkCThzKp+KUVJ+m+4IVQYhDWb91440VYYexDW65FUv5aa4n3fhaYk4VFbYZbIEW57L+RnAdpUMidrV6qtcCXMydo1UC25FHmUAzSMyn+aURSRNHnKd9PqW0Iqor4soOHEqjGlsVdpQl3P+QN5Qk/HjUiEW1fXpONlTSxxExrGMNPucMo2MoEaHk6pK+ls/6+ZZvsplTQ1/Gy40moeTCLZQMPY+xoR2Vg+MD9lZNoQ2bELoGEkrh7vRUoO3QBz4lwHIsnSroB5kanaSNla0sT+QvuJpdJI2bLLDVjkTWKi5gKHErrayT7Pl7Y/rGPGyG3LX9B9Dm7iO5fYafRwd7seomi6b8f7Cyhu6Otq7xNSAAAAAElFTkSuQmCC' alt=''></button></a>"
						
						data += "</td></tr>";
	
					} 

					data += "<tr class='page_bar'>";
					data += "<td id='tfoot1' colspan='5' >";
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
	<div class="margind">
	
	<input type="button" value="목록" onclick="reset();" id="btnlist" class="btn btn-outline-success" />
	
	<div class="scbox">
	<input type="text" name="search" id="search_data" placeholder="검색어"/>
	<button type="button" style="border:none; background-color:transparent" onclick="search_run();" ><img width="25px" src="https://icones.pro/wp-content/uploads/2021/06/icone-loupe-vert.png" alt=""></button></div>

		<table class="table">
		<thead class="table-success">
			<%		
			if(obj != null) {
			
			}
			%>
			<tr>
				<th width="7%">번호</th>
				<th>시설명</th>
				<th>제목</th>
				<th>날짜</th>
				<th>평점</th>				
			</tr>
		</thead>
		<tbody id="tbody">
		</tbody>
		</table>
		<div class="btns">
			
				<a href="../review/write.jsp">
	<input type="button" value="리뷰작성" class="btn btn-success" />
	</a>		
			</div>

			
	</div>
</body>
</html>