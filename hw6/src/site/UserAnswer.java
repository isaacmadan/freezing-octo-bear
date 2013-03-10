package site;

/**UserAnswer encapsulates a questionId and a text answer*/
public class UserAnswer extends Object{
	@Override
	public String toString() {
		return "UserAnswer [questionId=" + questionId + ", userInput="
				+ userInput + "]";
	}

	public final int questionId;
	public final String userInput;
	
	public UserAnswer(int qId, String answer){
		this.questionId = qId;
		this.userInput = answer;
	}
	
}
