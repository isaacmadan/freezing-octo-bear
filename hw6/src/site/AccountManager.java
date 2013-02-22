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
	
	public void createNewAccount(String username, String password) {
		if(isExistingAccount(username)) return;
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
						   " VALUES('"+username+"', '"+hashPassword(password)+"', false, "+loginCount+", NULL, NULL)";
			stmt.executeUpdate(query);
		}
		catch(Exception e) {} 
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
