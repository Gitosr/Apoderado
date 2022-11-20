package kr.co.dongdong.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ToprankVO {
	int rownum;
	int count;
	int facno;
	String facname;
	String facimg;
	double facmark;
}
