<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
   <style>
  #feedback { font-size: 1.4em; }
  #selectable .ui-selecting { background: #FECA40; }
  #selectable .ui-selected { background: #F39814; color: white; }
  #selectable { list-style-type: none; margin: 0; padding: 0; width: 40%; }
  #selectable li { margin: 3px; padding: 0.4em; font-size: 1.4em; height: 18px; }
  </style>
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script>
  $(function(){
		//var reserve = document.getElementById("reserve");
		$( "#datepicker" ).datepicker();
		$( "#selectable" ).selectable({
		      stop: function() {
		        $( ".ui-selected", this ).each(function() {
		          var index = $( "#selectable li" ).index( this );
		          $("#restime").val(index + 1);
		          
		          console.log($("#restime").val());
		        });
		      }
		    });
		$("#reserve").on("click",function(){
			document.frm.action = "testcal.jsp";
			document.frm.method = "get";
			document.frm.submit();
		})
	})
  </script>
</head>
<body>
<form action="" name ="frm">
		<p>Date: <input type="text" name = "resdate" id="datepicker"></p>
	
	<input type="button" id="reserve" value="예약하기" />
	<input type="hidden" name="restime" id="restime" value="" />
	
<ol id="selectable">
  <li class="ui-widget-content" value = "Item 1">Item 1</li>
  <li class="ui-widget-content">Item 2</li>
  <li class="ui-widget-content">Item 3</li>
  <li class="ui-widget-content">Item 4</li>
</ol>
	</form>


</body>
</html>