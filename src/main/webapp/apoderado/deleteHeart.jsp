<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@page import="kr.co.dongdong.dao.InterestsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//1. 파라미터값 가져오기
Object obj = session.getAttribute("vo");
	ClientVO vo = (ClientVO)obj;
String no = request.getParameter("facno");
String clid = "";
if(no!=null&&vo!=null){
	int facno = Integer.parseInt(no);
	clid = vo.getClid();
	InterestsDAO dao = new InterestsDAO();
	
	dao.deleteOne(clid,facno);
	
	response.sendRedirect("mypage.jsp");

}
%>
    