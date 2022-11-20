<%@page import="kr.co.dongdong.vo.CommentsVO"%>
<%@page import="kr.co.dongdong.dao.CommentsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//1. 파라미터값 가져오기
String no = request.getParameter("clistno");
String cno = request.getParameter("comno");
int comno = Integer.parseInt(cno);
System.out.println(comno);

if(no!=null){
	int clistno = Integer.parseInt(no);
	CommentsDAO dao = new CommentsDAO();
	
	dao.deleteOne(clistno);
	
	response.sendRedirect("detail.jsp?comno="+comno);
}


%>