package kr.co.dongdong.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import kr.co.dongdong.vo.FacilitiesVO;
import kr.co.dongdong.vo.NoticeVO;



public class NoticeDAO {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://db1.c2iguougwqti.ap-northeast-2.rds.amazonaws.com:3306/semidb";
	String user = "admin";
	String password ="apoderado";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();

	public NoticeDAO() {

		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("conn : " + conn);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패");
		} catch (SQLException e) {
			System.out.println("DB 연결 실패");
			e.printStackTrace();
		}
	}

	// 전체조회
	public ArrayList<NoticeVO> selectAll() {
		ArrayList<NoticeVO> list = new ArrayList<NoticeVO>();
		sb.setLength(0);
		sb.append("Select notno, clid, clrank, facno, nottitle, notcontents, notdate,nothits ");
		sb.append("from notice order by notdate desc");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {

				int notno = rs.getInt("notno");
				String clid = rs.getString("clid");
				int clrank = rs.getInt("clrank");
				int facno = rs.getInt("facno");
				String nottitle = rs.getString("nottitle");
				String notcontents = rs.getString("notcontents");
				String notdate = rs.getString("notdate");
				int nothits = rs.getInt("nothits");
				
				NoticeVO vo = new NoticeVO(notno, clid, clrank, facno, nottitle, notcontents, notdate,nothits);
				list.add(vo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 전체조회 수정. 한페이지당 글 10개씩 조회하게 
	public ArrayList<NoticeVO> selectAll(int startNo, int endNo) {
		ArrayList<NoticeVO> list = new ArrayList<NoticeVO>();
		sb.setLength(0);
		
		sb.append("select rownum, notno, clid, clrank, facno, nottitle, notcontents, notdate,nothits ");
		sb.append("from (select  @ROWNUM := @ROWNUM +1 AS ROWNUM, A.* ");
		sb.append("from (select notno, clid, clrank, facno, nottitle, notcontents, notdate,nothits ");
		sb.append("from notice order by notdate desc)A,(SELECT @ROWNUM :=0 ) TMP)C ");
		sb.append("where rownum<=? and rownum>=?");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, endNo);
			pstmt.setInt(2, startNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				int notno = rs.getInt("notno");
				String clid = rs.getString("clid");
				int clrank = rs.getInt("clrank");
				int facno = rs.getInt("facno");
				String nottitle = rs.getString("nottitle");
				String notcontents = rs.getString("notcontents");
				String notdate = rs.getString("notdate");
				int nothits = rs.getInt("nothits");
				
				NoticeVO vo = new NoticeVO(notno, clid, clrank,facno, nottitle, notcontents, notdate,nothits);
				list.add(vo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}


	// 총 게시물 수
	public int getTotal() {

		sb.setLength(0);
		sb.append("select count(*) cnt ");
		sb.append("from notice");
		int count = -1; 

		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();

			rs.next();
			count = rs.getInt("cnt");

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;

	};
	

	// 1건 조회 : selectOne()
	public NoticeVO selectOne(int notno) {

		sb.setLength(0);
		sb.append("select notno, clid, clrank,facno, nottitle, notcontents, notdate,nothits ");
		sb.append("from notice ");
		sb.append("where notno = ?");

		NoticeVO vo = null;

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, notno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				String clid = rs.getString("clid");
				int clrank = rs.getInt("clrank");
				int facno = rs.getInt("facno");
				String nottitle = rs.getString("nottitle");
				String notcontents = rs.getString("notcontents");
				String notdate = rs.getString("notdate");
				int nothits = rs.getInt("nothits");
				
				vo = new NoticeVO(notno, clid, clrank,facno, nottitle, notcontents, notdate,nothits);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	//글 쓸때 아이디로 내가 등록한 시설번호들 가져오기
	public ArrayList<Integer> selectAll(String clid) {
		ArrayList<Integer> list = new ArrayList<Integer>();
		sb.setLength(0);
		
		sb.append("select facno ");
		sb.append("from facilities ");
		sb.append("where clid =?");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, clid);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				int facno = rs.getInt("facno");
				
				list.add(facno);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//시설번호로  시설명 가져오기
		public String selectFacname(int facno) {
			sb.setLength(0);
			
			sb.append("select facname ");
			sb.append("from facilities ");
			sb.append("where facno =?");
			String facname ="";
			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, facno);
				rs = pstmt.executeQuery();

				while(rs.next()) {
					facname = rs.getString("facname");
					
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}
			return facname;
		}
	
	
	// 특정 시설번호에 대한 공지글들 모으기 
	public ArrayList<NoticeVO> selectReview(int facno) {
		ArrayList<NoticeVO> list = new ArrayList<NoticeVO>();
		sb.setLength(0);
		sb.append("select notno, clid, clrank,facno, nottitle, notcontents, notdate,nothits ");
		sb.append("from notice ");
		sb.append("where facno =?");
		

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, facno);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int notno = rs.getInt("notno");
				String clid = rs.getString("clid");
				int clrank = rs.getInt("clrank");
				String nottitle = rs.getString("nottitle");
				String notcontents = rs.getString("notcontents");
				String notdate = rs.getString("notdate");
				int nothits = rs.getInt("nothits");
				
				NoticeVO vo = new NoticeVO(notno, clid, clrank,facno, nottitle, notcontents, notdate,nothits);
				
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 특정 아이디가 작성한 공지들 모으기 
	public ArrayList<NoticeVO> selectReview(String clid) {
		ArrayList<NoticeVO> list = new ArrayList<NoticeVO>();
		sb.setLength(0);
		sb.append("select notno, clid, clrank,facno, nottitle, notcontents, notdate,nothits ");
		sb.append("from notice ");
		sb.append("where clid = ? ");
		

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, clid);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int notno = rs.getInt("notno");
				int clrank = rs.getInt("clrank");
				int facno = rs.getInt("facno");
				String nottitle = rs.getString("nottitle");
				String notcontents = rs.getString("notcontents");
				String notdate = rs.getString("notdate");
				int nothits = rs.getInt("nothits");
				
				NoticeVO vo = new NoticeVO(notno, clid, clrank,facno, nottitle, notcontents, notdate,nothits);
				
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 특정 시설번호에 대한 공지들 모으기 10개씩 보여주기
	public ArrayList<NoticeVO> selectReview(int facno, int startNo, int endNo) {
		ArrayList<NoticeVO> list = new ArrayList<NoticeVO>();
		sb.setLength(0);
		
		sb.append("select ROWNUM, notno, clid, clrank,facno, nottitle, notcontents, notdate,nothits ");
		sb.append("from (select @ROWNUM := @ROWNUM +1 AS ROWNUM, A.* ");
		sb.append("from (select notno, clid, clrank,facno, nottitle, notcontents, notdate,nothits ");
		sb.append("from notice ");
		sb.append("where facno = ? ");
		sb.append("ORDER BY notdate DESC)A,(SELECT @ROWNUM :=0 ) TMP)C ");
		sb.append("WHERE ROWNUM <=? and ROWNUM>=?");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, facno);
			pstmt.setInt(2, endNo);
			pstmt.setInt(3, startNo);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int notno = rs.getInt("notno");
				String clid = rs.getString("clid");
				int clrank = rs.getInt("clrank");
				String nottitle = rs.getString("nottitle");
				String notcontents = rs.getString("notcontents");
				String notdate = rs.getString("notdate");
				int nothits = rs.getInt("nothits");
				
				NoticeVO vo = new NoticeVO(notno, clid, clrank,facno, nottitle, notcontents, notdate,nothits);
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//제목이나 시설명으로 검색
	public ArrayList<NoticeVO> searchRev(String x) {
		ArrayList<NoticeVO> list = new ArrayList<NoticeVO>();
		sb.setLength(0);
		sb.append("select notno, clid, clrank,facno, nottitle, notcontents, notdate,nothits ");
		sb.append("from notice ");
		sb.append("where nottitle like '%"+x+"%' ");
		sb.append("or facno in (select facno from facilities ");
		sb.append("where facname like '%"+x+"%')");
		
		
		
		try {
			
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			
			while (rs.next()) {

				int notno = rs.getInt("notno");
				String clid = rs.getString("clid");
				int clrank = rs.getInt("clrank");
				int facno = rs.getInt("facno");
				String nottitle = rs.getString("nottitle");
				String notcontents = rs.getString("notcontents");
				String notdate = rs.getString("notdate");
				int nothits = rs.getInt("nothits");
				
				NoticeVO vo = new NoticeVO(notno, clid, clrank,facno, nottitle, notcontents, notdate,nothits);
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//조회수 1 증가
		public void raiseHits(int notno) {
			sb.setLength(0);
			sb.append("update notice ");
			sb.append("set nothits=nothits+1 ");
			sb.append("where notno = ?");

			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, notno);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}

	// 1건 추가
	public void insertOne(NoticeVO vo) {

		sb.setLength(0);
		sb.append("insert into notice ");
		sb.append("values (null,?,?,?,?,?,sysdate(),0)");
		// 등록날짜는 오늘날짜, 처음 조회수는 0. 처음 글 상태는 정상으로 1.
		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setString(1, vo.getClid());
			pstmt.setInt(2, vo.getClrank());
			pstmt.setInt(3, vo.getFacno());
			pstmt.setString(4, vo.getNottitle());
			pstmt.setString(5, vo.getNotcontents());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	// 변경
	public void updateOne(NoticeVO vo) {
		sb.setLength(0);
		sb.append("update notice ");
		sb.append("set facno = ? ,");
		sb.append("nottitle = ? ,");
		sb.append("notcontents = ? ");
		sb.append("where notno = ?");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, vo.getFacno());
			pstmt.setString(2, vo.getNottitle());
			pstmt.setString(3, vo.getNotcontents());
			pstmt.setInt(4, vo.getNotno());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 삭제
	public void deleteOne(int notno) {
		sb.setLength(0);
		sb.append("delete from notice ");
		sb.append("where notno = ?");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, notno);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 자원반납
	public void close() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

}
