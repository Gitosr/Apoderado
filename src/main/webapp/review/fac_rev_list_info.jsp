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
	String no2 = request.getParameter("currentPage");
	String no3 = request.getParameter("count");
	
	int facno = -1;
	int currentPage = -1;
	int count = -1;
	
	if(no!=null && no2!=null && no3!=null ){
		facno = Integer.parseInt(no);
		currentPage = Integer.parseInt(no2);
		count = Integer.parseInt(no3);
	}

	/* 1페이지당 게시물 수  */
	int recordPerPage = 10;
	
	int startNo = (currentPage - 1) * recordPerPage + 1;
	int endNo = currentPage * recordPerPage;
	
	//총 리뷰게시물 수 (아이디 당)
	int totalCount = dao.getTotal_facno(facno); 
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
	
	JSONArray jsonArray= new JSONArray();

	//최근 작성한 게시물 10개만 가져오기
	ArrayList<ReviewVO> list = dao.selectReview(facno, startNo, endNo);
	for (ReviewVO vo : list) {
		int revno = vo.getRevno();
		String revcontents = vo.getRevcontents();
		
		String revtitle = vo.getRevtitle();
		String clid = dao.selectID(vo.getResno());
		String revdate = vo.getRevdate();
		
		int score = vo.getRevscore();
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
	out.println(jsonArray);
	System.out.println(jsonArray);
%>