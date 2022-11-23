<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.dongdong.dao.NoticeDAO"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="../lang/summernote-ko-KR.js"></script>
<script type="text/javascript">

$(function(){
	  $('#summernote').summernote({
	  lang: 'ko-KR' //버튼들에 마우스 올리면 한글로 설명 나옴. 
	  //webapp 밑에 lang 폴더 복붙하고.. 기본값은 영문
	});
})
</script>
<style>
div.col-sm-8{
margin-top:10px;
border-bottom:5px solid rgba(209,231,221);
border-top:5px solid rgba(209,231,221);}
</style>

</head>

<body>
	<%
	Object obj = session.getAttribute("vo");
	ClientVO vo = null;
	if(obj !=null){
		vo = (ClientVO)obj;
	%>
	<div class="container">
	<div class="row">
    <div class="col-sm-8">
		<form action="writeOk.jsp" method="post">
			<table class="table">
				<tr>
					<th>작성자</th>
					<td>
					<input type="text"  disabled="disabled" name="writer" id="" value="<%=vo.getClid()%>"/>
					<input type="hidden" name="writer" id="" value="<%=vo.getClid()%>"/>
					</td>
				</tr>
				<tr>
				<th>시설명</th>
				<td><select name="facno" id="">
				<option value="">----</option>
				<%String facname = "";
				NoticeDAO dao = new NoticeDAO();
				
				ArrayList<Integer> list = dao.selectAll(vo.getClid()); //시설번호가져오기
				for (int x : list) {
					facname = dao.selectFacname(x);
				%><option value=<%= x%>><%= facname%></option>
			<% }%>
				
				</select></td>
			</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" id="" size=70/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
					<textarea name="contents" id="summernote" cols="80" rows="30"></textarea></td>
				</tr>
				<tr><td></td><td align="right">
					
					<a href="list.jsp"><input type="button" value="목록" class="btn btn-outline-success" /></a>
					<input type="submit" value="작성" class="btn btn-outline-success" />
					</td>
				</tr>
			</table>
		</form>
	</div>
	</div>
	</div>
	<% 
	}
	%>
</body>
</html>