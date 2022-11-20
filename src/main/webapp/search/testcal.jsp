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
	String time = request.getParameter("restime");
	String year = time.substring(6);
	String date = time.substring(0, 5);
	String restime = year+"/"+date;

	out.println(time);
	out.println(year);
	out.println(date);
	out.println(restime);

	
%>

</body>
</html>