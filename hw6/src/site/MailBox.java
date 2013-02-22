package site;

import java.util.ArrayList;

public class MailBox {
	
	private ArrayList<Message> messages;
	
	public MailBox(ArrayList<Message> messages) {
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
}
