package kr.co.dongdong.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.dongdong.vo.InterestsVO;

public class InterestsDAO {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "apoderado";
	String password = "tiger";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();
	
	public InterestsDAO() {
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
	
	// 찜 목록에 중복값이 존재하는지 조회
	public int isExists(String clid, int facno) {
		int totalcnt = 0;
		sb.setLength(0);
		sb.append("SELECT COUNT(*) ");
		sb.append("FROM INTERESTS ");
		sb.append("WHERE CLID = ? ");
		sb.append("AND FACNO = ?");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, clid);
			pstmt.setInt(2, facno);
			
			rs = pstmt.executeQuery();
			rs.next();
			totalcnt = rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return totalcnt;	
	}
	
	// 1건 추가
	public void InsertOne(String clid, int facno) {
		sb.setLength(0);
		sb.append("INSERT INTO INTERESTS ");
		sb.append("VALUES (?, ?, SYSDATE)");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, clid);
			pstmt.setInt(2, facno);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// 1건 삭제
	public void deleteOne(String clid, int facno) {
		sb.setLength(0);
		sb.append("DELETE FROM INTERESTS ");
		sb.append("WHERE CLID = ? ");
		sb.append("AND FACNO = ?");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, clid);
			pstmt.setInt(2, facno);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// 아이디당 관심목록 총 횟수
	public int getTotal(String id) {
		sb.setLength(0);
		sb.append("SELECT COUNT(*) facno FROM interests WHERE clid = ? ");
		int count = -1; // 기본값
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("facno");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count;
	}
	
	// 전체 조회
	public ArrayList<InterestsVO> selectAll(String id, int startNo, int endNo){
		ArrayList<InterestsVO> list = new ArrayList<InterestsVO>();
		sb.setLength(0);
		sb.append("SELECT clid, facno, intdate ");
		sb.append("FROM ( SELECT ROWNUM RN, clid, facno, intdate  ");
		sb.append("	FROM ( SELECT clid, facno, intdate  ");
		sb.append("		FROM interests WHERE clid = ? ");
		sb.append("		ORDER BY intdate DESC ) ");
		sb.append("	WHERE ROWNUM <= ?) ");
		sb.append("WHERE RN >= ? ");
		
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, id);
			pstmt.setInt(2, endNo);
			pstmt.setInt(3, startNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String clid = rs.getString("clid");
				int facno = rs.getInt("facno");
				String intdate = rs.getString("intdate");

				InterestsVO vo = new InterestsVO(clid, facno, intdate);
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
