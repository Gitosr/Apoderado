<%@page import="kr.co.dongdong.dao.ReserveDAO"%>
<%@page import="kr.co.dongdong.vo.ReserveVO"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
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
		Object obj = session.getAttribute("vo");
		
		if(obj != null){
			ClientVO vo = (ClientVO)obj;
			String clid = vo.getClid();
			String fno = request.getParameter("facno");
			
			int facno = Integer.parseInt(fno);
			
			String time = request.getParameter("restime");
			int restime = Integer.parseInt(time);
			
			String resdate = request.getParameter("resdate");
			
			ReserveVO rvo = new ReserveVO();
			
			rvo.setClid(clid);
			rvo.setFacno(facno);
			rvo.setRestime(restime);
			rvo.setResdate(resdate);
			
			ReserveDAO dao = new ReserveDAO();
			
			dao.insertOne(rvo);
			
			response.sendRedirect("list.jsp");
		}
	
	%>

</body>
</html>