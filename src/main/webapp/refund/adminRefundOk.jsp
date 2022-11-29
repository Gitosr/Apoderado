
<%@page import="kr.co.dongdong.vo.RefundVO"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="kr.co.dongdong.dao.RefundDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//1. 파라미터값 가져오기
String[] no = request.getParameterValues("resno");
System.out.println(no);


RefundVO vo = new RefundVO();
	RefundDAO dao = new RefundDAO();
if(no==null){
	out.println("<script>alert('승인 할 환불 내역을 선택해주세요.'); location.href='../apoderado/mypage.jsp?sign='</script>");
    out.flush();
}

if(no!=null){
	for(String val : no) {	

	int resno = Integer.parseInt(val); 
	dao.stateRef(resno);
	dao.stateRes(resno);
	
	out.println("<script>alert('환불을 승인하였습니다.'); location.href='../apoderado/mypage.jsp?sign='</script>");
    out.flush();
	}
}


%>
