package site;

public class FillInTheBlankQuestion implements Question {
	private int questionId;
    private int quizId;
    private int pointValue;
    private int questionType;
    private Answer answer;
    
    private int fillInTheBlankId;
    private String frontString;
    private String backString;
    
    public FillInTheBlankQuestion(int questionId, int quizId, int pointValue, int questionType, 
    		Answer answer, int fillInTheBlankId, String frontString, String backString) {
    	this.setQuestionId(questionId);
        this.setQuizId(quizId);
        this.setPointValue(pointValue);
        this.setQuestionType(questionType);
        this.setAnswer(answer);
        this.setFillInTheBlankId(fillInTheBlankId);
        this.setFrontString(frontString);
        this.setBackString(backString);
    }

	public int getQuestionId() {
		return questionId;
	}

	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}

	public int getQuizId() {
		return quizId;
	}

	public void setQuizId(int quizId) {
		this.quizId = quizId;
	}

	public int getPointValue() {
		return pointValue;
	}

	public void setPointValue(int pointValue) {
		this.pointValue = pointValue;
	}

	public int getQuestionType() {
		return questionType;
	}

	public void setQuestionType(int questionType) {
		this.questionType = questionType;
	}

	public Answer getAnswer() {
		return answer;
	}

	public void setAnswer(Answer answer) {
		this.answer = answer;
	}

	public int getFillInTheBlankId() {
		return fillInTheBlankId;
	}

	public void setFillInTheBlankId(int fillInTheBlankId) {
		this.fillInTheBlankId = fillInTheBlankId;
	}

	public String getFrontString() {
		return frontString;
	}

	public void setFrontString(String frontString) {
		this.frontString = frontString;
	}

	public String getBackString() {
		return backString;
	}

	public void setBackString(String backString) {
		this.backString = backString;
	}
}
