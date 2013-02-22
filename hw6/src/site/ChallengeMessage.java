package site;

public class ChallengeMessage implements Message {
	private int messageType;
	private String link;
	private int highScore;
	
	public ChallengeMessage(String link, int highScore) {
		this.link = link;
		this.highScore = highScore;
	}
}
