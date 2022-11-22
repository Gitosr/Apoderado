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
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "apoderado";
	String password = "tiger";
	
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
	
	// 전체 조회
	public ArrayList<FacilitiesVO> selectAll(){
		ArrayList<FacilitiesVO> list = new ArrayList<FacilitiesVO>();
		sb.setLength(0);
		sb.append("SELECT * FROM facilities ");
		
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
				System.out.println(sb);
				System.out.println(faclocArray.length);
				System.out.println(cnt);
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
	
	// 추가 (시설 등록)
	public void insertOne(FacilitiesVO vo) {
		sb.setLength(0);
		sb.append("INSERT INTO facilities ");
		sb.append("VALUES (facilities_facno_SEQ.NEXTVAL,?,?,?,?,?,?,?,?,?,?,sysdate,?)");
		
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
		sb.append("WHERE CLID = ? ");
		
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
		sb.append("FROM FACILITIES ");
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
	
	// 한 주간 예약횟수 상위 시설 출력 == 여기까지
	public ArrayList<ToprankVO> selectToprank(){
		ArrayList<ToprankVO> list = new ArrayList<ToprankVO>();
		
		sb.setLength(0);
		sb.append("select rownum, r.count, f.facno, f.facname, f.facimg, f.facmark ");
		sb.append("from (select facno, count(facno) count from reserve ");
		sb.append("where orderdate between sysdate-7 and sysdate ");
		sb.append("group by facno order by count(facno) desc) r, facilities f ");
		sb.append("where r.facno = f.facno ");
		sb.append("and rownum between 1 and 3");
		
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
