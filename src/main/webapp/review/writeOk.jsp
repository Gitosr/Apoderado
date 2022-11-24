
<%@page import="kr.co.dongdong.vo.FacilitiesVO"%>
<%@page import="kr.co.dongdong.dao.FacilitiesDAO"%>
<%@page import="kr.co.dongdong.vo.ReserveVO"%>
<%@page import="kr.co.dongdong.dao.ReserveDAO"%>
<%@page import="kr.co.dongdong.vo.ReviewVO"%>
<%@page import="kr.co.dongdong.dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	//1. 파라미터값 가져오기
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	String pre = request.getParameter("pre");
	
	String title = request.getParameter("title");
	String score = request.getParameter("score");
	String contents = request.getParameter("contents");
	String no = request.getParameter("resno");
	
	if(no != null && title != null && score !=null && contents != null){
		ReviewDAO dao = new ReviewDAO();
		ReviewVO vo = new ReviewVO();
		int revscore = Integer.parseInt(score);
		int resno = Integer.parseInt(no);
		
		vo.setRevtitle(title);
		vo.setRevcontents(contents);
		vo.setRevscore(revscore);
		vo.setResno(resno);
		// 리뷰 등록
		dao.insertOne(vo);
		
		// 리뷰를 들고한 시설의 평균 점수 최신화
		ReserveDAO dao2 = new ReserveDAO();
		int facno = dao2.getFacno(resno);
		
		ReviewDAO dao3 = new ReviewDAO();
		int sum = dao.scoreTotal(facno);
		int count = dao3.getTotal_facno(facno);
		
		double average = sum/count;
		
		FacilitiesDAO dao4 = new FacilitiesDAO();
		
		dao4.updateAvg(average, facno);
		
		//list.jsp로 리다이렉트
		System.out.println(pre);
		response.sendRedirect(pre);
		System.out.println(average+"평균 : " + facno+" 시설번호");
	}
%>
