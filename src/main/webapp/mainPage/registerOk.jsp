<%@page import="kr.co.dongdong.vo.FacilitiesVO"%>
<%@page import="kr.co.dongdong.dao.FacilitiesDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설 등록 완료</title>
</head>
<body>
	<%
	Object obj = session.getAttribute("vo");
	if (obj != null) {
		ClientVO vo = (ClientVO) obj;

			request.setCharacterEncoding("UTF-8"); 
			response.setContentType("text/html;charset=UTF-8");

			String saveDir = request.getRealPath("/upload");
			int maxFileSize = 1024 * 1024 * 10;
			MultipartRequest mr = new MultipartRequest(request, saveDir, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
			String f = mr.getOriginalFileName("filename");

			String facName = mr.getParameter("facName");
			String facAddr = mr.getParameter("facAddr1") + " " + mr.getParameter("facAddr2");
			int facEvent = Integer.parseInt(mr.getParameter("facEvent"));
			int facPrice = Integer.parseInt(mr.getParameter("facPrice"));
			String facExplain = mr.getParameter("facExplain");
			int facParking = Integer.parseInt(mr.getParameter("facParking"));
			int facShower = Integer.parseInt(mr.getParameter("facShower"));

			FacilitiesDAO dao = new FacilitiesDAO();
			FacilitiesVO vo2 = new FacilitiesVO();
	
			vo2.setFacname(facName);
			vo2.setFacevent(facEvent);
			vo2.setFacaddr(facAddr);
			vo2.setFacmark(0);
			vo2.setFacprice(facPrice);
			vo2.setFacexplain(facExplain);
			vo2.setFacimg("../upload/" + f);
			vo2.setFacparking(facParking);
			vo2.setFacshower(facShower);
			vo2.setFactype(1);
			vo2.setClid(vo.getClid());
	
			dao.insertOne(vo2);
			out.println("시설등록 완료");

			response.sendRedirect("registerCheck.jsp");
		}	
	%>
</body>
</html>