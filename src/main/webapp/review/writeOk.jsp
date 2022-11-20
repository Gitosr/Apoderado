
<%@page import="kr.co.dongdong.vo.ReviewVO"%>
<%@page import="kr.co.dongdong.dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	//1. 파라미터값 가져오기
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	
	
	String title = request.getParameter("title");
	String score = request.getParameter("score");
	String contents = request.getParameter("contents");
	String no = request.getParameter("resno");
	
	if(no != null && title != null && score !=null && contents != null){
		ReviewDAO dao = new ReviewDAO();
		ReviewVO vo = new ReviewVO();
		int revscore = Integer.parseInt(score);
		int resno = Integer.parseInt(no);
		
		vo.setRevtitle(title);
		vo.setRevcontents(contents);
		vo.setRevscore(revscore);
		vo.setResno(resno);
		
		dao.insertOne(vo);
		
		//list.jsp로 리다이렉트
		response.sendRedirect("../review/list.jsp");
	}
%>
