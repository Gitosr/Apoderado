<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write.jsp</title>
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
<!-- include libraries(jQuery, bootstrap) -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->

<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="../lang/summernote-ko-KR.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
	$(function() {
		$("#repw").on("blur", function(){
			var pw = $("#pw").val();
			var repw = $("#repw").val();
			
			if(pw != repw) {
				$("#nopw").text("비밀번호가 일치하지 않습니다.");
			}else {
				$("#nopw").text("");
			}
		});
			
		$("#emailList").on("change", function(){
			$("#email2").val($("#emailList").val());
		});
		
		$("#id").on("blur",function(){
			frm.action="idtestOk.jsp";
			frm.method="get";
			frm.submit();
		});
	});
</script>
<link rel="stylesheet" href="../css/fac_Register.css" />
<link rel="stylesheet" href="../css/footer.css" />
</head>
<body>
	<header id="header" class="header d-flex align-items-center">
		<jsp:include page="../mainPage/header.jsp" />
	</header>
	
	<div class="title">
		<h2>
			회원가입<span>.</span>
		</h2>
	</div>
	<div class="register-form">
		<form action="registerOk.jsp" method="get" name = "frm" >
			<table id="register-table">
				<tr>
					<th class="th-title">아이디</th>
					<td>
					<%
					Object obj = session.getAttribute("idtest");
					int con = 0;
					
					String isOk = "";
				
					if(obj != null) {
						
						String id = (String)obj;
						if(id=="") {
							isOk = "사용이 불가능한 아이디 입니다.";
							con = 0;
						}else {
							isOk = "사용이 가능한 아이디 입니다.";
							con = 1;
						}
					%>
					<input type="text" name="id" class="text" id="id" size="20" value="<%=id %>" />
					<%
						}else {
													
					%>
					<input type="text" name="id" class="text" id="id" size="20" value="" placeholder="아이디를 입력하세요." />
					<%
						}
						session.invalidate(); 
					%>	
					
					<p><span><%= isOk %></span></p>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="name" id=""name""  class="text" size="7" /> 
					</td>
				<tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="pw" id="pw"  class="text" size="20" /> 
					</td>
				<tr>
					<th>비밀번호 재확인</th>
					<td>
						<input type="password" name="repw" id="repw"  class="text" size="20" />
						<p><span id="nopw"></span></p>
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>
						<input type="text" name="birth1" id=""  class="text" placeholder="출생년도" size="7" />-
						<input type="text" name="birth2" id=""  class="text" placeholder="출생달" size="7" />-
						<input type="text" name="birth3" id=""  class="text" placeholder="출생일" size="7" />
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td colspan="2">
						<input type="text" name="email1" id="email1"  class="text" size="11" />@
						<input type="text" name="email2" id="email2"  class="text" size="11" />
						<select name="emailList" id="emailList">
							<option value="">직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.net">daum.net</option>
							<option value="google.com">google.com</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>휴대전화</th>
					<td>
						<input type="text" name="mp" id=""  class="text" placeholder="010-xxxx-xxxx" size="15" />
					</td>			
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<input type="radio" name="gender" id="" value="남" class="form-check-input"/>남
						<input type="radio" name="gender" id="" value="여" class="form-check-input"/>여
					</td>			
				</tr>
				<tr>
					<th>카드번호</th>
					<td>
						<input type="text" name="cardno" id=""  class="text" size="20"/>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="btn-box">
						<input type="submit" value="가입하기" class="btn btn-outline-success" />
						<a href="../mainPage/main.jsp">
						<input type="button" value="돌아가기" class="btn btn-outline-success" />
						</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<footer>
		<jsp:include page="../mainPage/footer.jsp" />
	</footer>
</body>
</html>