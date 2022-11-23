
<%@page import="kr.co.dongdong.vo.NoticeVO"%>
<%@page import="kr.co.dongdong.dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
//1. 파라미터값 가져오기
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

String no = request.getParameter("notno");
String no2 = request.getParameter("facno");
String clid = request.getParameter("writer");
String nottitle = request.getParameter("title");
String notcontents = request.getParameter("contents");

if (no != null&&no2!=null) {
	int notno = Integer.parseInt(no);
	int facno = Integer.parseInt(no2);
	
	//2. dao
	NoticeDAO dao = new NoticeDAO();
	NoticeVO vo = new NoticeVO();
	vo.setFacno(facno);
	vo.setNottitle(nottitle);
	vo.setNotcontents(notcontents);
	vo.setNotno(notno);
	dao.updateOne(vo);
	

	response.sendRedirect("detail.jsp?notno="+vo.getNotno());

}
%>
