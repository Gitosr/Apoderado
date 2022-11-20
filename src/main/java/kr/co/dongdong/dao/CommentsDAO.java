package kr.co.dongdong.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.dongdong.vo.CommentsVO;

public class CommentsDAO {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "apoderado";
	String password = "tiger";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();

	public CommentsDAO() {

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
	public ArrayList<CommentsVO> selectAll() {
		ArrayList<CommentsVO> list = new ArrayList<CommentsVO>();
		sb.setLength(0);
		sb.append("select clistno, comno, clid, comscontents,comsdate from comments order by comsdate asc");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {

				int clistno = rs.getInt("clistno");
				int comno = rs.getInt("comno");
				String clid = rs.getString("clid");
				String comscontents = rs.getString("comscontents");
				String comsdate = rs.getString("comsdate");
				
				CommentsVO vo = new CommentsVO(clistno, comno, clid, comscontents,comsdate);
				list.add(vo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 전체조회 수정. 한페이지당 글 10개씩 조회하게 
	public ArrayList<CommentsVO> selectAll(int startNo, int endNo) {
		ArrayList<CommentsVO> list = new ArrayList<CommentsVO>();
		sb.setLength(0);
		
		
		sb.append("select rn, clistno, comno, clid, comscontents,comsdate "); 
		sb.append("from (select rownum rn, clistno, comno, clid, comscontents,comsdate "); 
		sb.append("from (select clistno, comno, clid, comscontents,comsdate from comments order by comsdate desc) "); 
		sb.append("where rownum<=?) where rn>=? ");
		 

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, endNo);
			pstmt.setInt(2, startNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				int clistno = rs.getInt("clistno");
				int comno = rs.getInt("comno");
				String clid = rs.getString("clid");
				String comscontents = rs.getString("comscontents");
				String comsdate = rs.getString("comsdate");
				
				CommentsVO vo = new CommentsVO(clistno, comno, clid, comscontents,comsdate);
				list.add(vo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
		
	// 같은 상세페이지 댓글들 조회 : selectOne()
	public ArrayList<CommentsVO> selectOne(int comno) {
		ArrayList<CommentsVO> list = new ArrayList<CommentsVO>();
		
		sb.setLength(0);
		sb.append("select clistno, comno, clid, comscontents,comsdate ");
		sb.append("from comments ");
		sb.append("where comno = ? order by clistno desc");
		

		CommentsVO vo = null;

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, comno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int clistno = rs.getInt("clistno");
				String clid = rs.getString("clid");
				String comscontents = rs.getString("comscontents");
				String comsdate = rs.getString("comsdate");
				
				vo = new CommentsVO(clistno,comno, clid, comscontents,comsdate);
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
		sb.append("from comments");
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


	// 1건 추가
	public void insertOne(CommentsVO vo) {

		sb.setLength(0);
		sb.append("insert into comments ");
		sb.append("values (comments_clistno_seq.nextval,?,?,?,sysdate)");
		// 등록날짜는 오늘날짜, 처음 조회수는 0. 처음 글 상태는 정상으로 1.


		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setInt(1, vo.getComno());
			pstmt.setString(2, vo.getClid());
			pstmt.setString(3, vo.getComscontents());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	// 댓글수정
	public void updateOne(CommentsVO vo) {
		sb.setLength(0);
		sb.append("update comments ");
		sb.append("set comscontents = ? ");
		sb.append("where clistno = ?");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, vo.getComscontents());
			pstmt.setInt(2, vo.getClistno());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 삭제
	public void deleteOne(int clistno) {
		sb.setLength(0);
		sb.append("delete from comments ");
		sb.append("where clistno = ?");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, clistno);
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


