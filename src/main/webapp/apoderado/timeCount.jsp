<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.Calendar"%>
<%@page import="kr.co.dongdong.dao.ReserveDAO"%>
<%@page import="kr.co.dongdong.dao.UseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String cno = request.getParameter("cnt");
	String fno = request.getParameter("fno");

   	UseDAO dao = new UseDAO();
   	int total_Facno = dao.getTotal(Integer.parseInt(fno));
   	
   	ReserveDAO rdao = new ReserveDAO();

	Calendar cal = Calendar.getInstance();
   	int year = cal.getTime().getYear()+1900;
   	int month = cal.getTime().getMonth()+Integer.parseInt(cno);
   	
   	cal.set(year,month,1);
   	
   	int in_d_year = cal.getTime().getYear()+1900;
   	int in_d_month = cal.getTime().getMonth();

   	int lastday = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
   	/* 
   	System.out.println(year);
   	System.out.println(in_d_year);
   	System.out.println(month);
   	System.out.println(in_d_month);
   	System.out.println(lastday);
   	 */
   	JSONArray jsonArray = new JSONArray();
   	
   	for(int i=1; i<=lastday; i++) {
   		int n = rdao.getFacilitiesTotal(Integer.parseInt(fno), in_d_year+"/"+(in_d_month+1)+"/"+i);
   		   		
   		JSONObject jsonObject = new JSONObject();
   		
   		jsonObject.put("n", n);
   		jsonObject.put("total", total_Facno);
   		
   		jsonArray.add(jsonObject);
   	}
   	out.println(jsonArray);
	// System.out.println(jsonArray);

%>