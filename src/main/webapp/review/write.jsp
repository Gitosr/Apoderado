
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.dongdong.dao.ReviewDAO"%>
<%@page import="kr.co.dongdong.vo.ReviewVO"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 글쓰기 영역을 위해 summernote.org 에서 복붙 -->
<!-- include libraries(jQuery, bootstrap) -->
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

</head>

<body>
<%Object obj = session.getAttribute("vo");
ClientVO vo =null;
	if(obj !=null){
		vo = (ClientVO)obj;
	
%>

<div class="container">
	<form action="writeOk.jsp" method="post">
		<table class="table table-striped">
			<tr>
			<% 
			
			 ReviewDAO dao = new ReviewDAO();
			ArrayList<Integer> list = dao.selectResno(vo.getClid());
			%>
			
				<th>작성자</th>
				<td>
				<input type="text" disabled="disabled" name="writer" id="" value=<%=vo.getClid()%>>
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td colspan=3><input type='text' name='title' id='' size=100/></td>
				</tr>
				<tr>
				<td>시설명</td>
				<td><select name="resno" id="">
				<option value="">----</option>
				<%String facname = "";
				for (int x : list) {
					facname = dao.selectFacname(x);
				%><option value=<%= x%>><%= facname%></option>
			<% }%>
				
				</select></td>
			</tr>
				<td>평점</td>
				<td><select name="score" id="">
				    <option value="">----</option>
				    <option value=1>★</option>
				    <option value=2>★★</option>
				    <option value=3>★★★</option>
				    <option value=4>★★★★</option>
				    <option value=5>★★★★★</option>
				</select></td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
				<textarea name="contents" id="summernote" cols="80" rows="30"></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
				<a href="../review/list.jsp"><input type="button" value="목록" class="btn btn-success"/></a>
				<input type="submit" value="작성" class="btn btn-primary"/>
				</td>
			</tr>
		</table>
	
	</form>
	</div>
	<% }
	else{ 
		out.println("<script>alert('로그인 해 주세요'); location.href='../review/list.jsp'</script>");
	}
		%>
</body>
</html>