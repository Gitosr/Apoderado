<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@page import="kr.co.dongdong.dao.ClientDAO"%>
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
		String id = request.getParameter("id");
	
		String pw = request.getParameter("pw");
		
		String name = request.getParameter("name");
		
		String birth1 = request.getParameter("birth1");
		String birth2 = request.getParameter("birth2");
		String birth3 = request.getParameter("birth3");
		
		String email1 = request.getParameter("email1");
		String email2 = request.getParameter("email2");
		
		String mp = request.getParameter("mp");
		
		String gender = request.getParameter("gender");
		System.out.println("gender"+gender);
		
		String cardno = request.getParameter("cardno");
		
		ClientDAO dao = new ClientDAO();
		ClientVO vo = new ClientVO();
		
		String email = email1+"@"+email2;
		System.out.println("email"+email);
		
		
		
		
		vo.setClid(id);
		vo.setClname(name);
		vo.setClpw(pw);
		
		vo.setClmail(email1+email2);
		vo.setClcardno(cardno);
		
		vo.setClbirth(birth1+"/"+birth2+"/"+birth3);
		vo.setClmp(mp);

		if(gender.equals("남")) {
			vo.setClgender(1);
			
		}else if(gender.equals("여")) {
			vo.setClgender(2);
			
		}
		out.println("<h2> birth : "+birth1+"/"+birth2+"/"+birth3+"</h2>");
		out.println("<h2> mp : "+mp+"</h2>");
		
		dao.insertOne(vo);
		
		response.sendRedirect("login.jsp");
		
	%>
</body>
</html>