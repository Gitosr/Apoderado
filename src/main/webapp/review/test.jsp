<%@page import="kr.co.dongdong.dao.FacilitiesDAO"%>
<%@page import="kr.co.dongdong.dao.ReserveDAO"%>
<%@page import="kr.co.dongdong.vo.ReviewVO"%>
<%@page import="kr.co.dongdong.dao.ReviewDAO"%>
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

		
		
		
		ReserveDAO dao2 = new ReserveDAO();
		int facno = dao2.getFacno(40);
		
		System.out.println(facno);
		
		ReviewDAO dao = new ReviewDAO();

		int sum = dao.scoreTotal(6);
		int count = dao.getTotal_facno(6);
		
		double average = sum/count;
		
		System.out.println(sum);
		
		System.out.println(count);
		System.out.println(average);
		

		
		
		FacilitiesDAO dao4 = new FacilitiesDAO();
		
		dao4.updateAvg(average, facno);
		
		
		
		
	
	%>
</body>
</html>