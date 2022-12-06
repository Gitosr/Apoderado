package kr.co.dongdong.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import kr.co.dongdong.vo.ReviewVO;


public class ReviewDAO {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://db1.c2iguougwqti.ap-northeast-2.rds.amazonaws.com:3306/semidb";
	String user = "admin";
	String password ="apoderado";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();

	public ReviewDAO() {

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
	public ArrayList<ReviewVO> selectAll() {
		ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();
		sb.setLength(0);
		sb.append("Select revno, revtitle, revcontents, revdate, revscore, resno ");
		sb.append("from review order by revdate desc");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {

				int revno = rs.getInt("revno");
				String revtitle = rs.getString("revtitle");
				String revcontents = rs.getString("revcontents");
				String revdate = rs.getString("revdate");
				int revscore = rs.getInt("revscore");
				int resno = rs.getInt("resno");
				
				ReviewVO vo = new ReviewVO(revno, revtitle, revcontents, revdate, revscore, resno);
				list.add(vo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 전체조회 수정. 한페이지당 글 10개씩 조회하게 
	public ArrayList<ReviewVO> selectAll(int startNo, int endNo) {
		ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();
		sb.setLength(0);
		
		sb.append("select rownum, revno, revtitle, revcontents, revdate, revscore, resno ");
		sb.append("from (select @ROWNUM := @ROWNUM +1 AS ROWNUM, A.* ");
		sb.append("from (select revno, revtitle, revcontents, revdate, revscore, resno ");
		sb.append("from review order by revno desc)A,(SELECT @ROWNUM :=0 ) TMP)C ");
		sb.append("where rownum<=? where rownum>=? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, endNo);
			pstmt.setInt(2, startNo);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				int revno = rs.getInt("revno");
				String revtitle = rs.getString("revtitle");
				String revcontents = rs.getString("revcontents");
				String revdate = rs.getString("revdate");
				int revscore = rs.getInt("revscore");
				int resno = rs.getInt("resno");
				
				ReviewVO vo = new ReviewVO(revno, revtitle, revcontents, revdate, revscore, resno);
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
		sb.append("from review");
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
	
	// 총 리뷰 게시물 수 아이디 별
	public int getTotal_clid(String clid) {

		sb.setLength(0);
		sb.append("select count(*) cnt ");
		sb.append("from review rw join reserve rs ");
		sb.append("using(resno) where rs.clid = ? ");
		int count = -1; 

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, clid);
			rs = pstmt.executeQuery();

			rs.next();
			count = rs.getInt("cnt");

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;

	};
	
	// 총 리뷰 게시물 수 시설 별
	public int getTotal_facno(int facno) {

		sb.setLength(0);
		sb.append("select count(*) cnt ");
		sb.append("from review rw join reserve rs ");
		sb.append("using(resno) where rs.facno = ? ");
		int count = -1; 

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, facno);
			rs = pstmt.executeQuery();

			rs.next();
			count = rs.getInt("cnt");

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;

	};

	// 1건 조회 : selectOne()
	public ReviewVO selectOne(int revno) {

		sb.setLength(0);
		sb.append("Select revno, revtitle, revcontents, revdate, revscore, resno ");
		sb.append("from review ");
		sb.append("where revno = ?");

		ReviewVO vo = null;

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, revno);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				String revtitle = rs.getString("revtitle");
				String revcontents = rs.getString("revcontents");
				String revdate = rs.getString("revdate");
				int revscore = rs.getInt("revscore");
				int resno = rs.getInt("resno");
				
				vo = new ReviewVO(revno, revtitle, revcontents, revdate, revscore, resno);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}
	//시설번호에서 아이디 끌어오기
	public String selectID(int resno) {

		sb.setLength(0);
		sb.append("select clid ");
		sb.append("from reserve ");
		sb.append("where resno = ?");

		String clid = "";

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, resno);
			rs = pstmt.executeQuery();

			if(rs.next())
			clid = rs.getString("clid");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return clid;
	}
	
	//예약번호에서 시설번호->시설명 끌어오기
	public String selectFacname(int resno) {

		sb.setLength(0);
		sb.append("select facname ");
		sb.append("from facilities ");
		sb.append("where facno=(select facno from reserve where resno=?)");

		String facname = "";

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, resno);
			rs = pstmt.executeQuery();

			rs.next();
			facname = rs.getString("facname");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return facname;
	}
	
	//예약테이블에서 내가 썼던 예약번호들 가져오기
	public ArrayList<Integer> selectResno(String clid) {
		ArrayList<Integer> list = new ArrayList<Integer>();
		sb.setLength(0);
		sb.append("select resno ");
		sb.append("from reserve ");
		sb.append("where clid = ?");


		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, clid);
			rs = pstmt.executeQuery();

			while (rs.next()) {
			int resno = rs.getInt("resno");
			list.add(resno);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//예약테이블에서 내가 썼던 예약번호들 가져오기 환불된 것 제외한다.
	public ArrayList<Integer> selectResnoRef(String clid) {
		ArrayList<Integer> list = new ArrayList<Integer>();
		sb.setLength(0);
		sb.append("select resno ");
		sb.append("from reserve ");
		sb.append("where clid = ?");
		sb.append("and resstate = 1 ");


		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, clid);
			rs = pstmt.executeQuery();

			while (rs.next()) {
			int resno = rs.getInt("resno");
			list.add(resno);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
		
	
	// 특정 시설번호에 대한 리뷰들 모으기 
	public ArrayList<ReviewVO> selectReview(int facno) {
		ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();
		sb.setLength(0);
		sb.append("select revno,revtitle,revcontents,revdate,revscore,resno ");
		sb.append("from review ");
		sb.append("where resno in ");
		sb.append("(select resno from reserve where facno=?)");
		

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, facno);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {

				
				int revno = rs.getInt("revno");
				String revtitle = rs.getString("revtitle");
				String revcontents = rs.getString("revcontents");
				String revdate = rs.getString("revdate");
				int revscore = rs.getInt("revscore");
				int resno = rs.getInt("resno");
				
				ReviewVO vo = new ReviewVO(revno, revtitle, revcontents, revdate, revscore, resno);
				
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 특정 아이디가 작성한 리뷰들 모으기 
	public ArrayList<ReviewVO> selectReview(String clid) {
		ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();
		sb.setLength(0);
		sb.append("select rw.revno, rw.revtitle, rw.revcontents, rw.revdate, rw.revscore, resno ");
		sb.append("from review rw join reserve rs ");
		sb.append("using(resno) where clid = ? ");
		

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, clid);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int revno = rs.getInt("revno");
				String revtitle = rs.getString("revtitle");
				String revcontents = rs.getString("revcontents");
				String revdate = rs.getString("revdate");
				int revscore = rs.getInt("revscore");
				int resno = rs.getInt("resno");
				
				ReviewVO vo = new ReviewVO(revno, revtitle, revcontents, revdate, revscore, resno);
				
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 특정 시설번호에 대한 리뷰들 모으기 시작과 끝페이지
	public ArrayList<ReviewVO> selectReview(int facno, int startNo, int endNo) {
		ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();
		sb.setLength(0);
		sb.append("select rownum, revno, revtitle, revcontents, revdate, revscore, resno ");
		sb.append("from (select @ROWNUM := @ROWNUM +1 AS ROWNUM, A.* ");
		sb.append("from (select revno, revtitle, revcontents, revdate, revscore, resno ");
		sb.append("from review ");
		sb.append("where resno in (select resno from reserve where facno = ? ) ");
		sb.append("ORDER BY revdate DESC)A,(SELECT @ROWNUM :=0 ) TMP)C ");
		sb.append("WHERE ROWNUM <= ? and ROWNUM >= ? ");


		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, facno);
			pstmt.setInt(2, endNo);
			pstmt.setInt(3, startNo);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int revno = rs.getInt("revno");
				String revtitle = rs.getString("revtitle");
				String revcontents = rs.getString("revcontents");
				String revdate = rs.getString("revdate");
				int revscore = rs.getInt("revscore");
				int resno = rs.getInt("resno");
				
				ReviewVO vo = new ReviewVO(revno, revtitle, revcontents, revdate, revscore, resno);
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 특정 아이디가 작성한 리뷰들 모으기 시작과 끝페이지
		public ArrayList<ReviewVO> selectReview(String clid, int startNo, int endNo) {
			ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();
			sb.setLength(0);
			sb.append("select ROWNUM, revno, revtitle, revcontents, revdate, revscore, resno  ");
			sb.append("from (select @ROWNUM := @ROWNUM +1 AS ROWNUM, A.* ");
			sb.append("from (select rw.revno, rw.revtitle, rw.revcontents, rw.revdate, rw.revscore, resno ");
			sb.append("from review rw join reserve rs using(resno) where rs.clid = ?  ");
			sb.append("ORDER BY rw.revno DESC )A,(SELECT @ROWNUM :=0 ) TMP)C  ");
			sb.append("WHERE ROWNUM <= ? and ROWNUM >= ?  ");


			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setString(1, clid);
				pstmt.setInt(2, endNo);
				pstmt.setInt(3, startNo);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					int revno = rs.getInt("revno");
					String revtitle = rs.getString("revtitle");
					String revcontents = rs.getString("revcontents");
					String revdate = rs.getString("revdate");
					int revscore = rs.getInt("revscore");
					int resno = rs.getInt("resno");
					
					ReviewVO vo = new ReviewVO(revno, revtitle, revcontents, revdate, revscore, resno);
					list.add(vo);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return list;
		}
	
	//검색
	public ArrayList<ReviewVO> searchRev(String x) {
		ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();
		sb.setLength(0);
		sb.append("select revno, revtitle, revcontents, revdate, revscore, resno ");
		sb.append("from review ");
		sb.append("where resno in ");
		sb.append("(select resno from reserve where facno in ");
		sb.append("(select facno from facilities ");
		sb.append("where facname like '%"+x+"%'))");
		
		
		try {
			
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			
			while (rs.next()) {

				int revno = rs.getInt("revno");
				String revtitle = rs.getString("revtitle");
				String revcontents = rs.getString("revcontents");
				String revdate = rs.getString("revdate");
				int revscore = rs.getInt("revscore");
				int resno = rs.getInt("resno");
				
				ReviewVO vo = new ReviewVO(revno, revtitle, revcontents, revdate, revscore, resno);
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 시설에서 검색 후 리뷰번호 가져오기
		public ArrayList<Integer> searchRevno(String[] x, int facno) {
			ArrayList<Integer> list = new ArrayList<Integer>();
			sb.setLength(0);
			
			sb.append("select DISTINCT revno from ( ");
			System.out.println(x.length);
			
			for(int i=0; i < x.length; i++) {
				
				sb.append("select revno ");
				sb.append("from (select revno, revtitle, revcontents, revdate, revscore, resno " );
				sb.append("from review where resno in ( select resno from reserve where facno = "+facno+" ))");
				sb.append("where revtitle like '%" + x[i] + "%' ");
				sb.append("or revcontents like '%" + x[i] + "%' ");
				
				if(i < x.length-1) {
					sb.append("union all ");
				}		
			}
			sb.append(") order by revno desc ");
			
			try {
				
				pstmt = conn.prepareStatement(sb.toString());
				rs = pstmt.executeQuery();
				
				while (rs.next()) {

					int revno = rs.getInt("revno");
					
					Integer vo = new Integer(revno);
					list.add(vo);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return list;
		}
		
		// 마이페이지에서 검색 후 리뷰번호 가져오기
		public ArrayList<Integer> searchRevnoId(String[] x, String clid) {
			ArrayList<Integer> list = new ArrayList<Integer>();
			sb.setLength(0);
			
			sb.append("select DISTINCT revno from ( ");
			System.out.println(x.length);
			
			for(int i=0; i < x.length; i++) {
				
				sb.append("select revno ");
				sb.append("from (select revno, revtitle, revcontents, revdate, revscore, resno " );
				sb.append("from review where resno in ( select resno from reserve where clid = '" + clid + "' ))");
				sb.append("where revtitle like '%" + x[i] + "%' ");
				sb.append("or revcontents like '%" + x[i] + "%' ");
				
				if(i < x.length-1) {
					sb.append("union all ");
				}		
			}
			sb.append(") order by revno desc ");
			
			try {
				
				pstmt = conn.prepareStatement(sb.toString());
				rs = pstmt.executeQuery();
				
				while (rs.next()) {

					int revno = rs.getInt("revno");
					
					Integer vo = new Integer(revno);
					list.add(vo);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return list;
		}
		
		
	//예약번호에서 시설번호->시설명 끌어오기
	public String selectNameTime(int resno) {

		sb.setLength(0);
		sb.append("select r.resdate, f.facname, r.restime ");
		sb.append("from reserve r join facilities f ");
		sb.append("using(facno) where r.resno=?");
		
		String facname = "";
		String resdate = "";
		String result ="";
		int restime =-1;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일"); 

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, resno);
			rs = pstmt.executeQuery();

			rs.next();
			resdate = sdf.format(rs.getDate("resdate"));
			facname = rs.getString("facname");
			restime = rs.getInt("restime");
			result = resdate + " " + facname + " 이용회차 : " + restime;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	// 1건 추가
	public void insertOne(ReviewVO vo) {

		sb.setLength(0);
		sb.append("insert into review ");
		sb.append("values (null,?,?,sysdate(),?,?)");
		// 등록날짜는 오늘날짜, 처음 조회수는 0. 처음 글 상태는 정상으로 1.
		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setString(1, vo.getRevtitle());
			pstmt.setString(2, vo.getRevcontents());
			pstmt.setInt(3, vo.getRevscore());
			pstmt.setInt(4, vo.getResno());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
	
	// 변경
	public void updateOne(ReviewVO vo) {
		sb.setLength(0);
		sb.append("update review ");
		sb.append("set revtitle = ? ,");
		sb.append("revcontents = ? ,");
		sb.append("revscore = ? ");
		sb.append("where revno = ?");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, vo.getRevtitle());
			pstmt.setString(2, vo.getRevcontents());
			pstmt.setInt(3, vo.getRevscore());
			pstmt.setInt(4, vo.getRevno());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	// 시설별 리뷰점수 총합
	public int scoreTotal(int facno) {

		sb.setLength(0);
		sb.append("select sum(rw.revscore) total from reserve rs join review rw using(resno) where rs.facno = ? "); 
		int sum = 0;
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, facno);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				sum = rs.getInt("total");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return sum;
	}

	// 삭제
	public void deleteOne(int revno) {
		sb.setLength(0);
		sb.append("delete from review ");
		sb.append("where revno = ?");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, revno);
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
