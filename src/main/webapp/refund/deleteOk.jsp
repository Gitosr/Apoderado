
<%@page import="kr.co.dongdong.vo.RefundVO"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="kr.co.dongdong.dao.RefundDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//1. 파라미터값 가져오기
String refreason="";
String no = request.getParameter("resno");
refreason = request.getParameter("refreason");

RefundVO vo = new RefundVO();
	RefundDAO dao = new RefundDAO();

if(no!=null){
	int resno = Integer.parseInt(no); 
		
	vo.setResno(resno);
	vo.setRefreason(refreason);
	dao.insertOne(vo); //환불게시판에 추가
	dao.deleteOne(resno); //예약게시판 상태변경
	
	response.sendRedirect("refRequest.jsp");

}
%>
    