package kr.co.dongdong.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.dongdong.vo.ClientVO;
import kr.co.dongdong.vo.FacilitiesVO;
import kr.co.dongdong.vo.ToprankVO;

public class FacilitiesDAO {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://db1.c2iguougwqti.ap-northeast-2.rds.amazonaws.com:3306/semidb";
	String user = "admin";
	String password ="apoderado";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();
	
	
	public FacilitiesDAO() {
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
	
	
	// 총 게시물 수
	public int getTotal() {
		sb.setLength(0);
		sb.append("SELECT COUNT(*) cnt FROM facilities");
		int count = -1; // 기본값
			
		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			rs.next();
			count = rs.getInt("cnt");
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}
	
	
	// 종목분류 게시물 수
		public int getTotal(int facevent) {
			sb.setLength(0);
			sb.append("SELECT COUNT(*) cnt FROM facilities ");
			sb.append("where facevent = ?");
			int count = -1; // 기본값
				
			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, facevent);
				rs = pstmt.executeQuery();
				rs.next();
				count = rs.getInt("cnt");
					
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return count;
		}
		
		
		
		// 위치분류 게시물 수
		public int getTotal(String[] faclocArray) {
			int cnt = 0;
			sb.setLength(0);
			sb.append("SELECT COUNT(*) cnt FROM facilities ");
			sb.append("where (");
			for(String facloc : faclocArray) {
				cnt ++;
				sb.append("facaddr like '%"+facloc+"%' ");
				if(cnt<faclocArray.length) {
					sb.append("or ");
				}
			}
			sb.append(")");
			int count = -1; // 기본값
				
			try {
				pstmt = conn.prepareStatement(sb.toString());
				rs = pstmt.executeQuery();
				rs.next();
				count = rs.getInt("cnt");
					
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return count;
		}
		
		
		// 종목,위치 분류 게시물 수
		public int getTotal(int facevent, String[] faclocArray) {
			int cnt = 0;
			sb.setLength(0);
			sb.append("SELECT COUNT(*) cnt FROM facilities ");
			sb.append("where facevent = ? ");
			sb.append("AND ( ");
			for(String facloc : faclocArray) {
				cnt ++;
				sb.append("facaddr like '%"+facloc+"%' ");
				if(cnt<faclocArray.length) {
					sb.append("or ");
				}
			}
			sb.append(")");
			
			int count = -1; // 기본값
				
			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, facevent);
				rs = pstmt.executeQuery();
				rs.next();
				count = rs.getInt("cnt");
					
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return count;
		}
	

		
	// selectAll a-b까지의 게시물 가져오기
	public ArrayList<FacilitiesVO> selectAll(int startNo, int endNo){
		sb.setLength(0);
		sb.append("SELECT ROWNUM, FACNO, FACEVENT, FACNAME, FACADDR, FACMARK, FACPRICE, FACEXPLAIN, FACIMG, FACPARKING, FACSHOWER, FACTYPE, FACREGISTER, CLID ");
		sb.append("FROM (SELECT @ROWNUM := @ROWNUM +1 AS ROWNUM, A.* ");
		sb.append("FROM (SELECT FACNO, FACEVENT, FACNAME, FACADDR, FACMARK, FACPRICE, FACEXPLAIN, FACIMG, FACPARKING, FACSHOWER, FACTYPE, FACREGISTER, CLID ");
		sb.append("FROM facilities ");
		sb.append("ORDER BY FACNO asc)A,(SELECT @ROWNUM :=0 ) TMP)C ");
		sb.append("	WHERE ROWNUM <= ? and ROWNUM>=?");
		ArrayList<FacilitiesVO> list = new ArrayList<FacilitiesVO>();
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, endNo);
			pstmt.setInt(2, startNo);
				
			rs = pstmt.executeQuery();
				
