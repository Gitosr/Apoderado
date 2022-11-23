package kr.co.dongdong.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ClientVO {
	String clid;
	String clname;
	String clpw;
	String clmail;
	String clcardno;
	int clgender;
	String clbirth;
	String clmp;
	String cldate;
	int clrank;
}