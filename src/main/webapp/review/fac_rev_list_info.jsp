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
	
	int facno = -1;
	int currentPage = -1;
	
	if(no!=null && no!=null){
		facno = Integer.parseInt(no);
		currentPage = Integer.parseInt(no2);
	}

	/* 1페이지당 게시물 수  */
	int recordPerPage = 10;
	
	int startNo = (currentPage - 1) * recordPerPage + 1;
	int endNo = currentPage * recordPerPage;
	
	//총 리뷰게시물 수 (아이디 당)
	int totalCount = dao.getTotal_facno(facno); 

	//총 페이지 수
	int totalPage = 0; 
	if(totalCount > recordPerPage) {
		totalPage = (totalCount % recordPerPage == 0) ? totalCount / recordPerPage : totalCount / recordPerPage + 1;
	
	} else {
		totalPage = 1;
	}
	
	//시작페이지번호
	int startPage = 1;
	
	//끝페이지번호
	int endPage = totalPage;

	//시작페이지 미세조정
	if (currentPage <= 5) {
		startPage = 1;
	} else if (currentPage >= 6) {
		startPage = currentPage - 4;
	}

	//끝페이지 미세조정
	if (totalPage - currentPage <= 5) {
		endPage = totalPage;
	} else if (totalPage - currentPage > 5) {
		if (currentPage <= 5) {
			if (totalPage > 10) {
		endPage = 10;
			} else {
		endPage = totalPage;
			}
		} else {
			endPage = currentPage + 4;
		}
	}
	
	boolean isPre = false;
	boolean isNext = false;

	//이전값이 존재하면 true;
	//다음값이 존재하면 true;
	//현재 페이지 번호에서 5을 뺀 값이 0이상이면 이전값이 존재
	if (currentPage - 5 > 0) {
		isPre = true;
	}
	//현재 페이지 번호에서 5를 더한 값이 끝페이지 번호보다 작으면 다음값이 존재
	if (currentPage + 5 <= totalPage) {
		isNext = true;
	}
	
	JSONArray jsonArray= new JSONArray();
	
	//최근 작성한 게시물 10개만 가져오기
	ArrayList<ReviewVO> list = dao.selectReview(facno, startNo, endNo);
	for (ReviewVO vo : list) {
		int revno = vo.getRevno();
		
		String facname = dao.selectFacname(vo.getResno());
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
		jsonObject.put("facname",facname);
		jsonObject.put("revtitle",revtitle);
		jsonObject.put("clid",clid);
		jsonObject.put("revdate",revdate);
		jsonObject.put("scoreStar",scoreStar);
		
		jsonObject.put("startPage", startPage);
		jsonObject.put("endPage", endPage);
		
		jsonObject.put("isPre", isPre);
		jsonObject.put("isNext", isNext);
		
		jsonArray.add(jsonObject);
	}
	out.println(jsonArray);
%>