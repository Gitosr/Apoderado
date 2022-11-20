package kr.co.dongdong.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.cj.protocol.Resultset;

import kr.co.dongdong.vo.ClientVO;


public class ClientDAO {
//	String driver = "com.mysql.cj.jdbc.Driver";
//	String url = "jdbc:mysql://db1.ceujsugmrik1.ap-northeast-2.rds.amazonaws.com:3306/semidb";
//	String user = "admin";
//	String password ="oracletiger";
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "apoderado";
	String password = "tiger";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();
	
	public ClientDAO() {
		try {
			Class.forName(driver);
			
			conn = DriverManager.getConnection(url, user, password);
			
			System.out.println("conn" + conn);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// 전체 조회
	public ArrayList<ClientVO> selectAll(){
		ArrayList<ClientVO> list = new ArrayList<ClientVO>();
		sb.setLength(0);
		sb.append("SELECT CLID,CLNAME,CLPW,CLMAIL,CLCARDNO,CLGENDER, ");
		sb.append("CLBIRTH, CLMP, CLDATE, CLRANK FROM client");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String clid = rs.getString("clid");
				String clname = rs.getString("clname");
				String clpw = rs.getString("clpw");
				String clmail = rs.getString("clmail");
				String clcardno = rs.getString("clcardno");
				int clgender = rs.getInt("clgender");
				String clbirth = rs.getString("clbirth");
				String clmp = rs.getString("clmp");
				String cldate = rs.getString("cldate");
				int clrank = rs.getInt("clrank");
				
				ClientVO vo = new ClientVO(clid, clname, clpw, clmail, clcardno, clgender, clbirth, clmp, cldate, clrank);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	// 로그인 체크
	public ClientVO loginOk(String clid,String clpw) {
		sb.setLength(0);
		sb.append("SELECT CLID,CLNAME,CLPW,CLMAIL,CLCARDNO,CLGENDER, ");
		sb.append("CLBIRTH, CLMP, CLDATE, CLRANK FROM client ");
		sb.append("WHERE CLID = ? ");
		sb.append("AND CLPW = ?");
		ClientVO vo = null;
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, clid);
			pstmt.setString(2, clpw);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String clname = rs.getString("clname");
				String clmail = rs.getString("clmail");
				String clcardno = rs.getString("clcardno");
				int clgender = rs.getInt("clgender");
				String clbirth = rs.getString("clbirth");
				String clmp = rs.getString("clmp");
				String cldate = rs.getString("cldate");
				int clrank = rs.getInt("clrank");
				
				vo = new ClientVO(clid, clname, clpw, clmail, clcardno, clgender, clbirth, clmp, cldate, clrank);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
	}
	
	
	// 아이디 1건 조회
	public ClientVO selectOne(String clid) {
		sb.setLength(0);
		sb.append("SELECT CLID,CLNAME,CLPW,CLMAIL,CLCARDNO,CLGENDER, ");
		sb.append("CLBIRTH, CLMP, CLDATE, CLRANK FROM client ");
		sb.append("WHERE CLID = ?");
		ClientVO vo = null;
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, clid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String clname = rs.getString("clname");
				String clpw = rs.getString("clpw");
				String clmail = rs.getString("clmail");
				String clcardno = rs.getString("clcardno");
				int clgender = rs.getInt("clgender");
				String clbirth = rs.getString("clbirth");
				String clmp = rs.getString("clmp");
				String cldate = rs.getString("cldate");
				int clrank = rs.getInt("clrank");
				
				vo = new ClientVO(clid, clname, clpw, clmail, clcardno, clgender, clbirth, clmp, cldate, clrank);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
	}
	
	// 회원가입 추가
	public void insertOne(ClientVO vo) {
		sb.setLength(0);
		sb.append("INSERT INTO client ");
		sb.append("VALUES (?,?,?,?,?,?,?,?,sysdate,?)");
		
		if(vo != null) {
			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setString(1, vo.getClid());
				pstmt.setString(2, vo.getClname());
				pstmt.setString(3, vo.getClpw());
				pstmt.setString(4, vo.getClmail());
				pstmt.setString(5, vo.getClcardno());
				pstmt.setInt(6, vo.getClgender()); 
				pstmt.setString(7, vo.getClbirth());
				pstmt.setString(8, vo.getClmp());
				pstmt.setInt(9, vo.getClrank());
				
				pstmt.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	// 회원정보 변경
	public void updateOne(ClientVO vo) {
		sb.setLength(0);
		sb.append("UPDATE client ");
		sb.append("SET clname = ?, clpw = ?, clmail = ?, clcardno = ?, clgender = ?, clbirth = ?, clmp = ? ");
		sb.append("WHERE clid = ? ");
		
		if(vo != null) {
			try {
				pstmt = conn.prepareStatement(sb.toString());
				
				pstmt.setString(1, vo.getClname());
				pstmt.setString(2, vo.getClpw());
				pstmt.setString(3, vo.getClmail());
				pstmt.setString(4, vo.getClcardno());
				pstmt.setInt(5, vo.getClgender()); 
				pstmt.setString(6, vo.getClbirth());
				pstmt.setString(7, vo.getClmp());
				pstmt.setString(8, vo.getClid());
				
				pstmt.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	// 변경 (등급) -- 관리자로 업그레이드
	public void modifyOne(String clid) {
		sb.setLength(0);
		sb.append("UPDATE client ");
		sb.append("SET CLRANK = 2 ");
		sb.append("WHERE ClID = ?");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, clid);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	 
	// 삭제
	public void deleteOne(String clid) {
		sb.setLength(0);
		sb.append("DELETE FROM client ");
		sb.append("WHERE clid = ?");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, clid);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// 자원반납
	public void close() {
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}	

}

