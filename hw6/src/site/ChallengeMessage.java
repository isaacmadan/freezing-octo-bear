package site;

/**ChallengeMessage encapsulates a link to the challenged quiz and the users high score on that quiz*/
public class ChallengeMessage implements Message {
	private int messageType;
	private String link;
	private int highScore;
	
	public ChallengeMessage(String link, int highScore) {
		this.link = link;
		this.highScore = highScore;
	}
}
