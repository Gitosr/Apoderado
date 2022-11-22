<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write.jsp</title>
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
<script>
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
	});
</script>
</head>
<body>
	<%
	Object obj = session.getAttribute("vo");
	if (obj != null) {
		ClientVO vo = (ClientVO) obj;
	%>	
	<form action="registerOk.jsp" method="post" enctype="multipart/form-data">
		<table class="table table-striped">
			<tr>
				<th>시설명</th>
				<td><input type="text" name="facName" id="" /></td>
			</tr>
			<tr>
				<th rowspan="3">시설주소</th>
				<td colspan="2"><input type="text" id="post" size="7" />
					<input type="button" value="우편번호찾기" id="btn" /></td>
			<tr>
				<td><input type="text" name="facAddr1" id="facAddr1" size="30"/></td>
			</tr>
			<tr>
				<td><input type="text" name="facAddr2" id="" size="30"/></td>
			</tr>
			<tr>
				<th>종목</th>
				<td colspan="2">
					<select name="eventList" id="eventList">
						<option value="----">선택</option>
						<option value="0">축구</option>
						<option value="1">야구</option>
						<option value="2">풋살</option>
						<option value="3">배드민턴</option>
						<option value="4">테니스</option>
						<option value="5">농구</option>
						<option value="6">배구</option>
						<option value="7">탁구</option>
					</select>
					<input type="hidden" name="facEvent" id="facEvent"/>
				</td>
			</tr>
			<tr>
				<th>가격</th>
				<td><input type="text" name="facPrice" id="" /> 원</td>
			</tr>
			<tr>
				<th>설명</th>
				<td><textarea name="facExplain" id="summernote" cols="30"
						rows="20"></textarea></td>
			</tr>
			<tr>
				<th>주차시설</th>
				<td><input type="radio" name="facParking" id="" value="1" /> 있음 
					<input type="radio" name="facParking" id="" value="0" /> 없음</td>
			</tr>
			<tr>
				<th>샤워시설</th>
				<td><input type="radio" name="facShower" id="" value="1" /> 있음
					<input type="radio" name="facShower" id="" value="0" /> 없음</td>
			</tr>
			<tr>
				<th>대표 사진</th>
				<td><input type="file" name="filename" id="" /></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="submit" value="등록" /> 
				<a href="main.jsp"><input type="button" value="취소" /></a>
				</td>
			</tr>
		</table>
	</form>
	<%
	}
	%>
</body>
</html>