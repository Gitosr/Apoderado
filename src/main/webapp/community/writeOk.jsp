<%@page import="kr.co.dongdong.vo.CommunityVO"%>
<%@page import="kr.co.dongdong.dao.CommunityDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	//1. 파라미터값 가져오기
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	
	String writer = request.getParameter("writer");
	String title = request.getParameter("title");
	String contents = request.getParameter("contents");
	
	if(writer != null && title != null && contents != null){
		CommunityDAO dao = new CommunityDAO();
		CommunityVO vo = new CommunityVO();
		vo.setClid(writer);
		vo.setComtitle(title);
		vo.setComfield(contents);
		
		dao.insertOne(vo);
		
		//list.jsp로 리다이렉트
		response.sendRedirect("list.jsp");
	}
%>
