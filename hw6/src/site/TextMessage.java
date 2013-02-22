package site;

public class TextMessage implements Message{
	private int messageType;
	private String note;
	
	public TextMessage(String note) {
		this.note = note;
	}
	
	public String getNote() {
		return this.note;
	}
}
