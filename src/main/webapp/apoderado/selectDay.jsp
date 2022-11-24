<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="kr.co.dongdong.vo.UseVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.dongdong.dao.UseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String date = request.getParameter("date");
	String no = request.getParameter("facno");
	
	int facno = -1;
	
	if(no != null) {
		facno = Integer.parseInt(no);	
	}

	System.out.println(date);
	System.out.println(no);
	
	UseDAO dao = new UseDAO();
	ArrayList<UseVO> list = new ArrayList<UseVO>();
	
	list = dao.getTime(facno, date);
	
	JSONArray jsonArray = new JSONArray();
	
	for(UseVO vo : list) {
		JSONObject jsonObject = new JSONObject();
		
		int restime = vo.getRestime();
		String usetime = vo.getUsetime();
		
		jsonObject.put("facno", facno);
		jsonObject.put("restime", restime);
		jsonObject.put("usetime", usetime);
		
		jsonArray.add(jsonObject);
	}
	
	out.println(jsonArray);
	System.out.println(jsonArray);

%>