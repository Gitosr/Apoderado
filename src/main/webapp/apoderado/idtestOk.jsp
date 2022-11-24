<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@page import="kr.co.dongdong.dao.ClientDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	
	String id = request.getParameter("id");
	
	ClientDAO dao = new ClientDAO();
	
	ClientVO vo = dao.selectOne(id);
	
	if(vo == null) {
		// 사용 가능한 아이디
		session.setAttribute("idtest", id);
		response.sendRedirect("register.jsp");
	
	}else {
		// 사용 불가능한 아이디
		session.setAttribute("idtest", "");
		response.sendRedirect("register.jsp");
	}
	
%>