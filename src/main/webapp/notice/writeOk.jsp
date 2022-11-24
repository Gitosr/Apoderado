
<%@page import="kr.co.dongdong.vo.NoticeVO"%>
<%@page import="kr.co.dongdong.dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	//1. 파라미터값 가져오기
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	
	String writer = request.getParameter("writer");
	String no = request.getParameter("facno");
	String title = request.getParameter("title");
	String contents = request.getParameter("contents");
	
	if(writer != null && title != null && contents != null && no!=null){
		int facno = Integer.parseInt(no);
		NoticeDAO dao = new NoticeDAO();
		NoticeVO vo = new NoticeVO();
		vo.setClid(writer);
		vo.setFacno(facno);
		vo.setNottitle(title);
		vo.setNotcontents(contents);
		
		dao.insertOne(vo);
		
		//list.jsp로 리다이렉트
		response.sendRedirect("list.jsp");
	}
%>
