package site;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class Inbox {
	
	private ArrayList<Message> messages;
	
	public Inbox(ArrayList<Message> messages) {
		this.setMessages(messages);
	}

	public void addMessage(Message message) {
		this.messages.add(message);
	}
	
	public ArrayList<Message> getMessages() {
		return messages;
	}

	public void setMessages(ArrayList<Message> messages) {
		this.messages = messages;
	}
	
	public static ArrayList<TextMessage> getMessagesById(int user_id) {
		ArrayList<TextMessage> messages = new ArrayList<TextMessage>();
		
		String date = "";
		String fromUserId = "";
		String content = "";
		int messageType = 0;
		
		AccountManager manager = new AccountManager();
		Connection con = MyDB.getConnection();
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM messages WHERE to_id='"+user_id+"'");
			while(rs.next()) {
				date = String.valueOf(rs.getTimestamp("created_timestamp"));
				fromUserId = rs.getString("from_user");
				content = rs.getString("content");
				messageType = rs.getInt("message_type");
				TextMessage message = new TextMessage(manager.getAccountById(fromUserId), manager.getAccountById(String.valueOf(user_id)), messageType, content);
				messages.add(message);
			}
		}
		catch(Exception e) {}
		
		return messages;
	}
	
	public static boolean sendTextMessage(TextMessage message) {
		Connection con = MyDB.getConnection();
		
		if(message.getFromUser() == null || message.getToUser() == null)
			return false;
		
		try {
			Statement stmt = con.createStatement(); //construct search query based on inputs
			String query = "INSERT INTO messages (to_id, from_id, content, message_type)" +
						   " VALUES("+message.getToUser().getId()+", "+message.getFromUser().getId()+", '"+message.getNote()+"', "+message.getMessageType()+")";
			System.out.println(query);
			stmt.executeUpdate(query);
			return true;
		}
		catch(Exception e) { System.out.println(e); } 
		
		return false;
	}
}
