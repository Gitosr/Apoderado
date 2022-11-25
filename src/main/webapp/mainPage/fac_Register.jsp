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
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="../lang/summernote-ko-KR.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="../css/fac_Register.css" />
<link rel="stylesheet" href="../css/footer.css" />

<script>
	var cnt = 2;
	var row = 8;
	function addRow(){
		console.log("행 추가");
		var table = document.getElementById("register-table");
		var newRow = table.insertRow(row);
		cnt++;
		row++;
		
		var newCell1 = newRow.insertCell(0);
		var newCell2 = newRow.insertCell(1);
		var html = "<td><input type='text' name='useTime' id='' class='text' size='30' placeholder='00:00 - 00:00 형식으로 작성해주세요.'/></td>";
		
		newCell1.innerText = cnt+"회차";
		newCell2.innerHTML = html;
	}

	window.onload = function() {
		var btn = document.getElementById("btn");
		btn.onclick = openKakaoPostcode;
	}
	function openKakaoPostcode() { 
		new daum.Postcode({
			oncomplete : function(data) {
				console.dir(data);
				// 팝업에서 검색결과 항목을 클릭했을 때
				// 실행할 코드를 작성하는 부분
				// 우편번호: zonecode  주소: roadAddress 
				document.getElementById("post").value = data.zonecode;
				document.getElementById("facAddr1").value = data.roadAddress;
			}
		}).open();
	}
	
	$(function() {
		$('#summernote').summernote({
			lang : "ko-KR"
		});
			
		$("#eventList").on("change", function(){
			$("#facEvent").val($("#eventList").val());
		});	
		
		$(".submit").on("click", function(){
		});
		$(".exit").on("click", function(){
			confirm("등록을 취소하시겠습니까?");
			
		})
		
	});
</script>
<link rel="stylesheet" href="../css/facRegister2.css" />
<link rel="stylesheet" href="../css/footer.css" />
</head>
<body>
	<header id="header" class="header d-flex align-items-center">
		<jsp:include page="header.jsp" />
	</header>
	<%
	Object obj = session.getAttribute("vo");
	if (obj != null) {
		ClientVO vo = (ClientVO) obj;
	%>
	<div class="title">
		<h1>
			시설 등록하기<span>.</span>
		</h1>
	</div>
	<div class="register-form">
		<form action="registerOk.jsp" method="post" enctype="multipart/form-data">
			<table id="register-table">
				<tr>
					<th class="th-title">시설명</th>
					<td><input type="text" name="facName" class="text" id="" size="30"
						placeholder="시설명을 입력하세요." /></td>
				</tr>
				<tr>
					<th rowspan="3">시설주소</th>
					<td colspan="2">
						<input type="text" id="post"  class="text" size="7" /> 
						<input type="button" value="우편번호찾기" id="btn" class="btn btn-outline-success" /></td>
				<tr>
					<td><input type="text" name="facAddr1" id="facAddr1"  class="text" size="30" /></td>
				</tr>
				<tr>
					<td><input type="text" name="facAddr2" id=""  class="text" placeholder="상세주소를 입력하세요." size="30" /></td>
				</tr>
				<tr>
					<th>종목</th>
					<td colspan="2"><select name="eventList" id="eventList" >
							<option value="">선택</option>
							<option value="0">축구</option>
							<option value="1">야구</option>
							<option value="2">풋살</option>
							<option value="3">배드민턴</option>
							<option value="4">테니스</option>
							<option value="5">농구</option>
							<option value="6">배구</option>
							<option value="7">탁구</option>
					</select> <input type="hidden" name="facEvent" id="facEvent" /></td>
				</tr>
				<tr>
					<td colspan="4">회차 
					<input type="button" value="추가하기" onclick = "addRow()" /></td>
				</tr>
				<tr>
					<td>1회차</td>
					<td>
						<input type="text" name="useTime" id="" class="text" size="30" placeholder="00:00 - 00:00 형식으로 작성해주세요."/>
					</td>			
				</tr>
				<tr>
					<td>2회차</td>
					<td>
						<input type="text" name="useTime" id="" class="text" size="30" placeholder="00:00 - 00:00 형식으로 작성해주세요."/>
					</td>			
				</tr>
				<tr>
					<th>회차당 가격</th>
					<td><input type="text" name="facPrice" id=""  class="text" size="10"/> 원</td>
				</tr>
				<tr>
					<th>설명</th>
					<td><textarea name="facExplain" id="summernote" cols="40" rows="10"></textarea></td>
				</tr>
				<tr>
					<th>주차시설</th>
					<td><input class="form-check-input" type="radio" name="facParking" value="1" /> 있음 
					<input class="form-check-input" type="radio" name="facParking" value="0" /> 없음</td>
				</tr>
				<tr>
					<th>샤워시설</th>
					<td><input class="form-check-input" type="radio" name="facShower" value="1" /> 있음 
						<input class="form-check-input" type="radio" name="facShower" value="0" /> 없음</td>
				</tr>
				<tr>
					<th>대표 사진</th>
					<td><input type="file" name="filename" id=""  class="file"/></td>
				</tr>
				<tr>
					<td colspan="2" class="btn-box">
						<input type="submit" value="등록" class="btn btn-outline-success" />
						<a href="main.jsp"><input type="button" value="취소" 
							class="btn btn-outline-success" /></a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<%
	}
	%>
	<footer>
		<jsp:include page="footer.jsp" />
	</footer>
</body>
</html>