<%@page import="kr.co.dongdong.dao.ReviewDAO"%>
<%@page import="kr.co.dongdong.vo.ReviewVO"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%


	ReviewDAO dao = new ReviewDAO();
	String no = request.getParameter("facno");
	int facno = -1;
	if(no!=null){
		facno = Integer.parseInt(no);
	}
	
	//dao.selectAll(); --> list 
	ArrayList<ReviewVO> list = dao.selectReview(facno);
	
	JSONArray jsonArray= new JSONArray();
	
	//반복문 사용해서 화면에 h3태그로 요소의 값 출력
	for (ReviewVO vo : list) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("revno",vo.getRevno());
		jsonObject.put("revtitle",vo.getRevtitle());
		jsonObject.put("revcontents",vo.getRevcontents());
		jsonObject.put("revdate",vo.getRevdate());
		jsonObject.put("revscore",vo.getRevscore());
		jsonObject.put("clid", dao.selectID(vo.getResno()));
		jsonObject.put("facname", dao.selectFacname(vo.getResno()));
		
		jsonArray.add(jsonObject);
	}
	out.println(jsonArray);
%>