			while(rs.next()) {
				int facno = rs.getInt("facno");
				int facevent = rs.getInt("facevent");
				String facname = rs.getString("facname");
				String facaddr = rs.getString("facaddr");
				double facmark = rs.getDouble("facmark");
				int facprice = rs.getInt("facprice");
				String facexplain = rs.getString("facexplain");
				String facimg = rs.getString("facimg");
				int facparking = rs.getInt("facparking");
				int facshower = rs.getInt("facshower");
				int factype = rs.getInt("factype");
				String facregister = rs.getString("facregister");
				String clid = rs.getString("clid");
					
				FacilitiesVO vo = new FacilitiesVO(facno, facevent, facname, facaddr, facmark, facprice, facexplain, facimg, facparking, facshower, factype, facregister, clid);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
		
		
	// 전체 조회
	public ArrayList<FacilitiesVO> selectAll(){
		ArrayList<FacilitiesVO> list = new ArrayList<FacilitiesVO>();
		sb.setLength(0);
		sb.append("SELECT FACNO, FACEVENT, FACNAME, FACADDR, FACMARK, FACPRICE, FACEXPLAIN, FACIMG, FACPARKING, FACSHOWER, FACTYPE, FACREGISTER, CLID ");
		sb.append("FROM facilities");
		
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int facno = rs.getInt("facno");
				int facevent = rs.getInt("facevent");;
				String facname = rs.getString("facname");
				String facaddr = rs.getString("facaddr");
				double facmark = rs.getDouble("facmark");
				int facprice = rs.getInt("facprice");
				String facexplain = rs.getString("facexplain");
				String facimg = rs.getString("facimg");
				int facparking = rs.getInt("facparking");
				int facshower = rs.getInt("facshower");
				int factype = rs.getInt("factype");
				String facregister = rs.getString("facregister");
				String clid = rs.getString("clid");
				
				FacilitiesVO vo = new FacilitiesVO(facno, facevent, facname, facaddr, facmark, facprice, facexplain, facimg, facparking, facshower, factype, facregister, clid);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	//종목분류로 전체조회
		public ArrayList<FacilitiesVO> eventAll(int facevent){
			ArrayList<FacilitiesVO> list = new ArrayList<FacilitiesVO>();
			sb.setLength(0);
			sb.append("select * from facilities ");
			sb.append("where facevent = ?");
			
			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, facevent);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					int facno = rs.getInt("facno");
					String facname = rs.getString("facname");
					String facaddr = rs.getString("facaddr");
					int facmark = rs.getInt("facmark");
					int facprice = rs.getInt("facprice");
					String facexplain = rs.getString("facexplain");
					String facimg = rs.getString("facimg");
					int facparking = rs.getInt("facparking");
					int facshower = rs.getInt("facshower");
					int factype = rs.getInt("factype");
					String facregister = rs.getString("facregister");
					String clid = rs.getString("clid");
					
					FacilitiesVO vo = new FacilitiesVO(facno, facevent, facname, facaddr, facmark, facprice, facexplain, facimg, facparking, facshower, factype, facregister, clid);
					list.add(vo);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return list;
		}
		
		// eventAll a-b까지의 게시물 가져오기
		public ArrayList<FacilitiesVO> eventAll(int facevent, int startNo, int endNo){
			sb.setLength(0);
			sb.append("SELECT ROWNUM, FACNO, FACEVENT, FACNAME, FACADDR, FACMARK, FACPRICE, FACEXPLAIN, FACIMG, FACPARKING, FACSHOWER, FACTYPE, FACREGISTER, CLID ");
			sb.append("FROM (SELECT @ROWNUM := @ROWNUM +1 AS ROWNUM, A.*");
			sb.append("FROM (SELECT FACNO, FACEVENT, FACNAME, FACADDR, FACMARK, FACPRICE, FACEXPLAIN, FACIMG, FACPARKING, FACSHOWER, FACTYPE, FACREGISTER, CLID ");
			sb.append("FROM facilities ");
			sb.append("WHERE FACEVENT = ? ");
			sb.append("ORDER BY FACNO DESC)A,(SELECT @ROWNUM :=0 ) TMP)C ");
			sb.append("WHERE ROWNUM <= ? and ROWNUM>=?");
			ArrayList<FacilitiesVO> list = new ArrayList<FacilitiesVO>();
			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, facevent);
				pstmt.setInt(2, endNo);
				pstmt.setInt(3, startNo);
					
				rs = pstmt.executeQuery();
					
				while(rs.next()) {
					int facno = rs.getInt("facno");
					String facname = rs.getString("facname");
					String facaddr = rs.getString("facaddr");
					double facmark = rs.getDouble("facmark");
					int facprice = rs.getInt("facprice");
					String facexplain = rs.getString("facexplain");
					String facimg = rs.getString("facimg");
					int facparking = rs.getInt("facparking");
					int facshower = rs.getInt("facshower");
					int factype = rs.getInt("factype");
					String facregister = rs.getString("facregister");
					String clid = rs.getString("clid");
						
					FacilitiesVO vo = new FacilitiesVO(facno, facevent, facname, facaddr, facmark, facprice, facexplain, facimg, facparking, facshower, factype, facregister, clid);
					list.add(vo);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return list;
		}
		
		
		//지역분류로 전체조회
		public ArrayList<FacilitiesVO> locAll(String[] faclocArray){
			ArrayList<FacilitiesVO> list = new ArrayList<FacilitiesVO>();
			int cnt = 0;
			sb.setLength(0);
			sb.append("select * from facilities ");
			sb.append("where ( ");
			for(String facloc : faclocArray) {
				cnt ++;
				sb.append("facaddr like '%"+facloc+"%' ");
				if(cnt<faclocArray.length) {
					sb.append("or ");
				}
			}
			sb.append(")");
			
			try {
				pstmt = conn.prepareStatement(sb.toString());
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					int facno = rs.getInt("facno");
					int facevent = rs.getInt("facevent");
					String facname = rs.getString("facname");
					String facaddr = rs.getString("facaddr");
					int facmark = rs.getInt("facmark");
					int facprice = rs.getInt("facprice");
					String facexplain = rs.getString("facexplain");
					String facimg = rs.getString("facimg");
					int facparking = rs.getInt("facparking");
					int facshower = rs.getInt("facshower");
					int factype = rs.getInt("factype");
					String facregister = rs.getString("facregister");
					String clid = rs.getString("clid");
					
					FacilitiesVO vo = new FacilitiesVO(facno, facevent, facname, facaddr, facmark, facprice, facexplain, facimg, facparking, facshower, factype, facregister, clid);
					list.add(vo);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return list;
		}
		

		// locAll a-b까지의 게시물 가져오기
		public ArrayList<FacilitiesVO> locAll(String[] faclocArray, int startNo, int endNo){
			int cnt = 0;
			sb.setLength(0);
			sb.append("SELECT ROWNUM, FACNO, FACEVENT, FACNAME, FACADDR, FACMARK, FACPRICE, FACEXPLAIN, FACIMG, FACPARKING, FACSHOWER, FACTYPE, FACREGISTER, CLID ");
			sb.append("FROM (SELECT @ROWNUM := @ROWNUM +1 AS ROWNUM, A.* ");
			sb.append("FROM ( SELECT FACNO, FACEVENT, FACNAME, FACADDR, FACMARK, FACPRICE, FACEXPLAIN, FACIMG, FACPARKING, FACSHOWER, FACTYPE, FACREGISTER, CLID ");
			sb.append("FROM facilities ");
			sb.append("where ( ");
			for(String facloc : faclocArray) {
				cnt ++;
				sb.append("facaddr like '%"+facloc+"%' ");
				if(cnt<faclocArray.length) {
					sb.append("or ");
				}
			}
			sb.append(") ");
			sb.append("ORDER BY FACNO DESC)A,(SELECT @ROWNUM :=0 ) TMP)C ");
			sb.append("	WHERE ROWNUM <= ? and ROWNUM>=?");
			ArrayList<FacilitiesVO> list = new ArrayList<FacilitiesVO>();
			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, endNo);
				pstmt.setInt(2, startNo);
							
				rs = pstmt.executeQuery();
							
				while(rs.next()) {
					int facno = rs.getInt("facno");
					int facevent = rs.getInt("facevent");
					String facname = rs.getString("facname");
					String facaddr = rs.getString("facaddr");
					double facmark = rs.getDouble("facmark");
					int facprice = rs.getInt("facprice");
					String facexplain = rs.getString("facexplain");
					String facimg = rs.getString("facimg");
					int facparking = rs.getInt("facparking");
					int facshower = rs.getInt("facshower");
					int factype = rs.getInt("factype");
					String facregister = rs.getString("facregister");
					String clid = rs.getString("clid");
								
					FacilitiesVO vo = new FacilitiesVO(facno, facevent, facname, facaddr, facmark, facprice, facexplain, facimg, facparking, facshower, factype, facregister, clid);
					list.add(vo);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return list;
		}
		
		//지역,종목으로 전체조회
		public ArrayList<FacilitiesVO> elAll(int facevent, String[] faclocArray){
			ArrayList<FacilitiesVO> list = new ArrayList<FacilitiesVO>();
			int cnt = 0;
			sb.setLength(0);
			sb.append("select * from facilities ");
			sb.append("where facevent = ? ");
			sb.append("AND ( ");
			for(String facloc : faclocArray) {
				cnt ++;
				sb.append("facaddr like '%"+facloc+"%' ");
				if(cnt<faclocArray.length) {
					sb.append("or ");
				}
			}
			sb.append(")");
			
			
			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, facevent);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					int facno = rs.getInt("facno");
					String facname = rs.getString("facname");
					String facaddr = rs.getString("facaddr");
					int facmark = rs.getInt("facmark");
					int facprice = rs.getInt("facprice");
					String facexplain = rs.getString("facexplain");
					String facimg = rs.getString("facimg");
					int facparking = rs.getInt("facparking");
					int facshower = rs.getInt("facshower");
					int factype = rs.getInt("factype");
					String facregister = rs.getString("facregister");
					String clid = rs.getString("clid");
					
					FacilitiesVO vo = new FacilitiesVO(facno, facevent, facname, facaddr, facmark, facprice, facexplain, facimg, facparking, facshower, factype, facregister, clid);
					list.add(vo);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return list;
		}
		
		// elAll a-b까지의 게시물 가져오기
	public ArrayList<FacilitiesVO> elAll(int facevent, String[] faclocArray, int startNo, int endNo){
		int cnt = 0;
		sb.setLength(0);
		sb.append("SELECT ROWNUM, FACNO, FACEVENT, FACNAME, FACADDR, FACMARK, FACPRICE, FACEXPLAIN, FACIMG, FACPARKING, FACSHOWER, FACTYPE, FACREGISTER, CLID ");
		sb.append("FROM (SELECT @ROWNUM := @ROWNUM +1 AS ROWNUM, A.* ");
		sb.append("FROM (SELECT FACNO, FACEVENT, FACNAME, FACADDR, FACMARK, FACPRICE, FACEXPLAIN, FACIMG, FACPARKING, FACSHOWER, FACTYPE, FACREGISTER, CLID ");
		sb.append("FROM facilities ");
		sb.append("where facevent = ? ");
		sb.append("AND ( ");
		for(String facloc : faclocArray) {
			cnt ++;
			sb.append("facaddr like '%"+facloc+"%' ");
			if(cnt<faclocArray.length) {
				sb.append("or ");
			}
		}
		sb.append(") ");
		sb.append("ORDER BY FACNO DESC)A,(SELECT @ROWNUM :=0 ) TMP)C ");
		sb.append("WHERE ROWNUM <= ? ROWNUM>=?");
		ArrayList<FacilitiesVO> list = new ArrayList<FacilitiesVO>();
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, facevent);
			pstmt.setInt(2, endNo);
			pstmt.setInt(3, startNo);
									
			rs = pstmt.executeQuery();
									
			while(rs.next()) {
				int facno = rs.getInt("facno");
				String facname = rs.getString("facname");
				String facaddr = rs.getString("facaddr");
				double facmark = rs.getDouble("facmark");
				int facprice = rs.getInt("facprice");
				String facexplain = rs.getString("facexplain");
				String facimg = rs.getString("facimg");
				int facparking = rs.getInt("facparking");
				int facshower = rs.getInt("facshower");
				int factype = rs.getInt("factype");
				String facregister = rs.getString("facregister");
				String clid = rs.getString("clid");
										
				FacilitiesVO vo = new FacilitiesVO(facno, facevent, facname, facaddr, facmark, facprice, facexplain, facimg, facparking, facshower, factype, facregister, clid);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
		
	// 1건 조회
	public FacilitiesVO selectOne(int facno) {
		sb.setLength(0);
		sb.append("SELECT * FROM facilities ");
		sb.append("WHERE facno = ? ");
		FacilitiesVO vo = null;
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, facno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				int facevent = rs.getInt("facevent");;
				String facname = rs.getString("facname");
				String facaddr = rs.getString("facaddr");
				double facmark = rs.getDouble("facmark");
				int facprice = rs.getInt("facprice");
				String facexplain = rs.getString("facexplain");
				String facimg = rs.getString("facimg");
				int facparking = rs.getInt("facparking");
				int facshower = rs.getInt("facshower");
				int factype = rs.getInt("factype");
				String facregister = rs.getString("facregister");
				String clid = rs.getString("clid");
				
				vo = new FacilitiesVO(facno, facevent, facname, facaddr, facmark, facprice, facexplain, facimg, facparking, facshower, factype, facregister, clid);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
	}
	// 1건 조회 (시설등록자와 시설명으로)
	public int selectFacno(String facname, String clid) {
		sb.setLength(0);
		sb.append("SELECT FACNO ");
		sb.append("FROM facilities ");
		sb.append("WHERE FACNAME like ? AND CLID like ?");
		int facno = 0;
			
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, facname);
			pstmt.setString(2, clid);
				
			rs = pstmt.executeQuery();
				
			if(rs.next()) {
				facno = rs.getInt("facno");;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return facno;
	}
	// 추가 (시설 등록)
	public void insertOne(FacilitiesVO vo) {
		sb.setLength(0);
		sb.append("INSERT INTO facilities ");
		sb.append("VALUES (null,?,?,?,?,?,?,?,?,?,?,sysdate(),?)");
		
		if(vo != null) {
			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, vo.getFacevent());
				pstmt.setString(2, vo.getFacname());
				pstmt.setString(3, vo.getFacaddr());
				pstmt.setDouble(4, vo.getFacmark());
				pstmt.setInt(5, vo.getFacprice());
				pstmt.setString(6, vo.getFacexplain());
				pstmt.setString(7, vo.getFacimg());
				pstmt.setInt(8, vo.getFacparking());
				pstmt.setInt(9, vo.getFacshower());
				pstmt.setInt(10, vo.getFactype());
				pstmt.setString(11, vo.getClid());
				
				pstmt.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	// 한사람이 가지고있는 시설들
	public ArrayList<FacilitiesVO> possAll(String clid){
		ArrayList<FacilitiesVO> list = new ArrayList<FacilitiesVO>();
		sb.setLength(0);
		sb.append("SELECT FACNO, FACEVENT, FACADDR, FACMARK, FACPRICE, FACEXPLAIN, ");
		sb.append("FACIMG, FACPARKING, FACSHOWER, FACTYPE, ");
		sb.append("FACREGISTER FROM facilities ");
		sb.append("WHERE CLID = ?");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, clid);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int facno = rs.getInt("facno");
				int facevent = rs.getInt("facevent");
				String facname = rs.getString("facname");
				String facaddr = rs.getString("facaddr");
				double facmark = rs.getDouble("facmark");
				int facprice = rs.getInt("facprice");
				String facexplain = rs.getString("facexplain");
				String facimg = rs.getString("facimg");
				int facparking = rs.getInt("facparking");
				int facshower = rs.getInt("facshower");
				int factype = rs.getInt("factype");
				String facregister = rs.getString("facregister");
				
				FacilitiesVO vo = new FacilitiesVO(facno, facevent, facname, facaddr, facmark, facprice, facexplain, facimg, facparking, facshower, factype, facregister, clid);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
		
	// 검색 결과 조회
	public ArrayList<FacilitiesVO> selectKeyword(String keyword){
		ArrayList<FacilitiesVO> list = new ArrayList<FacilitiesVO>();
		sb.setLength(0);
		sb.append("SELECT * ");
		sb.append("FROM facilities ");
		sb.append("WHERE FACNAME LIKE '%" + keyword + "%'");
		sb.append("OR FACADDR LIKE '%" + keyword + "%'");	
		FacilitiesVO vo = null;
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int facno = rs.getInt("facno");
				int facevent = rs.getInt("facevent");
				String facname = rs.getString("facname");
				String facaddr = rs.getString("facaddr");
				int facmark = rs.getInt("facmark");
				int facprice = rs.getInt("facprice");
				String facexplain = rs.getString("facexplain");
				String facimg = rs.getString("facimg");
				int facparking = rs.getInt("facparking");
				int facshower = rs.getInt("facshower");
				int factype = rs.getInt("factype");
				String facregister = rs.getString("facregister");
				String clid = rs.getString("clid");

				vo = new FacilitiesVO(facno, facevent, facname, facaddr, facmark, facprice, facexplain, facimg, facparking, facshower, factype, facregister, clid);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
		
	}
	
	// 검색 결과 조회 문자열
		public ArrayList<Integer> selectKeywordArr(String[] keyword){
			ArrayList<Integer> list = new ArrayList<Integer>();
			
			sb.setLength(0);
			
			for(int i=0; i < keyword.length; i++) {
				sb.append("SELECT facno ");
				sb.append("FROM facilities ");
				sb.append("WHERE FACNAME LIKE '%" + keyword[i] + "%' ");
				sb.append("OR FACADDR LIKE '%" + keyword[i] + "%' ");	
				
				if(i < keyword.length-1) {
					sb.append("union ");
					
				}
			}

			try {
				pstmt = conn.prepareStatement(sb.toString());
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					int facno = rs.getInt("facno");
					System.out.println(facno);
					
					Integer vo = new Integer(facno);
					list.add(vo);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return list;
		}
		
		// 검색결과 시작 끝 번호
		public ArrayList<Integer> selectKeyword(String[] keyword, int startNo, int endNo){
			ArrayList<Integer> list = new ArrayList<Integer>();
			
			sb.setLength(0);
			sb.append("SELECT ROWNUM, FACNO ");
			sb.append("FROM ( SELECT @ROWNUM := @ROWNUM +1 AS ROWNUM, A.FACNO ");
			sb.append("FROM ( ");
			
			for(int i=0; i < keyword.length; i++) {
				
				sb.append("SELECT FACNO ");
				sb.append("FROM facilities ");
				sb.append("WHERE FACNAME LIKE '%" + keyword[i] + "%' ");
				sb.append("OR FACADDR LIKE '%" + keyword[i] + "%' ");	
				if(i < keyword.length-1) {
					sb.append("union ");
				}
			}
			sb.append(")A,(SELECT @ROWNUM :=0 ) TMP)C WHERE ROWNUM <= ? and ROWNUM>=?");
			
			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, endNo);
				pstmt.setInt(2, startNo);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					int facno = rs.getInt("facno");
					
					System.out.println(facno);
					
					Integer vo = new Integer(facno);
					list.add(vo);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return list;
		}
		
	// 키워드 검색 결과의 총 숫자
	public int selectKeywordTotal(String[] keyword){
		
		sb.setLength(0);
		sb.append("SELECT count(*) cnt from ( ");
		int cnt = -1;
		
		for(int i=0; i < keyword.length; i++) {
			
			sb.append("SELECT FACNO ");
			sb.append("FROM facilities ");
			sb.append("WHERE FACNAME LIKE '%" + keyword[i] + "%' ");
			sb.append("OR FACADDR LIKE '%" + keyword[i] + "%' ");	
		
			
			if(i < keyword.length-1) {
				sb.append("union ");
		
				
			}
		}
		sb.append(" ) ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cnt = rs.getInt("cnt");
				System.out.println("검색결과의 갯수 " + cnt);

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cnt;
	}
		
	
	// 한 주간 예약횟수 상위 시설 출력 == 여기까지
	public ArrayList<ToprankVO> selectToprank(){
		ArrayList<ToprankVO> list = new ArrayList<ToprankVO>();
		
		sb.setLength(0);
		sb.append("select ROWNUM, count, facno, facname,facimg,facmark ");
		sb.append("from (select @ROWNUM := @ROWNUM +1 AS ROWNUM, B.*  ");
		sb.append("from(select A.count, f.facno, f.facname, f.facimg, f.facmark ");
		sb.append("from (select facno, count(facno) count ");
		sb.append("from reserve where orderdate between DATE_ADD(sysdate(), INTERVAL -1 WEEK) and sysdate() group by facno order by count(facno) desc)A, facilities f ");
		sb.append("where A.facno = f.facno)B,(SELECT @ROWNUM :=0 ) TMP)C ");
		sb.append("where ROWNUM <=3 and ROWNUM>=1");
		
		ToprankVO vo;
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int rownum = rs.getInt("rownum");
				int count = rs.getInt("count");
				int facno = rs.getInt("facno");
				String facname = rs.getString("facname");
				String facimg = rs.getString("facimg");
				double facmark = rs.getDouble("facmark");
				
				vo = new ToprankVO(rownum, count, facno, facname, facimg, facmark);
				list.add(vo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;	
	}
	// 삭제
	public void deleteOne(int facno) {
		sb.setLength(0);
		sb.append("DELETE FROM facilities ");
		sb.append("WHERE facno = ?");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, facno);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	// 삭제
	public void updateAvg(double average, int facno) {
		sb.setLength(0);
		sb.append("UPDATE facilities ");
		sb.append("SET facmark = ? ");
		sb.append("WHERE facno = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setDouble(1, average);
			pstmt.setInt(2, facno);
			
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
