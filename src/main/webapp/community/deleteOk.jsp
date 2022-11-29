
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
	
	// 현재 용병게시판에 속해있는 모든 댓글 삭제
	dao2.deleteAll(comno);
	
	// 용병게시판 글 삭제
	dao.deleteOne(comno);
	
	System.out.println(comno);
	response.sendRedirect("list.jsp");

}
%>
    