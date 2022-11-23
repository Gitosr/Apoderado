<%@page import="kr.co.dongdong.vo.ClientVO"%>
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
	});

</script>
</head>
<body>
<div class="container">
	<form action="../apoderado/fac_registerOk.jsp" method="get" name="frm">
		<table class="table table-striped">
			<tr>
				<th>시설종류</th>
				<td>
					<select name="facevent" >
						<option value="">----------</option>
						<option value="0">축구</option>
						<option value="1">야구</option>
						<option value="2">풋살</option>
						<option value="3">배드민턴</option>
						<option value="4">테니스</option>
						<option value="5">농구</option>
						<option value="6">배구</option>
						<option value="7">탁구</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>시설이름</th>
				<td><input type="text" name="facname" id="facname" /></td>
			</tr>
			<tr>
				<th>시설주소</th>
				<td><input type="text" name="facaddr" id="facaddr" /> </td>
			</tr>
			<tr>
				<th>시설이용가격</th>
				<td>
					<input type="text" name="facprice" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" />원
				</td>
			</tr>
			<tr>
				<th>시설이용안내</th>
				<td><textarea name="facexplain" id="facexplain" cols="30" rows="10"></textarea>
			</tr>
			<tr>
				<th>시설이미지주소</th>
				<td><input type="text" name="facimg" id="facimg" /> </td>
			</tr>
			<tr>
				<th>시설주차장여부</th>
				<td>
					<select name="facparking" >
						<option value="">---------</option>
						<option value="0">없음</option>
						<option value="1">있음</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>시설샤워장여부</th>
				<td>
					<select name="facshower" >
						<option value="">---------</option>
						<option value="0">없음</option>
						<option value="1">있음</option>
					</select>
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" value="가입하기" />
				</th>
			</tr>
		</table>
	</form>
</div>
</body>
</html>