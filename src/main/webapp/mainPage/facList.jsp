<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String QS = request.getQueryString();
		String Param = request.getParameter("event");
		
		String data = QS.substring(0,5);
		
		out.println(QS);
		out.println(data);
	%>
		<h2><%=Param %></h2>
		<h2>파라미터 전달 테스트용</h2>
</body>
</html>