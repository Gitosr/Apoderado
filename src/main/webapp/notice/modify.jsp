
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.dongdong.vo.NoticeVO"%>
<%@page import="kr.co.dongdong.dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- --------header  -------- -->
<link rel="stylesheet" href="../css/main.css" />

<!-- 수정된 부분 -->
<link href="../Resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="../Resources/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<link href="../Resources/vendor/aos/aos.css" rel="stylesheet">
<link href="../Resources/vendor/glightbox/css/glightbox.min.css"
	rel="stylesheet">
<link href="../Resources/vendor/swiper/swiper-bundle.min.css"
	rel="stylesheet">
<!-- Template Main CSS File -->
<link href="../Resources/css/main.css" rel="stylesheet">
<!-- Vendor JS Files -->
<script src="../Resources/js/bootstrap.bundle.js"></script>
<script src="../Resources/vendor/aos/aos.js"></script>
<script src="../Resources/vendor/glightbox/js/glightbox.min.js"></script>
<script src="../Resources/vendor/purecounter/purecounter_vanilla.js"></script>
<script src="../Resources/vendor/swiper/swiper-bundle.min.js"></script>
<script src="../Resources/vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="../Resources/vendor/php-email-form/validate.js"></script>
<link rel="stylesheet" href="../css/main.css" />
<!-- ------------------------------------------- -->


<title>Insert title here</title>

<!-----기본 부트스트랩--->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- --- -->

<!-- summernote-->
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
<style>
div.margind{
width:60%;
margin:30px;
margin-left:auto;
margin-right:auto;
}
</style>

</head>
<body>
<header id="header" class="header d-flex align-items-center">
		<jsp:include page="../mainPage/header.jsp" />
	</header>
<%
String no = request.getParameter("notno");
if(no!=null){
	int notno = Integer.parseInt(no);
	NoticeDAO dao = new NoticeDAO();
	NoticeVO vo = dao.selectOne(notno);

%>
<form action="modifyOk.jsp" method="get">
<div class="margind">
<div class="row">
		<table class="table">
			<tr>
				<th>작성자</th>
				<td><input type="hidden" name="notno" value="<%=vo.getNotno()%>" />
				<!-- 게시물번호는 pk 값... 히든 으로 숨겨서 보내기. -->
				<input type="text"  disabled="disabled" name="writer" id="" value="<%=vo.getClid()%>"/>
				</td>
			</tr>
			<tr>
				<th>시설명</th>
				<%int facno = vo.getFacno();
				String facname = dao.selectFacname(facno);
				%>
				<td><select name="facno" id="">
				<option value=<%=facno %> selected><%=facname %></option>
				<%String facname2 = "";
				NoticeDAO dao2 = new NoticeDAO();
				
				ArrayList<Integer> list = dao.selectAll(vo.getClid()); //시설번호가져오기
				for (int x : list) {
					facname2 = dao.selectFacname(x);
				%><option value=<%= x%>><%= facname2%></option>
			<% }%>
				
				</select></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" id="" value="<%=vo.getNottitle() %>" size ="90%"/></td>
			</tr>
			
			<tr>
				<th>내용</th>
				<td>
				<textarea name="contents" id="summernote"><%=vo.getNotcontents()%></textarea></td>
			</tr>
			<tr><td></td>
				<td align="right">
				<input type="button" value="취소"  onClick="history.go(-1)" class="btn btn-outline-success" />
				<input type="submit" value="저장" class="btn btn-outline-success" />
				</td>
			</tr>
		</table>
	</div>
	</div>
	
	
	</form>
	<%} %>

</body>
</html>