<%@page import="kr.co.dongdong.dao.InterestsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	
	String clid = request.getParameter("clid");
	String param = request.getParameter("facno");
	
	System.out.println(param);
	int result = 0;
	
	if(clid != null && param != null){
		int facno = Integer.parseInt(param);
		InterestsDAO dao = new InterestsDAO();
		result = dao.isExists(clid, facno); // 찜 목록에 일치하는 데이터가 있는지 확인
	
		if(result == 0){ // 데이터가 없는 경우
			dao.InsertOne(clid, facno);	// 새로 추가	
			System.out.println("새로 추가");
		}else{ // 데이터가 있는 경우
			dao.deleteOne(clid, facno); // 기존 데이터 삭제
			System.out.println("삭제");
		};
	};
	out.println(result);
	
%>