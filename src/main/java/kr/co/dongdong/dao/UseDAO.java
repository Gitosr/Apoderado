package kr.co.dongdong.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.dongdong.vo.ClientVO;
import kr.co.dongdong.vo.UseVO;

	public class UseDAO {
//		String driver = "com.mysql.cj.jdbc.Driver";
//		String url = "jdbc:mysql://db1.ceujsugmrik1.ap-northeast-2.rds.amazonaws.com:3306/semidb";
//		String user = "admin";
//		String password ="oracletiger";
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String user = "apoderado";
		String password = "tiger";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		
	public UseDAO() {
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
	
	// 시설번호의 총 예약 횟수
	public int getTotal(int facno) {
		sb.setLength(0);
		sb.append("SELECT COUNT(*) useorder FROM use WHERE facno = ? ");
		int count = -1; // 기본값
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, facno);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("useorder");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count;
	}
	
	public UseVO selecttime(int facno,int useorder) {
		sb.setLength(0);
		sb.append("SELECT * FROM use u , facilities f ");
		sb.append("WHERE f.facno = u.facno ");
		sb.append("AND f.facno = ? ");
		sb.append("AND useorder = ?");
		
		UseVO vo = null;
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, facno);
			pstmt.setInt(2, useorder);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String usetime = rs.getString("usetime");
				
				vo = new UseVO(facno, useorder, usetime);
						
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
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
