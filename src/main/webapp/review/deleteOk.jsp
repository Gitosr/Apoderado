
<%@page import="kr.co.dongdong.dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//1. 파라미터값 가져오기
String no = request.getParameter("delete");

if(no!=null){
	int revno = Integer.parseInt(no);
	ReviewDAO dao = new ReviewDAO();
	dao.deleteOne(revno);
	
	System.out.println("삭제신호");
	response.sendRedirect("../review/list.jsp");
	
}
%>
    