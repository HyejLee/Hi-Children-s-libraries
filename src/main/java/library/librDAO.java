package library;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.time.LocalDateTime;

import java.util.ArrayList;
import java.util.Calendar;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class librDAO{
	String id = "root";
	String password = "111111";
	String url = "jdbc:mysql://localhost:3306/jspdb?characterEncoding=utf-8";
	
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	public void connect_cp() {

		try {
			Context initctx = new InitialContext();
			Context envctx = (Context)initctx.lookup("java://comp/env");
			
			DataSource ds = (DataSource) envctx.lookup("jdbc/pool");
			
			conn = ds.getConnection();
			System.out.println("커넥션 풀로 연결 성공 !!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void disconnect() {
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		System.out.println("Disconnect 성공 !!");	
	}
	
	public int login(String id, String pw) {
		connect_cp();
		
		String message = null; 
		String sql = "select password from users where userId=?";

		librDO ldo = new librDO();
		
		try {
			ldo.setPassword(ldo.getPassword());
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				System.out.println(pw);
				System.out.println(rs.getString(1));
				if(rs.getString(1).equals(pw)) {
					return 1;
				}else {
					return 0;
				}
			}else {
				return -1;
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -2;
		}
		
		
		
	}
	
	public ArrayList<librDO> getAllBook(){
		connect_cp();
		
		ArrayList<librDO> lList = new ArrayList<librDO>();

		String sql = "select * from book order by count desc";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				librDO ldo = new librDO();
				ldo.setId(rs.getInt(1));
				ldo.setTitle(rs.getString(2));
				ldo.setWriter(rs.getString(3));
				ldo.setRent(rs.getBoolean(4));
				ldo.setCount(rs.getInt(5));
				lList.add(ldo);
			}
			System.out.println("getAllBook()완료");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("getAllBook()실패");
		}
		
		disconnect();
		return lList;
	}
	
	
	public librDO getBookOne(int id) {
		connect_cp();
		librDO ldo = new librDO();

		//sql 처리합니당
		String sql = "select * from book where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ldo.setId(rs.getInt(1));
				ldo.setTitle(rs.getString(2));
				ldo.setWriter(rs.getString(3));
				ldo.setCount(rs.getInt(5));
			}
			System.out.println("getAddrOne() 처리 완료 ! ");
			
			System.out.println("count = "+ldo.getCount());
								
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		disconnect();
		return ldo;	
	}
	
	public void rentBook(librDO ldo) {
		connect_cp();

		String testDate = ldo.getRent_date();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		java.util.Date rentDateUtil = null;
		Calendar cal1 = null;
		java.util.Date returnDateUtil = null;
		java.sql.Date rentDateSql = null;
		java.sql.Date returndateSql = null;
		
	
		
		
		//id, title, writer, rentDate, returnDate
		String sqlMyBook = "insert into mybook values(?, ?, ?, ?, ?, ?)";
		//count
		String sqlBook = "update book set rent=?, count=? where id=?";
		
		try {
			
			try {
				rentDateUtil =  df.parse(testDate);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			cal1 = Calendar.getInstance();
			cal1.setTime(rentDateUtil);
			cal1.add(Calendar.DATE, 7);
			returnDateUtil = new java.util.Date(cal1.getTimeInMillis());
			rentDateSql = new java.sql.Date(rentDateUtil.getTime());
			returndateSql = new java.sql.Date(returnDateUtil.getTime());
			
			
			pstmt = conn.prepareStatement(sqlMyBook);
			pstmt.setInt(1, ldo.getId());
			pstmt.setString(2, ldo.getUserId());
			pstmt.setString(3, ldo.getTitle());
			pstmt.setString(4, ldo.getWriter());
			pstmt.setDate(5, rentDateSql);
			pstmt.setDate(6, returndateSql);
			
			pstmt.executeUpdate();
			

			pstmt = conn.prepareStatement(sqlBook);
			pstmt.setBoolean(1, true);
			pstmt.setInt(2, ldo.getCount()+1);
			pstmt.setInt(3, ldo.getId());
			
			pstmt.executeUpdate();
			
			
			System.out.println("rentBook 처리 성공 !!");
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("rentBook 처리 실패 !!");
		}
		
		disconnect();
	}
	
	public ArrayList<librDO> getAllMyBook(String userId){
		connect_cp();
		
		ArrayList<librDO> lList = new ArrayList<librDO>();

		String sql = "select * from mybook where userId=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				librDO ldo = new librDO();
				ldo.setId(rs.getInt(1));
				ldo.setUserId(rs.getString(2));
				ldo.setTitle(rs.getString(3));
				ldo.setWriter(rs.getString(4));
				ldo.setRentDate(rs.getDate(5));
				ldo.setReturnDate(rs.getDate(6));
				lList.add(ldo);
			}
			System.out.println("getAllMyBook() 완료 !");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("getAllMyBook() 실패 !");
		}
		
		disconnect();
		return lList;
	}
	
	public void hopeBook(librDO ldo) {
		connect_cp();
		//id, title, writer, contents
		String sql = "insert into hopebook values(?, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ldo.getUserId());
			pstmt.setString(2, ldo.getTitle());
			pstmt.setString(3, ldo.getWriter());
			pstmt.setString(4, ldo.getContents());

			pstmt.executeUpdate();
			System.out.println("hopeBook 처리 성공 !!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("hopeBook 처리 실패 !!");
		}
	}
	
	public ArrayList<librDO> getAllHopeBook(){
		connect_cp();
		
		ArrayList<librDO> lList = new ArrayList<librDO>();

		String sql = "select * from hopebook";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				librDO ldo = new librDO();
				ldo.setUserId(rs.getString(1));
				ldo.setTitle(rs.getString(2));
				ldo.setWriter(rs.getString(3));
				ldo.setContents(rs.getString(4));
				lList.add(ldo);
			}
			System.out.println("getAllHopeBook()완료");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("getAllHopeBook()완료");
		}
		
		disconnect();
		return lList;
	}
	
	
	public void returnBook(int id) {
		connect_cp();
		String sqlMyBook = "delete from mybook where bookid=?";
		String sqlBook = "update book set rent=? where id=?";

		
		try {
			pstmt = conn.prepareStatement(sqlMyBook);
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(sqlBook);
			pstmt.setBoolean(1, false);
			pstmt.setInt(2, id);
			pstmt.executeUpdate();

			System.out.println("returnBook() 실행 ! ");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

			System.out.println("returnBook() 실패 ! ");
		}
		
		disconnect();
		
	}
	
	public ArrayList<librDO> getKeywordBook(String filter, String keyword){
		connect_cp();
		
		ArrayList<librDO> lList = new ArrayList<librDO>();
		
		String sql = "select * from book where "+filter+" LIKE ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+keyword+"%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				librDO ldo = new librDO();
				ldo.setId(rs.getInt(1));
				ldo.setTitle(rs.getString(2));
				ldo.setWriter(rs.getString(3));
				ldo.setRent(rs.getBoolean(4));
				ldo.setCount(rs.getInt(5));
				lList.add(ldo);
			}
			System.out.println("getKeywordBook()완료");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("getKeywordBook()실패");
		}
		
		disconnect();
		return lList;
	}
}
