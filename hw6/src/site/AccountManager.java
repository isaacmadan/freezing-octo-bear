package site;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class AccountManager {

	private Connection con;
	
	public AccountManager() {
		
		con = MyDB.getConnection();
	}
	
	public boolean isExistingAccountById(String user_id) { 
		int resCount = 0;
		try {
			Statement stmt = con.createStatement(); //construct search query based on inputs
			ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE user_id='"+user_id+"'");
			while(rs.next()) {
				resCount++;
			}
		}
		catch(Exception e) {}
		if(resCount == 0) {
			return false;
		}
		return true;
	}
	
	public boolean isExistingAccount(String username) { 
		int resCount = 0;
		try {
			Statement stmt = con.createStatement(); //construct search query based on inputs
			ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE username='"+username+"'");
			while(rs.next()) {
				resCount++;
			}
		}
		catch(Exception e) {}
		if(resCount == 0) {
			return false;
		}
		return true;
	}
	
	public boolean isPasswordCorrect(String username, String password) { 
		if(!isExistingAccount(username)) return false;
		
		String hashedPassword = hashPassword(password);
		String realPassword = null;
		
		try {
			Statement stmt = con.createStatement(); //construct search query based on inputs
			ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE username='"+username+"'");
			while(rs.next()) {
				realPassword = rs.getString("password");
			}
		}
		catch(Exception e) {} 
		
		if(hashedPassword.equals(realPassword))
			return true;
		return false; 
	}
	
	public void addFriend(String from_id, String to_id) {
		try {
			Statement stmt = con.createStatement(); //construct search query based on inputs
			String query = "INSERT INTO friends (x_id, y_id)" +
						   " VALUES("+from_id+", "+to_id+")";
			stmt.executeUpdate(query);
		}
		catch(Exception e) {} 
	}
	
	public User getAccountById(String user_id) {
		if(!isExistingAccountById(user_id)) return null;
		
		int id=0;
		String username="";
		String password="";
		boolean isAdmin=false;
		int loginCount=0;
		
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE user_id='"+user_id+"'");
			while(rs.next()) {
				id = rs.getInt("user_id");
				username = rs.getString("username");
				password = rs.getString("password");
				isAdmin = rs.getBoolean("is_admin");
				loginCount = rs.getInt("login_count");
			}
			User user = new User(id, username, password, isAdmin, loginCount);
			return user;
		}
		catch(Exception e) {}
		return null;
	}
	
	public User getAccount(String username) {
		if(!isExistingAccount(username)) return null;
		
		int id=0;
		String password="";
		boolean isAdmin=false;
		int loginCount=0;
		
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE username='"+username+"'");
			while(rs.next()) {
				id = rs.getInt("user_id");
				password = rs.getString("password");
				isAdmin = rs.getBoolean("is_admin");
				loginCount = rs.getInt("login_count");
			}
			User user = new User(id, username, password, isAdmin, loginCount);
			return user;
		}
		catch(Exception e) {}
		return null;
	}
	
	public User createNewAccount(String username, String password, boolean isAdmin) {
		if(isExistingAccount(username)) return null;
		int loginCount = 0;
		
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE username='"+username+"'");
			while(rs.next()) {
				loginCount = Integer.parseInt(rs.getString("login_count"));
			}
		}
		catch(Exception e) {}
		
		try {
			Statement stmt = con.createStatement(); //construct search query based on inputs
			String query = "INSERT INTO users (username, password, is_admin, login_count, created_timestamp, last_login_timestamp)" +
						   " VALUES('"+username+"', '"+hashPassword(password)+"', "+isAdmin+", "+loginCount+", NULL, NULL)";
			stmt.executeUpdate(query);
		}
		catch(Exception e) { return null; } 
		
		int id = 0;
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE username='"+username+"'");
			while(rs.next()) {
				id = Integer.parseInt(rs.getString("user_id"));
			}
			User user = new User(id, username, hashPassword(password), isAdmin, loginCount);
			return user;
		}
		catch(Exception e) {}
		
		return null;
		
	}
	
	/*
	 Given a byte[] array, produces a hex String,
	 such as "234a6f". with 2 chars for each byte in the array.
	 (provided code)
	*/
	public static String hexToString(byte[] bytes) {
		StringBuffer buff = new StringBuffer();
		for (int i=0; i<bytes.length; i++) {
			int val = bytes[i];
			val = val & 0xff;  // remove higher bits, sign
			if (val<16) buff.append('0'); // leading 0
			buff.append(Integer.toString(val, 16));
		}
		return buff.toString();
	}
	
	public String hashPassword(String input) {
		byte[] bytes = input.getBytes();
		
		MessageDigest hash = null; //SHA hash
		try {
			hash = MessageDigest.getInstance("SHA");
		} catch (NoSuchAlgorithmException e1) {
			e1.printStackTrace();
		}
		
		String res = null;
		try {
			hash.update(bytes);
			byte[] output = hash.digest();
			res = hexToString(output);
		}
		catch(Exception e) {
			
		}
		
		return res;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
