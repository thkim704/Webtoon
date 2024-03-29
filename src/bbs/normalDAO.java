package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class normalDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	//기본 생성자
	public normalDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost/project8";
			String dbID = "root";
			String dbPassword = "manager";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//작성일자 메소드
		public String getDate_N() {
			String sql = "select now()";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return ""; //데이터베이스 오류
		}
		
		//게시글 번호 부여 메소드
		public int getNext_N() {
			//현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
			String sql = "select community_id from community order by community_id desc";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getInt(1) + 1;
				}
				return 1; //첫 번째 게시물인 경우
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
		}
		
		//글쓰기 메소드
		public int write_N(String comtitle, String memberID, String comcontents) {
			String sql = "insert into community values(?, ?, ?, ?, ?, ?)";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, getNext_N());
				pstmt.setString(2, memberID);
				pstmt.setString(3, comtitle);
				pstmt.setString(4, getDate_N());
				pstmt.setString(5, comcontents);
				pstmt.setInt(6, 1); //글의 유효번호
				return pstmt.executeUpdate();
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
		}
		
		//게시글 리스트 메소드
		public ArrayList<normal> getList_N(int startRow, int endRow){
			String sql = "select * from (SELECT @rownum:=@rownum+1 AS rownum, sub_2.* FROM (select * from community where available = 1 order by community_id desc)sub_2, (SELECT @ROWNUM := 0) rn)sub_1 where sub_1.rownum between ? and ?";
			ArrayList<normal> list = new ArrayList<normal>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startRow); // sql 물음표에 값 매핑
				pstmt.setInt(2, endRow);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					normal normal = new normal();
					normal.setBbs_N_ID(rs.getInt(2));
					normal.setUserID_N(rs.getString(3));
					normal.setBbs_N_title(rs.getString(4));
					normal.setBbs_N_Date(rs.getString(5));
					normal.setBbs_N_Content(rs.getString(6));
					normal.setBbs_N_Available(rs.getInt(7));
					list.add(normal);
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return list;
		}
		
		// 총 레코드 수 구하는 로직
		public int getCount_N(){
			int count = 0;
			String sql = "select count(*) from community where available = 1";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()){
					count = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return count; // 총 레코드 수 리턴
		}
		
		//하나의 게시글을 보는 메소드
		public normal getBbs_N(int bbsID) {
			String sql = "select * from community where community_id = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bbsID);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					normal normal = new normal();
					normal.setBbs_N_ID(rs.getInt(1));
					normal.setUserID_N(rs.getString(2));
					normal.setBbs_N_title(rs.getString(3));
					normal.setBbs_N_Date(rs.getString(4));
					normal.setBbs_N_Content(rs.getString(5));
					normal.setBbs_N_Available(rs.getInt(6));
					return normal;
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		//게시글 수정 메소드
		public int update_N(int community_id, String comtitle, String comcontents) {
			String sql = "update community set comtitle = ?, comcontents = ? where community_id = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, comtitle);
				pstmt.setString(2, comcontents);
				pstmt.setInt(3, community_id);
				return pstmt.executeUpdate();
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
		}
		
		//게시글 삭제 메소드
		public int delete_N(int community_id) {
			//실제 데이터를 삭제하는 것이 아니라 게시글 유효숫자를 '0'으로 수정한다
			String sql = "update community set available = 0 where community_id = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, community_id);
				return pstmt.executeUpdate();
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류 
		}

}
