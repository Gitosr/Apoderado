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
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://db1.c2iguougwqti.ap-northeast-2.rds.amazonaws.com:3306/semidb";
	String user = "admin";
	String password ="apoderado";
	
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

	
	// 예약번호로 시설번호 가져오기
	public int getFacno(int resno) {
		sb.setLength(0);
		sb.append("select facno from reserve where resno = ? ");
		int facno = -1; // 기본값
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, resno);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				facno = rs.getInt("facno");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return facno;
	}
	
	//전체조회
	public ArrayList<ReserveVO> selectAll(){
		ArrayList<ReserveVO> list = new ArrayList<ReserveVO>();
		sb.setLength(0);
		sb.append("SELECT RESNO, CLID, FACNO, RESTIME, RESDATE, ORDERDATE, RESSTATE ");
		sb.append("FROM reserve");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int resno = rs.getInt("resno");
				String clid = rs.getString("clid");
				int facno = rs.getInt("facno");
				int restime = rs.getInt("restime");
				String resdate = rs.getString("resdate");
				String orderdate = rs.getString("orderdate");
				int resstate = rs.getInt("resstate");
				
				ReserveVO vo = new ReserveVO(resno, clid, facno, restime, resdate, orderdate, resstate);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
		
	// 전체 조회
	public ArrayList<ReserveVO> selectAll(String id, int startNo, int endNo){
		ArrayList<ReserveVO> list = new ArrayList<ReserveVO>();
		sb.setLength(0);
		sb.append("SELECT ROWNUM, resno, facno, restime, resdate, orderdate, resstate from ");
		sb.append("(SELECT @ROWNUM := @ROWNUM +1 AS ROWNUM, A.* ");
		sb.append("FROM (SELECT resno, facno, restime, resdate, orderdate, resstate "); 
		sb.append("FROM reserve WHERE clid = ? ");
		sb.append("ORDER BY resno DESC)A,(SELECT @ROWNUM :=0 ) TMP)B ");
		sb.append("where ROWNUM <=? and ROWNUM>=?");
		
		
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
	
	// 추가
	public void insertOne(ReserveVO vo) {
		sb.setLength(0);
		sb.append("INSERT INTO reserve ");
		sb.append("VALUES (null,?,?,?,?,sysdate(),0)");
		
		if(vo != null) {
			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setString(1, vo.getClid());
				pstmt.setInt(2, vo.getFacno());
				pstmt.setInt(3, vo.getRestime());
				pstmt.setString(4, vo.getResdate());
				
				pstmt.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
		
		//상태 변경 (등급 0으로)
		public void modifyOne(int resno) {
			sb.setLength(0);
			sb.append("UPDATE reserve ");
			sb.append("SET RESSTATE = 0 ");
			sb.append("WHERE resno = ?");
			
			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, resno);
				
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
