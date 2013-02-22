package site;


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
		
		this.setId(id);
		this.setUsername(username);
		this.setPassword(password);
		this.setAdmin(isAdmin);
		this.setLoginCount(loginCount);
		
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getLoginCount() {
		return loginCount;
	}

	public void setLoginCount(int loginCount) {
		this.loginCount = loginCount;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

}
