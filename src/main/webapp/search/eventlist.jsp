
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
		String cp = request.getParameter("cp");
		System.out.println("cp : "+cp);
		
		int currentPage = 0;
	
		currentPage = Integer.parseInt(cp);
		
		// 1페이지당 게시물 수
		int recoredPerPage = 9;
		
		int startNo = (currentPage - 1) * recoredPerPage + 1;
		int endNo = currentPage * recoredPerPage;
		
		
		
		
	
	
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
		
			
			
		// 총 게시물 수
		int totalCount = dao.getTotal();	
			
		
		//----------------------------------------------------------------
		ArrayList<FacilitiesVO> list = new ArrayList<FacilitiesVO>();
		if(facevent == -1 && facloc.equals("전체")){
			list = dao.selectAll(startNo,endNo);
			System.out.println("evntlist/dao.selectAll(startNo,endNo)실행");
			
		}else if(facevent != -1 && facloc.equals("전체") != true){
			list = dao.elAll(facevent, faclocArray,startNo,endNo);
			totalCount = dao.getTotal(facevent,faclocArray);
			System.out.println("evntlist/dao.elAll실행");
		}
		else if(facevent == -1){
			list = dao.locAll(faclocArray,startNo,endNo);
			totalCount = dao.getTotal(faclocArray);	
			System.out.println("evntlist/dao.locAll실행");
		}else if(facloc.equals("전체")){
			//facevent = Integer.parseInt(fevent);
			list = dao.eventAll(facevent,startNo,endNo);
			totalCount = dao.getTotal(facevent);
			System.out.println("evntlist/dao.eventAll(facevent,startNo,endNo)실행");
		}
		
		// ------------------------------------------------------------
		
		//----------------------------------------------------------------
		// 페이징
		
						
		// 총페이지 수
		int totalPage = (totalCount % recoredPerPage == 0)?totalCount/recoredPerPage : totalCount/recoredPerPage +1;
		System.out.println(totalPage);
		// 시작 페이지
		int startPage = 1;
		// 끝페이지
		int endPage = totalPage;
						
		// 시작페이지 미세조정
		if(currentPage <= 5){
			startPage = 1;
		}else if(currentPage >= 6){
			startPage = currentPage -4;
		}
						
		// 끝 페이지 미세 조정
		if(totalPage - currentPage <= 5){
			endPage = totalPage;
		}else if(totalPage - currentPage > 5){
			if(currentPage <= 5){
				if(totalPage > 10){
					endPage = 10;
				}else{
					endPage = totalPage;
				}
			}else{
				endPage = currentPage+4;
			}
		}
						
		boolean isPre = false;
		boolean isNext = false;
						
		// 이전값이 존재하면 true;
		// 다음값이 존재하면 true;
						
		// 현재페이지 번호에서 5를 뺸값이 0이상이면 이전값이 존재
		if(currentPage - 5 > 0){
			isPre = true;
		}
						
		// 현재페이지번호에서 5를 더한값이 끝페이지번호보다 작으면 다음값이 존재
		if(currentPage+5 <= totalPage){
			isNext = true;
		}	
		// ------------------------------------------------------------
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
			jsonobject.put("isPre",isPre);
			jsonobject.put("isNext",isNext);
			jsonobject.put("endPage",endPage);
			jsonobject.put("startPage",startPage);
			jsonArray.add(jsonobject);
			
		}
		
		//System.out.println(jsonArray);
		out.println(jsonArray);
		}
	%>
