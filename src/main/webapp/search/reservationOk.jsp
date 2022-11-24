<%@page import="java.io.PrintWriter"%>
<%@page import="kr.co.dongdong.dao.ReserveDAO"%>
<%@page import="kr.co.dongdong.vo.ReserveVO"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>

	<%
		Object obj = session.getAttribute("vo");
		
		if(obj != null){
			ClientVO vo = (ClientVO)obj;
			String clid = vo.getClid();
			String fno = request.getParameter("facno");
			
			int facno = Integer.parseInt(fno);
			
			String time = request.getParameter("restime");
			int restime = Integer.parseInt(time);
			
			String resdate = request.getParameter("resdate");
			System.out.println("예약성공");
			ReserveVO rvo = new ReserveVO();
			
			rvo.setClid(clid);
			rvo.setFacno(facno);
			rvo.setRestime(restime);
			rvo.setResdate(resdate);
			
			ReserveDAO dao = new ReserveDAO();
			
			dao.insertOne(rvo);
			%>
			<script language="javascript">
			//버튼클릭시 javascript 호출합니다.
			$(function(){
				self.close();   //자기자신창을 닫습니다.
			})
    			
			</script>
					
			<%
					
		}
	%>
</body>
</html>