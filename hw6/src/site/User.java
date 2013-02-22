package site;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class User {

	private int id;
	private String username;
	private String password;
	//Friends
	//Inbox
	//History
	//Achievements
	private int loginCount;
	private boolean isAdmin;
	
	public User(int id, String username, String password, boolean isAdmin, int loginCount) {
		
		this.id = id;
		this.username = username;
		this.password = password;
		this.isAdmin = isAdmin;
		this.loginCount = loginCount;
		
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
