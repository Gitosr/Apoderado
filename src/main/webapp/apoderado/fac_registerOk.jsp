<%@page import="kr.co.dongdong.dao.FacilitiesDAO"%>
<%@page import="kr.co.dongdong.vo.FacilitiesVO"%>
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
	
		Object obj = session.getAttribute("vo");
		ClientVO vo = null;
		
		if(obj != null) {
			vo = (ClientVO)obj;
			
		}
		
		String facev = request.getParameter("facevent");
		int facevent = Integer.parseInt(facev);
		System.out.println(facevent);
		
		String facname = request.getParameter("facname");
		String facaddr = request.getParameter("facaddr");
		System.out.println(facname);
		System.out.println(facaddr);
		
		String price = request.getParameter("facprice");
		int facprice = Integer.parseInt(price);
		System.out.println(facprice);
		
		String facexplain = request.getParameter("facexplain");
		System.out.println(facexplain);
		
		String facimg = request.getParameter("facimg");
		System.out.println(facimg);
		
		String parking = request.getParameter("facparking");
		int facparking = -1;
		
		if(parking.equals("0")) {
			facparking = 0;
		}else {
			facparking = 1;
		}
		System.out.println(facparking);
		
		String shower = request.getParameter("facshower");
		int facshower = -1;
		
		if(shower.equals("0")) {
			facshower = 0;
		}else {
			facshower = 1;
		}
		System.out.println(facshower);
		
		
		int factype = -1;
		
		if(vo.getClid().equals("admin")) {
			factype = 0;
		}else {
			factype = 1;
		}
		
		System.out.println(factype);

		FacilitiesVO vof = new FacilitiesVO();
		
		vof.setFacevent(facevent);
		vof.setFacname(facname);
		vof.setFacaddr(facaddr);
		vof.setFacprice(facprice);
		vof.setFacexplain(facexplain);
		vof.setFacimg(facimg);
		vof.setFacparking(facparking);
		vof.setFacshower(facshower);
		vof.setFactype(factype);
		vof.setClid(vo.getClid());
		
		FacilitiesDAO dao = new FacilitiesDAO();
		
		dao.insertOne(vof);
		
		response.sendRedirect("../mainPage/main.jsp");
		
	%>
</body>
</html>