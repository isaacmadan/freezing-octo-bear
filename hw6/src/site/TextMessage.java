package site;

public class TextMessage implements Message{
	private int messageId;
	private User fromUser;
	private User toUser;
	private int messageType;
	private String note;
	private String timestamp;
	
	public TextMessage(User fromUser, User toUser, int messageType, String note) {
		messageId = 0;
		this.setFromUser(fromUser);
		this.setToUser(toUser);
		this.setMessageType(messageType);
		this.note = note;
		setTimestamp("");
	}
	
	public TextMessage(int id, User fromUser, User toUser, int messageType, String note, String timestamp) {
		messageId = id;
		this.setFromUser(fromUser);
		this.setToUser(toUser);
		this.setMessageType(messageType);
		this.note = note;
		this.setTimestamp(timestamp);
	}
	
	public int getMessageId() {
		return messageId;
	}
	
	public void setMessageId(int id) {
		this.messageId = id;
	}
	
	public String getNote() {
		return this.note;
	}

	public User getFromUser() {
		return fromUser;
	}

	public void setFromUser(User fromUser) {
		this.fromUser = fromUser;
	}

	public User getToUser() {
		return toUser;
	}

	public void setToUser(User toUser) {
		this.toUser = toUser;
	}

	public int getMessageType() {
		return messageType;
	}

	public void setMessageType(int messageType) {
		this.messageType = messageType;
	}

	public String getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
}
