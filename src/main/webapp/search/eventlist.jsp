<%@page import="test.Event"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="kr.co.dongdong.vo.FacilityVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.dongdong.dao.FacilityDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
		
		String fevent = request.getParameter("fevent");
		
		String facloc = request.getParameter("facloc");
		
		int facevent = Integer.parseInt(fevent);
		System.out.println("1.fevent :"+fevent);
		System.out.println("2.facloc :"+facloc);
		if(facloc == "전체"){
			System.out.println("제발제발제발");
		}
		
		
		
		FacilityDAO dao = new FacilityDAO();
		
		ArrayList<FacilityVO> list = new ArrayList<FacilityVO>();
		if(facevent == -1 && facloc.equals("전체")){
			list = dao.selectAll();
			System.out.println("dao.selectAll()실행");
			
		}else if(facevent == -1){
			list = dao.locAll(facloc);
				
			System.out.println("dao.locAll실행");
		}else if(facloc.equals("전체")){
			//facevent = Integer.parseInt(fevent);
			list = dao.eventAll(facevent);
			System.out.println("dao.eventAll실행");
		}else{
			//facevent = Integer.parseInt(fevent);
			list = dao.elAll(facevent, facloc);
			System.out.println("dao.elAll실행");
		}
		
		JSONArray jsonArray = new JSONArray();
		
		Event e = new Event();

		String event = e.selectEvent(facevent);
		if(list.isEmpty()){
			JSONObject jsonobject = new JSONObject();
			jsonobject.put("empty", "empty");
			out.println(jsonobject);
		}else{
		//System.out.println(list);
		for(FacilityVO vo : list){
			JSONObject jsonobject = new JSONObject();
			
			jsonobject.put("facno", vo.getFacno());
			jsonobject.put("event", event);
			jsonobject.put("facname", vo.getFacname());
			jsonobject.put("facaddr", vo.getFacaddr());
			jsonobject.put("facmark", vo.getFacmark());
			jsonobject.put("facprice", vo.getFacprice());
			jsonobject.put("facexplain", vo.getFacexplain());
			jsonobject.put("facimg", vo.getFacimg());
			jsonobject.put("facparking", vo.getFacparking());
			jsonobject.put("facshower", vo.getFacshower());
			jsonobject.put("factype", vo.getFactype());
			jsonobject.put("facregister", vo.getFacregister());
			jsonobject.put("clid", vo.getClid());
			
			jsonArray.add(jsonobject);
			
		}
		
		System.out.println(jsonArray);
		out.println(jsonArray);
		}
	%>
