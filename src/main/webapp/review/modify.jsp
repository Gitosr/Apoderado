
<%@page import="kr.co.dongdong.vo.ReviewVO"%>
<%@page import="kr.co.dongdong.dao.ReviewDAO"%>
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
		  lang: 'ko-KR' //버튼들에 마우스 올리면 한글로 설명 나옴. 기본은 영문
		});
})
</script>
</head>
<body>
<%
String no = request.getParameter("revno");
if(no!=null){
	int revno = Integer.parseInt(no);
	ReviewDAO dao = new ReviewDAO();
	ReviewVO vo = dao.selectOne(revno);
	String clid = dao.selectID(vo.getResno());

%>
<form action="modifyOk.jsp" method="get">
<div class="container">
		<table class="table table-striped">
		<input type="hidden" name="revno" value=<%=revno %>>
			<tr>
				<th>작성자</th>
				<td>
				<input type="text"  disabled="disabled" name="writer" id="" value="<%=clid%>">
				<input type="hidden" name="writer" id="" value="ID<%=vo.getResno()%>"></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" id="" value="<%=vo.getRevtitle()%>"/></td>
			</tr>
			<tr>
				<th>평점</th>
				<td><select name="score" id="" >
				
				    <option value=<%=vo.getRevscore() %> selected><%=vo.getRevscore() %></option>
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
				<textarea name="contents" id="summernote" cols="80" rows="20"><%=vo.getRevcontents()%></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
				<a href="../review/list.jsp"><input type="button" value="목록" class="btn btn-success"/></a>
				<input type="submit" value="저장" class="btn btn-primary"/>
				</td>
			</tr>
		</table>
	</div>

	</form>
	<%} %>

</body>
</html>