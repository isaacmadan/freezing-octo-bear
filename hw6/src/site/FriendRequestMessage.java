package site;

public class FriendRequestMessage implements Message {
	private int messageType;
	private boolean acceptRequest;
	
	public FriendRequestMessage() {
		this.acceptRequest = false;
	}
	
	public void acceptRequest() {
		this.acceptRequest = true;
	}
	
}
