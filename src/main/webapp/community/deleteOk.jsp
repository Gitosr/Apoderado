
<%@page import="kr.co.dongdong.dao.CommunityDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//1. 파라미터값 가져오기
String no = request.getParameter("comno");
if(no!=null){
	int comno = Integer.parseInt(no);
	CommunityDAO dao = new CommunityDAO();
	
	dao.deleteOne(comno);
	
	response.sendRedirect("list.jsp");

}
%>
    