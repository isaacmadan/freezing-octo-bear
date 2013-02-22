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
	private boolean isAdmin;
	
	public User(String username, String password, boolean isAdmin) {
		
		this.username = username;
		this.password = password;
		
		this.isAdmin = isAdmin;
		
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
