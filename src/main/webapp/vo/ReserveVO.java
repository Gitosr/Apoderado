package kr.co.dongdong.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReserveVO {
	int resno;
	String clid;
	int facno;
	int restime;
	String resdate;
	String orderdate;
	int resstate;
}
