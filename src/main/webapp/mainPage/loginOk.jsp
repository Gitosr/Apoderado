<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@page import="kr.co.dongdong.dao.ClientDAO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	ClientDAO dao = new ClientDAO();
	
	ClientVO vo = dao.loginOk(id, pw);
	
	if(vo == null) {
		// 로그인 실패
		response.sendRedirect("login.jsp");
	
	}else {
		// 로그인 성공
		response.sendRedirect("main.jsp"); // 메인페이지로 리다이렉트되도록 수정했습니다.
		session.setAttribute("vo", vo);
	}
	
%>