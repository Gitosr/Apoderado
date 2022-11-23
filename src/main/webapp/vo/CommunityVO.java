package kr.co.dongdong.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor 
@NoArgsConstructor 
public class CommunityVO {
	int comno;
	String clid, comtitle, comfield, comdate;
	int hits;
	
}
