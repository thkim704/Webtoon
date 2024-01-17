package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class reviewDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	//기본 생성자
	public reviewDAO() {
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
	public String getDate_R() {
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
	public int getNext_R() {
		//현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		String sql = "select review_id from Review order by review_id desc";
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
	public int write_R(String retitle, String memberID, String webtoonname, int regrade, String recontents) {
		String sql = "insert into Review values(?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext_R());
			pstmt.setString(2, memberID);
			pstmt.setString(3, webtoonname);
			pstmt.setString(4, retitle);
			pstmt.setString(5, getDate_R());
			pstmt.setInt(6, regrade);
			pstmt.setString(7, recontents);
			pstmt.setInt(8, 1); //글의 유효번호
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
		
	//게시글 리스트 메소드
	public ArrayList<review> getList_R(int startRow, int endRow){
		String sql = "select * from (SELECT @rownum:=@rownum+1 AS rownum, sub_2.* FROM (select * from Review where available = 1 order by review_id desc)sub_2, (SELECT @ROWNUM := 0) rn)sub_1 where sub_1.rownum between ? and ?";
		ArrayList<review> list = new ArrayList<review>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow); // sql 물음표에 값 매핑
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				review review = new review();
				review.setBbs_R_ID(rs.getInt(2));
				review.setUserID_R(rs.getString(3));
				review.setWebtoon_R(rs.getString(4));
				review.setBbs_R_title(rs.getString(5));
				review.setBbs_R_Date(rs.getString(6));
				review.setBbs_R_Grade(rs.getInt(7));
				review.setBbs_R_Content(rs.getString(8));
				review.setBbs_R_Available(rs.getInt(9));
				list.add(review);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
		
	// 총 레코드 수 구하는 로직
	public int getCount_R(){
		int count = 0;
		String sql = "select count(*) from Review where available = 1";
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
	public review getBbs_R(int bbsID) {
		String sql = "select * from Review where review_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				review review = new review();
				review.setBbs_R_ID(rs.getInt(1));
				review.setUserID_R(rs.getString(2));
				review.setWebtoon_R(rs.getString(3));
				review.setBbs_R_title(rs.getString(4));
				review.setBbs_R_Date(rs.getString(5));
				review.setBbs_R_Grade(rs.getInt(6));
				review.setBbs_R_Content(rs.getString(7));
				review.setBbs_R_Available(rs.getInt(8));
				return review;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
		
	//게시글 수정 메소드
	public int update_R(int review_id, String retitle, int regrade, String recontents) {
		String sql = "update Review set retitle = ?, regrade = ?, recontents = ? where review_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, retitle);
			pstmt.setInt(2, regrade);
			pstmt.setString(3, recontents);
			pstmt.setInt(4, review_id);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
		
	//게시글 삭제 메소드
	public int delete_R(int review_id) {
		//실제 데이터를 삭제하는 것이 아니라 게시글 유효숫자를 '0'으로 수정한다
		String sql = "update Review set available = 0 where review_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, review_id);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
	}

}
