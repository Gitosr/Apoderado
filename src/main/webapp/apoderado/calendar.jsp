<%@page import="java.util.Calendar"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>달력 만들기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
* {
    margin: 0;
    padding: 0
}
.custom_calendar_table {
	border-collapse: collapse;
	text-align: center;
}

.custom_calendar_table td {
    text-align: center;
    padding: 10px;
}

.custom_calendar_table thead.cal_date th {
    font-size: 1.5rem;
}

.custom_calendar_table thead.cal_date th button {
    font-size: 1.5rem;
    background: none;
    border: none;
}

.custom_calendar_table thead.cal_week th {
   padding: 10px 0px;
   border-bottom: 1px solid gray;
   border-top: 1px solid gray;
   text-align: center;
}

.custom_calendar_table tbody td {
    cursor: pointer;
}

.custom_calendar_table tbody td:nth-child(1) {
    color: red;
}

.custom_calendar_table tbody td:nth-child(7) {
    color: #288CFF;
}

.custom_calendar_table tbody td.select_day {
    background-color: rgb(204 229 255);
    color: #fff;
}
.num {
	color: gray;
}
.time_full {
	background-color: gray;
	color: white;
}


</style>
<script type="text/javascript">
<%
String no = request.getParameter("facno");
int facno = Integer.parseInt(no);
%>
var count = 0;
$(function () {
	var today = new Date();
    calendarMaker($("#calendarForm"), new Date());
   
    $.ajax({
       	url : "timeCount.jsp",
       	data : { "cnt" : count, "fno" : <%=no%> },
           	dataType : "json",
           	success : function(res){
				var depart = res;
           		
           		for(var i=0; i<depart.length; i++) {
           			var total = parseInt(depart[i].total);
           			var n = parseInt(depart[i].n);

					if(n!=total) {
						$("#cou_day"+(i+1)+" .num").text(depart[i].n+"/"+depart[i].total);	
                   		$("#cou_day"+(i+1)+" .num").addClass("num")
              		}else {
              			$("#cou_day"+(i+1)+" .num").text(depart[i].n+"/"+depart[i].total);
              			$("#calendar_"+(i+1)).attr("onclick",'event.cancelBubble=true');
              			$("#calendar_"+(i+1)).addClass("time_full");
              			$("#cou_day"+(i+1)+" .num").removeClass("num")
           			}
           		}
           	}
		}); 
    });
	
    
    var nowDate = new Date();

    function calendarMaker(target, date) {
    
    	var year = null;
    	var month = null;
        
    	if (date == null || date == undefined) {
            date = new Date();
        }
        
    	nowDate = date;
       
        if ($(target).length > 0) {
            year = nowDate.getFullYear();
            month = nowDate.getMonth() + 1;
            $(target).empty().append(assembly(year, month));
        } else {
            console.error("custom_calendar Target is empty!!!");
            return;
        }

        var thisMonth = new Date(nowDate.getFullYear(), nowDate.getMonth(), 1);
        var thisLastDay = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, 0);

        var tag = "<tr>";
        var cnt = 0;
        //빈 공백 만들어주기
        for (i = 0; i < thisMonth.getDay(); i++) {
        	console.log(thisMonth.getDay()+"지금");
            tag += "<td onclick='event.cancelBubble=true'></td>";
            cnt++;
        }
 
        //날짜 채우기
        for (var i = 1; i <= thisLastDay.getDate(); i++) {
            if (cnt % 7 == 0) { tag += "<tr>"; }
            if(nowDate.getDate()>i && count==0) {
				tag += "<td id='calendar_"+i+"' onclick='event.cancelBubble=true' class='time_full'><span class='day'>" + i + "</span><div id='cou_day"+i+"'><span class='num'></span></div></td>";
            }else {
            	tag += "<td id='calendar_"+i+"'><span class='day'>" + i + "</span><div id='cou_day"+i+"'><span class='num'></span></div></td>";
            }
	            cnt++;
	            if (cnt % 7 == 0) {
	                tag += "</tr>";
	           
			}
        }
        
        $(target).find("#custom_set_date").append(tag);
        calMoveEvtFn();

        function assembly(year, month) {
            var calendar_html_code =
                "<table class='custom_calendar_table'>" +
                "<thead class='cal_date'>" +
                "<th><button type='button' class='prev'><</button></th>" +
                "<th colspan='5'><p><span>" + year + "</span>년 <span>" + month + "</span>월</p></th>" +
                "<th><button type='button' class='next'>></button></th>" +
                "</thead>" +
                "<thead  class='cal_week'>" +
                "<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>" +
                "</thead>" +
                "<tbody id='custom_set_date'>" +
                "</tbody>" +
                "</table>";
            return calendar_html_code;
        }

        function calMoveEvtFn() {
            //전달 클릭
            if(count > 0) {
				$(".custom_calendar_table").on("click", ".prev", function () {
					count--;
				    nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() - 1, nowDate.getDate());
				    calendarMaker($(target), nowDate);
				    
				
				    $.ajax({
				    	url : "timeCount.jsp",
				    	data : { "cnt" : count, "fno" : <%=no%> },
						dataType : "json",
				        success : function(res){
							var depart = res;
				            		
		            		for(var i=0; i<depart.length; i++) {
		            			var total = parseInt(depart[i].total);
		            			var n = parseInt(depart[i].n);
	            			
								if(n!=total) {
									$("#cou_day"+(i+1)+" .num").text(depart[i].n+"/"+depart[i].total);	
				                    	$("#cou_day"+(i+1)+" .num").addClass("num")
				               	}else {
			               			$("#cou_day"+(i+1)+" .num").text(depart[i].n+"/"+depart[i].total);
			               			$("#calendar_"+(i+1)).attr("onclick",'event.cancelBubble=true');
			               			$("#calendar_"+(i+1)).addClass("time_full");
			               			$("#cou_day"+(i+1)+" .num").removeClass("num")
			            		}
							}
						}
				            
					});
				});
            }
           
            if(count < 1) {
            //다음날 클릭            
	            $(".custom_calendar_table").on("click", ".next", function () {
	            	count++;
	                nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, nowDate.getDate());
	                calendarMaker($(target), nowDate); 
	                
	               
	                $.ajax({
		               	url : "timeCount.jsp",
		               	data : { "cnt" : count, "fno" : <%=no%> },
		               	dataType : "json",
		               	success : function(res){
							var depart = res;
		               		
		               		for(var i=0; i<depart.length; i++) {
		               			var total = parseInt(depart[i].total);
		               			var n = parseInt(depart[i].n);
		               			
								if(n!=total) {
		                       		$("#cou_day"+(i+1)+" .num").text(depart[i].n+"/"+depart[i].total);	
		                       		$("#cou_day"+(i+1)+" .num").addClass("num")
		                  		}else {
		                  			$("#cou_day"+(i+1)+" .num").text(depart[i].n+"/"+depart[i].total);
		                  			$("#calendar_"+(i+1)).attr("onclick",'event.cancelBubble=true');
		                  			$("#calendar_"+(i+1)).addClass("time_full");
		                  			$("#cou_day"+(i+1)+" .num").removeClass("num")
		               			}
		               		}
		               	}
					});  
	            });
            }
            //일자 선택 클릭
            $(".custom_calendar_table").on("click", "td", function () {
                $(".custom_calendar_table .select_day").removeClass("select_day");
                $(this).removeClass("select_day").addClass("select_day");
                var date = year+"/"+month+"/"+$(this).find(".day").text();
               
                $.ajax({
                	url : "../apoderado/selectDay.jsp",
                	data : { "date" : date, "facno" : <%= no%>},
                	dataType : "json",
                	success : function(response) {
						var res = response;
                		
                		var data = "";
                		
                		if(res.length==0) {
                			console.log("데이터가 없습니다.");
                		}else {
                			data += '<form name="reserve" method="get">';
                			data += '<select name="restime" id="">-----------';
                			for(var i=0; i<res.length; i++) {
                				data += '<option value="'+ res[i].restime +'">' + res[i].restime + ' : ' +res[i].usetime+ "</option>";
                			}
                			data += '</select>';
                			data += '<input type="hidden" name="resdate" value="'+date+'"/>';
                			data += '<input type="hidden" name="facno" value="<%=facno%>"/>';
            				data += '</form><input type="button" value="전송" onclick="openReserve();"/>';
                		}
                		
                		$("#select_time").empty();
    					$("#select_time").append(data);	
                	}
                });  
            });
        }
	}
    </script> 				
</head>
<body>
	
    <div id="calendarForm"></div>
    <div id="#select_time"></div>

</body>
</html>