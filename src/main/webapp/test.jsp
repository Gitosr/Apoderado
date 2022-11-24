<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		var d = new Date();
		nowDate = d;
		 var thisMonth = new Date(nowDate.getFullYear(), nowDate.getMonth(), 1);
	     var thisLastDay = new Date(nowDate.getFullYear(), nowDate.getMonth(), 0);	
	     console.log(thisMonth);
	     console.log(thisLastDay);
	});

</script>
</head>
<body>

</body>
</html>