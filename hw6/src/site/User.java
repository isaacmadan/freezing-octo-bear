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

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
