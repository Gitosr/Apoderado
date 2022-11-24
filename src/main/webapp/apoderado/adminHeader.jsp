<%@page import="kr.co.dongdong.vo.ClientVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<link rel="stylesheet" href="../css/main.css" />
	<%
		Object objclient = session.getAttribute("vo");
		System.out.println("objclient :"+objclient);
		if(objclient != null){
			ClientVO clientvo = (ClientVO)objclient;
			if(clientvo.getClrank() == 2){	
	%>
		<link rel="stylesheet" href="../css/adminheader.css" />
	<%
			}
		}
	%>
		