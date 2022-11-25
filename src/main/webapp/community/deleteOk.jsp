
<%@page import="kr.co.dongdong.dao.CommentsDAO"%>
<%@page import="kr.co.dongdong.dao.CommunityDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//1. 파라미터값 가져오기
String no = request.getParameter("comno");
if(no!=null){
	int comno = Integer.parseInt(no);
	CommunityDAO dao = new CommunityDAO();
	CommentsDAO dao2 = new CommentsDAO();
	dao2.deleteAll();
	System.out.println(comno);
	response.sendRedirect("list.jsp");

}
%>
    