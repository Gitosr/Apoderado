<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div id="body">
	<textarea name="" id="" cols="50" rows="30">
	
	</textarea>

		<hr />
		<ol>
		<li><input type="checkbox" id="ckboxall" />전체동의</li>
		<li><input type="checkbox" name = "ckbox1" class="ckbox" id="ckbox1"  />개인정보 제 3자제공방침</li>
		<li><input type="checkbox" name = "ckbox2" class="ckbox" id="ckbox2" />개인정보 취급 방침</li>
		<li><input type="checkbox" name = "ckbox3" class="ckbox" id="ckbox3" />시설 이용 약관</li>
		</ol>
		
		<input type="button" id="reserve" value="예약하기" />
		<a href="back.jsp"><input type="button" id="back" value="돌아가기" /></a>
	</div>
	
</body>
</html>