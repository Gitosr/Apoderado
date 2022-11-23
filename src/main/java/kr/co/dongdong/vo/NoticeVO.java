package kr.co.dongdong.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor 
@NoArgsConstructor 
public class NoticeVO {
	int notno;
	String clid;
	int clrank, facno;
	String nottitle, notcontents, notdate;
	int nothits;
}
