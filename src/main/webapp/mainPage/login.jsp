<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(function(){
		$("#btn2").on("click", function(){
	
			frm.action="register.jsp";
			frm.method="get";
			frm.submit();
		});
	});
</script>
</head>
<body>
	<%
		Object obj = session.getAttribute("vo");
	
		if(obj != null) {
			ClientVO vo = (ClientVO)obj;
			
			out.println("<h2> <a href='logout.jsp'>"+vo.getClname()+ "</h2>");
		}else {
	%>
	<div class="container">
		<form action="loginOk.jsp" name="frm">
			<table class="table table-striped table-bordered">
				<tr>
					<th>ID</th>
					<td><input type="text" name="id" id="id" /> </td>
				</tr>
				<tr>
					<th>PW</th>
					<td><input type="password" name="pw" id="pw" /> </td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="로그인" id="btn1" />
						<input type="button" value="회원가입" id="btn2" />
					</td>
				</tr>
			</table>
		</form>
	<%
		}
	%>
	</div>
</body>
</html>
