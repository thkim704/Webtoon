package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class reviewDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	//�⺻ ������
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
	
	//�ۼ����� �޼ҵ�
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
		return ""; //�����ͺ��̽� ����
	}
		
	//�Խñ� ��ȣ �ο� �޼ҵ�
	public int getNext_R() {
		//���� �Խñ��� ������������ ��ȸ�Ͽ� ���� ������ ���� ��ȣ�� ���Ѵ�
		String sql = "select review_id from Review order by review_id desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //ù ��° �Խù��� ���
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
		
	//�۾��� �޼ҵ�
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
			pstmt.setInt(8, 1); //���� ��ȿ��ȣ
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
		
	//�Խñ� ����Ʈ �޼ҵ�
	public ArrayList<review> getList_R(int startRow, int endRow){
		String sql = "select * from (SELECT @rownum:=@rownum+1 AS rownum, sub_2.* FROM (select * from Review where available = 1 order by review_id desc)sub_2, (SELECT @ROWNUM := 0) rn)sub_1 where sub_1.rownum between ? and ?";
		ArrayList<review> list = new ArrayList<review>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow); // sql ����ǥ�� �� ����
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
		
	// �� ���ڵ� �� ���ϴ� ����
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
		return count; // �� ���ڵ� �� ����
	}
		
	//�ϳ��� �Խñ��� ���� �޼ҵ�
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
		
	//�Խñ� ���� �޼ҵ�
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
		return -1; //�����ͺ��̽� ����
	}
		
	//�Խñ� ���� �޼ҵ�
	public int delete_R(int review_id) {
		//���� �����͸� �����ϴ� ���� �ƴ϶� �Խñ� ��ȿ���ڸ� '0'���� �����Ѵ�
		String sql = "update Review set available = 0 where review_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, review_id);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ���� 
	}

}
