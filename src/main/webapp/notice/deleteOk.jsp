
<%@page import="kr.co.dongdong.dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//1. 파라미터값 가져오기
String no = request.getParameter("notno");
if(no!=null){
	int notno = Integer.parseInt(no);
	NoticeDAO dao = new NoticeDAO();
	
	dao.deleteOne(notno);
	
	response.sendRedirect("list.jsp");

}
%>
    