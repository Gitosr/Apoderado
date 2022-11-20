<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@page import="kr.co.dongdong.vo.CommentsVO"%>
<%@page import="kr.co.dongdong.dao.CommentsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8"); 
	
	Object obj = session.getAttribute("vo");
	
	String cno = request.getParameter("comno");
	int comno = Integer.parseInt(cno);
	
	
	if(obj !=null){
		ClientVO vo2 = (ClientVO)obj;
		CommentsVO vo = new CommentsVO();
	    CommentsDAO dao = new CommentsDAO();
		
		String comtxt = request.getParameter("txtComscontents");
	
	
		vo.setComno(comno);
		vo.setClid(vo2.getClid());
		vo.setComscontents(comtxt);
		
		dao.insertOne(vo);
		response.sendRedirect("detail.jsp?comno="+vo.getComno());
		
	}
%>