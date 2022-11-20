
<%@page import="kr.co.dongdong.dao.CommentsDAO"%>
<%@page import="kr.co.dongdong.vo.CommentsVO"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String no = request.getParameter("comno");
int comno = Integer.parseInt(no);
System.out.println(comno);

CommentsDAO dao = new CommentsDAO();
//dao.selectAll(); --> list 
ArrayList<CommentsVO> list = dao.selectOne(comno);


JSONArray jsonArray= new JSONArray();

//반복문 사용해서 화면에 h3태그로 요소의 값 출력
for (CommentsVO vo : list) {
	

	JSONObject jsonObject = new JSONObject();
	jsonObject.put("clistno",vo.getClistno());
	jsonObject.put("comno",vo.getComno());
	jsonObject.put("clid",vo.getClid());
	jsonObject.put("comscontents",vo.getComscontents());
	jsonObject.put("comsdate",vo.getComsdate());
	
	jsonArray.add(jsonObject);
}

 
out.println(jsonArray);
%>