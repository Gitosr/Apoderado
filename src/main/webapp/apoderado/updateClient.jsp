<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	$("#inputEmail").on("change", function(){
		$("#email2").val($("#inputEmail").val());
	
	});
	
	$("#repw").on("blur", function(){
		var pw = $("#pw").val();
		var repw = $("#repw").val();
		
		if(pw != repw) {
			$("#nopw").text("비밀번호가 일치하지 않습니다.");
		}else {
			$("#nopw").text("");
		}
	});


});
</script>
</head>
<body>
	<div class="container">
	<form action="updateClientOk.jsp" method="get" name="frm">
		<table class="table table-striped">
		
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pw" id="pw" /> </td>
			</tr>
			<tr>
				<th>비밀번호 재확인</th>
				<td>
					<input type="password" name="repw" id="repw" />
					<span id="nopw"></span>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" id="" /> </td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>
					<input type="text" name="birth1" id="" /> - 
					<input type="text" name="birth2" id="" /> - 
					<input type="text" name="birth3" id="" />
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" name="email1" id="email1" />
					<input type="text" name="email2" id="email2" />
					<select name="email" id="inputEmail">
						<option value="">직접입력</option>
						<option value="@naver.com">naver.com</option>
						<option value="@daum.net">daum.net</option>
						<option value="@google.com">google.com</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>휴대전화</th>
				<td><input type="text" name="mp" id="" /> </td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<input type="radio" name="gender" value="남" /> 남
					<input type="radio" name="gender" value="여" /> 여
				</td>
			</tr>
			<tr>
				<th>카드번호</th>
				<td><input type="text" name="cardno" id="" /></td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" value="확인" />
				</th>
			</tr>
		</table>
	</form>
	</div>
</body>
</html>