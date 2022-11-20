package kr.co.dongdong.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.dongdong.vo.ClientVO;
import kr.co.dongdong.vo.ReserveVO;

public class ReserveDAO {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "apoderado";
	String password = "tiger";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();
	
	public ReserveDAO() {
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
	
	// 아이디당 예약 총 횟수
	public int getTotal(String id) {
		sb.setLength(0);
		sb.append("SELECT COUNT(*) resno FROM reserve WHERE clid = ? ");
		int count = -1; // 기본값
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("resno");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count;
	}
	
	// 시설번호의 각 해당 날짜의 예약의 수
	public int getFacilitiesTotal(int facno, String resdate) {
		sb.setLength(0);
		sb.append("SELECT COUNT(*) resno FROM reserve WHERE facno = ? AND resdate = ? ");
		int count = -1; // 기본값
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, facno);
			pstmt.setString(2, resdate);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("resno");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count;
	}
	
	// 전체 조회
	public ArrayList<ReserveVO> selectAll(String id, int startNo, int endNo){
		ArrayList<ReserveVO> list = new ArrayList<ReserveVO>();
		sb.setLength(0);
		sb.append("SELECT resno, facno, restime, resdate, orderdate, resstate ");
		sb.append("FROM ( SELECT ROWNUM RN, resno, facno, restime, resdate, orderdate, resstate  ");
		sb.append("	FROM ( SELECT resno, facno, restime, resdate, orderdate, resstate  ");
		sb.append("		FROM reserve WHERE clid = ? ");
		sb.append("		ORDER BY resno DESC ) ");
		sb.append("	WHERE ROWNUM <= ?) ");
		sb.append("WHERE RN >= ? ");
		
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, id);
			pstmt.setInt(2, endNo);
			pstmt.setInt(3, startNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int resno = rs.getInt("resno");
				int facno = rs.getInt("facno");
				int restime = rs.getInt("restime");
				String resdate = rs.getString("resdate");
				String orderdate = rs.getString("orderdate");
				int resstate = rs.getInt("resstate");
				
				ReserveVO vo = new ReserveVO(resno, id, facno, restime, resdate, orderdate, resstate);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
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
