package kr.co.dongdong.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.dongdong.vo.CommunityVO;

public class CommunityDAO {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "apoderado";
	String password = "tiger";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();

	public CommunityDAO() {

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
	public ArrayList<CommunityVO> selectAll() {
		ArrayList<CommunityVO> list = new ArrayList<CommunityVO>();
		sb.setLength(0);
		sb.append("Select comno, clid, comtitle, comfield, comdate, hits ");
		sb.append("from community");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {

				int comno = rs.getInt("comno");
				String clid = rs.getString("clid");
				String comtitle = rs.getString("comtitle");
				String comfield = rs.getString("comfield");
				String comdate = rs.getString("comdate");
				int hits = rs.getInt("hits");
				
				CommunityVO vo = new CommunityVO(comno, clid, comtitle, comfield, comdate, hits);
				list.add(vo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 전체조회 수정. 한페이지당 글 10개씩 조회하게 
	public ArrayList<CommunityVO> selectAll(int startNo, int endNo) {
		ArrayList<CommunityVO> list = new ArrayList<CommunityVO>();
		sb.setLength(0);
		
		sb.append("select rn, comno, clid, comtitle, comfield, comdate, hits ");
		sb.append("from (select rownum rn, comno, clid, comtitle, comfield, comdate, hits ");
		sb.append("from (select comno, clid, comtitle, comfield, comdate, hits from community order by comno desc) ");
		sb.append("where rownum<=?) where rn>=? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, endNo);
			pstmt.setInt(2, startNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				int comno = rs.getInt("comno");
				String clid = rs.getString("clid");
				String comtitle = rs.getString("comtitle");
				String comfield = rs.getString("comfield");
				String comdate = rs.getString("comdate");
				int hits = rs.getInt("hits");

				CommunityVO vo = new CommunityVO(comno, clid, comtitle, comfield, comdate, hits);
				list.add(vo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	//조회수 1 증가
	public void raiseHits(int comno) {
		sb.setLength(0);
		sb.append("update community ");
		sb.append("set hits=hits+1 ");
		sb.append("where comno = ?");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, comno);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	// 총 게시물 수
	public int getTotal() {

		sb.setLength(0);
		sb.append("select count(*) cnt ");
		sb.append("from community");
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
	public CommunityVO selectOne(int comno) {

		sb.setLength(0);
		sb.append("Select comno, clid, comtitle, comfield, comdate, hits ");
		sb.append("from community ");
		sb.append("where comno = ?");

		CommunityVO vo = null;

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, comno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				String clid = rs.getString("clid");
				String comtitle = rs.getString("comtitle");
				String comfield = rs.getString("comfield");
				String comdate = rs.getString("comdate");
				int hits = rs.getInt("hits");
				
				 vo = new CommunityVO(comno, clid, comtitle, comfield, comdate, hits);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}

	// 1건 추가
	public void insertOne(CommunityVO vo) {

		sb.setLength(0);
		sb.append("insert into community ");
		sb.append("values ( community_comno_seq.nextval,?,?,?,sysdate,?)");
		// 등록날짜는 오늘날짜, 처음 조회수는 0, 처음 글 상태는 정상으로 1.


		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setString(1, vo.getClid());
			pstmt.setString(2, vo.getComtitle());
			pstmt.setString(3, vo.getComfield());
			pstmt.setInt(4, vo.getHits());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	// 변경
	public void updateOne(CommunityVO vo) {
		sb.setLength(0);
		sb.append("update community ");
		sb.append("set clid = ? ,");
		sb.append("comtitle = ? ,");
		sb.append("comfield = ?, ");
		sb.append("comdate = sysdate ");
		// 수정된 날짜, 시간으로 변경
		sb.append("where comno = ?");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, vo.getClid());
			pstmt.setString(2, vo.getComtitle());
			pstmt.setString(3, vo.getComfield());
			pstmt.setInt(4, vo.getComno());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 삭제
	public void deleteOne(int comno) {
		sb.setLength(0);
		sb.append("delete from community ");
		sb.append("where comno = ?");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, comno);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

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
