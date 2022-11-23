
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Arrays"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@page import="kr.co.dongdong.vo.ReviewVO"%>
<%@page import="kr.co.dongdong.dao.ReviewDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% 

	//현재 페이지 	
	String search = request.getParameter("search");	
	String re = search.replaceAll("[.,/]", " ");
	String re1 = re.replaceAll("\\s+", " ");
	String[] searchArr = re1.split(" ");
		
	ReviewDAO dao = new ReviewDAO();
	String no = request.getParameter("facno");
	String no2 = request.getParameter("currentPage");
	String no3 = request.getParameter("count");
	
	int facno = -1;
	int currentPage = -1;
	int count = -1;
	
	if(no!=null && no2!=null && no3!=null){
		facno = Integer.parseInt(no);
		currentPage = Integer.parseInt(no2);
		count = Integer.parseInt(no3);
		
	}
	// 시설에 담겨 있는 리뷰 중 searchArr배열에 있는 검색어에 포함되는 값들의 리뷰번호를 arraylist에 저장한다.
	ArrayList<Integer> list = dao.searchRevno(searchArr, facno);		
	
	// 조건에 맞는 리뷰번호들을 list2에 reviewvo 방식으로 넣는다.
	ArrayList<ReviewVO> list2 = new ArrayList<ReviewVO>();
	
	ReviewVO vo2 = null;
	
	for (Integer vo : list) {
		vo2 = dao.selectOne(vo);
		list2.add(vo2);
	}
	
	/* 1페이지당 게시물 수  */
	int recordPerPage = 10;
	
	int startNo = (currentPage - 1) * recordPerPage + 1;
	int endNo = currentPage * recordPerPage;
	
	//총 리뷰게시물 수 (아이디 당)
	int totalCount = list.size(); 
	System.out.println(totalCount);

	//총 페이지 수
	int totalPage = 0; 
	if(totalCount > recordPerPage) {
		totalPage = (totalCount % recordPerPage == 0) ? totalCount / recordPerPage : totalCount / recordPerPage + 1;
	
	} else {
		totalPage = 1;
	}

	//시작페이지번호
	int startPage = (count*10)+1;
	
	//끝페이지번호
	int endPage = startPage+9;
	
	if(endPage > totalPage) {
		endPage = totalPage;
	}
	System.out.println(endPage + "끝번호 ");

	JSONArray jsonArray= new JSONArray();
	if(endNo > totalCount) {
		endNo = totalCount;
	}
	if(search!=null){	
		for(int i=startNo-1; i<=endNo-1; i++) {
			
			int revno = list2.get(i).getRevno();
			String revcontents = list2.get(i).getRevcontents();
			
			String revtitle = list2.get(i).getRevtitle();
			String clid = dao.selectID(list2.get(i).getResno());
			String revdate = list2.get(i).getRevdate();
			
			int score = list2.get(i).getRevscore();
			
			System.out.println(revno);
			System.out.println(revcontents);
			System.out.println(revtitle);
			System.out.println(clid);
			System.out.println(revdate);
			
			String scoreStar = "";
			
			if(score==1){scoreStar = "★";}
			if(score==2){scoreStar = "★★";}
			if(score==3){scoreStar = "★★★";}
			if(score==4){scoreStar = "★★★★";}
			if(score==5){scoreStar = "★★★★★";}
		
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("revno",revno);		
			jsonObject.put("revtitle",revtitle);
			jsonObject.put("revcontents",revcontents);
			jsonObject.put("revdate",revdate);
			jsonObject.put("scoreStar",scoreStar);
			jsonObject.put("clid",clid);
			
			jsonObject.put("startPage", startPage);
			jsonObject.put("endPage", endPage);
			jsonObject.put("totalPage", totalPage);
			
			jsonArray.add(jsonObject);
		}
	}
	
	out.println(jsonArray);
	System.out.println(jsonArray);
%>
