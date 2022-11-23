package kr.co.dongdong.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor 
@NoArgsConstructor 
public class CommentsVO {
	int clistno, comno;
	String clid, comscontents, comsdate;
	
}
