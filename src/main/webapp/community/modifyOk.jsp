<%@page import="kr.co.dongdong.vo.CommunityVO"%>
<%@page import="kr.co.dongdong.dao.CommunityDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
//1. 파라미터값 가져오기
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

String no = request.getParameter("comno");

if (no != null) {
	int comno = Integer.parseInt(no);
	String clid = request.getParameter("writer");
	String comtitle = request.getParameter("title");
	String comfield = request.getParameter("contents");

	//2. dao
	CommunityDAO dao = new CommunityDAO();
	CommunityVO vo = new CommunityVO();
	vo.setComno(comno);
	vo.setClid(clid);
	vo.setComtitle(comtitle);
	vo.setComfield(comfield);
	dao.updateOne(vo);
	

	response.sendRedirect("detail.jsp?comno="+vo.getComno());

}
%>
