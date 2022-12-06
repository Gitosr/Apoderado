<%@page import="kr.co.dongdong.dao.ClientDAO"%>
<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	Object obj = session.getAttribute("vo");
	ClientDAO dao = new ClientDAO();
	ClientVO vo = null;
	
	
	
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		
		String birth1 = request.getParameter("birth1");
		String birth2 = request.getParameter("birth2");
		String birth3 = request.getParameter("birth3");
		
		String email1 = request.getParameter("email1");
		String email2 = request.getParameter("email2");
		
		String mp = request.getParameter("mp");
		String gender = request.getParameter("gender");
		String cardno = request.getParameter("cardno");
		String email = email1+"@"+email2;
		String birthd = birth1+"-"+birth2+"-"+birth3;
		
		if(obj != null) {
			vo = (ClientVO)obj;
			
		}
		vo.setClname(name);
		vo.setClpw(pw);
		
		vo.setClemail(email);
		vo.setClcardno(cardno);
		
		vo.setClbirth(birthd);
		vo.setClmp(mp);

		if(gender.equals("남")) {
			vo.setClgender(1);
			
		}else if(gender.equals("여")) {
			vo.setClgender(2);
			
		}
		
		
		dao.updateOne(vo);
		
		response.sendRedirect("mypage.jsp");%>