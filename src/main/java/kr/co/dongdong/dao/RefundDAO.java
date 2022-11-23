package kr.co.dongdong.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import kr.co.dongdong.vo.RefundVO;

public class RefundDAO {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "apoderado";
	String password = "tiger";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();
	
	public RefundDAO() {
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
	
	// 전체조회
	public ArrayList<RefundVO> selectAll() {
		ArrayList<RefundVO> list = new ArrayList<RefundVO>();
		sb.setLength(0);
		sb.append("Select refno, resno, refreason, refdate, refstate ");
		sb.append("from refund order by refdate desc");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {

				int refno = rs.getInt("refno");
				int resno = rs.getInt("resno");
				String refreason = rs.getString("refreason");
				String refdate = rs.getString("refdate");
				int refstate = rs.getInt("refstate");
				
				RefundVO vo = new RefundVO(refno, resno, refreason, refdate, refstate);
				list.add(vo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
		
	//예약테이블에서 내가 썼던 예약번호들 가져오기. 환불할 신청 내역들
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
	
	//예약번호로 이용예정일 가져오기
	public Date selectResdate(int resno) {
		sb.setLength(0);
		sb.append("select resdate ");
		sb.append("from reserve ");
		sb.append("where resno = ?");
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		Date resdate = null;
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, resno);
			rs = pstmt.executeQuery();

			rs.next();
			resdate = rs.getDate("resdate");
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resdate;
	}
	//예약번호로 이용회차 가져오기
		public int selectRestime(int resno) {
			sb.setLength(0);
			sb.append("select restime ");
			sb.append("from reserve ");
			sb.append("where resno = ?");
			int restime = -1;
			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, resno);
				rs = pstmt.executeQuery();

				rs.next();
				restime = rs.getInt("restime");
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return restime;
		}
			
	//예약번호에서 시설번호->시설명 끌어오기
	public String selectNameTime(int resno) {

		sb.setLength(0);
		sb.append("select f.facname ");
		sb.append("from reserve r join facilities f ");
		sb.append("using(facno) where r.resno=?");
		
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
	
	//예약번호에서 시설번호->가격 끌어오기
	public int selectPrice(int resno) {

		sb.setLength(0);
		sb.append("select f.facprice ");
		sb.append("from reserve r join facilities f ");
		sb.append("using(facno) where r.resno=?");
		
		int facprice = -1;
		 

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, resno);
			rs = pstmt.executeQuery();

			rs.next();
			facprice = rs.getInt("facprice");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return facprice;
	}
			
	// 예약테이블 상태 취소로 변경
	public void deleteOne(int resno) {
		sb.setLength(0);
		sb.append("update reserve set ");
		sb.append("resstate = 2 ");
		sb.append("where resno = ?");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, resno);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 환불 테이블에 1건 추가
	public void insertOne(RefundVO vo) {

		sb.setLength(0);
		sb.append("insert into refund ");
		sb.append("values ( refund_refno_seq.nextval,?,?,sysdate,0)");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setInt(1, vo.getResno());
			pstmt.setString(2, vo.getRefreason());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
}
