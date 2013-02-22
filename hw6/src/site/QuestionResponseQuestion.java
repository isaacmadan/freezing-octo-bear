package site;

public class QuestionResponseQuestion implements Question {
	private int questionId;
    private int quizId;
    private int pointValue;
    private int questionType;
    private Answer answer;
    
    private int questionResponseId;
    private String questionString;
    
    public QuestionResponseQuestion(int questionId, int quizId, int pointValue, int questionType, 
    		Answer answer, int questionResponseId, String questionString) {
    	this.setQuestionId(questionId);
        this.setQuizId(quizId);
        this.setPointValue(pointValue);
        this.setQuestionType(questionType);
        this.setAnswer(answer);
        this.setQuestionResponseId(questionResponseId);
        this.setQuestionString(questionString);
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

	public int getQuestionResponseId() {
		return questionResponseId;
	}

	public void setQuestionResponseId(int questionResponseId) {
		this.questionResponseId = questionResponseId;
	}

	public String getQuestionString() {
		return questionString;
	}

	public void setQuestionString(String questionString) {
		this.questionString = questionString;
	}
}
