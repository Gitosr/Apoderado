
<%@page import="test.Event"%>
<%@page import="kr.co.dongdong.vo.FacilitiesVO"%>
<%@page import="kr.co.dongdong.dao.InterestsDAO"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@page import="kr.co.dongdong.dao.FacilitiesDAO"%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
		String fevent = request.getParameter("fevent");
		int facevent = Integer.parseInt(fevent);
		
		String facloc = "";
		String[] faclocArray = request.getParameterValues("facloc");
		for(String fa : faclocArray){
			facloc = fa;
			//System.out.println("evntlist/"+facloc);
		}
		
		
	
		
		
		
		
		
		
		
		
	
	
		//----------------------------------------------------------------
		Object obj = session.getAttribute("vo");
		
		
		FacilitiesDAO dao = new FacilitiesDAO();
		ClientVO cvo = new ClientVO();
		 // 찜 확인
			InterestsDAO dao2 = new InterestsDAO();
		 
		int num = 0;
		boolean heart = false;
		if (obj != null) {
			cvo = (ClientVO)obj;
			System.out.println("evntlist/obj존재");
			System.out.println("evntlist/"+cvo);
			
		}else{
			System.out.println("evntlist/obj미존재");
			System.out.println("evntlist/"+cvo);
			
		}
		
		
			
			
			
		
		ArrayList<FacilitiesVO> list = new ArrayList<FacilitiesVO>();
		if(facevent == -1 && facloc.equals("전체")){
			list = dao.selectAll();
			System.out.println("evntlist/dao.selectAll()실행");
			
		}else if(facevent != -1 && facloc.equals("전체") != true){
			list = dao.elAll(facevent, faclocArray);
			System.out.println("evntlist/dao.elAll실행");
		}
		else if(facevent == -1){
			list = dao.locAll(faclocArray);
				
			System.out.println("evntlist/dao.locAll실행");
		}else if(facloc.equals("전체")){
			//facevent = Integer.parseInt(fevent);
			list = dao.eventAll(facevent);
			System.out.println("evntlist/dao.eventAll실행");
		}
		
		JSONArray jsonArray = new JSONArray();
		
		Event e = new Event();
		String event = e.selectEvent(facevent);
		
		if(list.isEmpty()){
			JSONObject jsonobject = new JSONObject();
			jsonobject.put("empty", "empty");
			out.println(jsonobject);
		}else{
		for(FacilitiesVO vo : list){
			num = dao2.isExists(cvo.getClid() ,vo.getFacno());
			if(num == 1){
				heart = true;
			}else{
				heart = false;
			}
			JSONObject jsonobject = new JSONObject();
			
			
			jsonobject.put("facno", vo.getFacno());
			//jsonobject.put("floc", floc);
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
			jsonobject.put("heart",heart);
			jsonobject.put("cvoclid",cvo.getClid());
			jsonArray.add(jsonobject);
			
		}
		
		//System.out.println(jsonArray);
		out.println(jsonArray);
		}
	%>
