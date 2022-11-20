<%@page import="kr.co.dongdong.vo.CommunityVO"%>
<%@page import="kr.co.dongdong.dao.CommunityDAO"%>
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
String no = request.getParameter("comno");
if(no!=null){
	int comno = Integer.parseInt(no);
	CommunityDAO dao = new CommunityDAO();
	CommunityVO vo = dao.selectOne(comno);

%>
<form action="modifyOk.jsp" method="get">
<div class="container">
		<table class="table table-striped">
			<tr>
				<th>작성자</th>
				<td><input type="hidden" name="comno" value="<%=vo.getComno()%>" />
				<!-- 게시물번호는 pk 값... 히든 으로 숨겨서 보내기. -->
				<input type="text"  disabled="disabled" name="writer" id="" value="<%=vo.getClid()%>"/>
				<input type="hidden" name="writer" id="" value="<%=vo.getClid()%>"/></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" id="" value="<%=vo.getComtitle() %>"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
				<textarea name="contents" id="summernote" cols="80" rows="20"><%=vo.getComfield()%></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
				<a href="list.jsp"><input type="button" value="목록" class="btn btn-success"/></a>
				<input type="submit" value="저장" class="btn btn-primary"/>
				</td>
			</tr>
		</table>
	</div>
	
	
	</form>
	<%} %>

</body>
</html>