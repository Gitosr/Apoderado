<%@page import="kr.co.dongdong.vo.ReviewVO"%>
<%@page import="kr.co.dongdong.dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
//1. 파라미터값 가져오기
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

String no = request.getParameter("revno");

if (no != null) {
	int revno = Integer.parseInt(no);
	String score = request.getParameter("score");
	int revscore = Integer.parseInt(score);
	String revtitle = request.getParameter("title");
	String revcontents = request.getParameter("contents");

	//2. dao
	ReviewDAO dao = new ReviewDAO();
	ReviewVO vo = new ReviewVO();
	vo.setRevno(revno);
	vo.setRevscore(revscore);
	vo.setRevtitle(revtitle);
	vo.setRevcontents(revcontents);
	dao.updateOne(vo);
	

	response.sendRedirect("../review/list.jsp");

}
%>
