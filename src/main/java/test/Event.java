package test;

public class Event {
	String event;
	
	public Event(){
		event = "";
	}
	
	public String selectEvent(int num) {
		if(num == 0){
			event += "축구장";
		}
		else if(num == 1){
			event += "야구장";
		}
		else if(num == 2){
			event += "풋살장";
		}
		else if(num == 3){
			event += "배드민턴장";
		}
		else if(num == 4){
			event += "테니스장";
		}
		else if(num == 5){
			event += "농구장";
		}
		else if(num == 6){
			event += "배구장";
		}
		else if(num == 7){
			event += "탁구장";
		}
		else if(num == -1) {
			event += "전체";
		}
		return event;
	}

}
