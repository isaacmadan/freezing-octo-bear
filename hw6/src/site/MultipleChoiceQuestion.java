package site;

import java.util.ArrayList;

public class MultipleChoiceQuestion implements Question {
	private int questionId;
    private int quizId;
    private int pointValue;
    private int questionType;
    private Answer answer;
    
    private int multipleChoiceId;
    private String questionString;
    private ArrayList<MultipleChoiceChoices> choices;
    
    public MultipleChoiceQuestion(int questionId, int quizId, int pointValue, int questionType, 
    		Answer answer, int multipleChoiceId, String questionString, ArrayList<MultipleChoiceChoices> choices) {
    	this.setQuestionId(questionId);
        this.setQuizId(quizId);
        this.setPointValue(pointValue);
        this.setQuestionType(questionType);
        this.setAnswer(answer);
        this.setMultipleChoiceId(multipleChoiceId);
        this.setQuestionString(questionString);
        this.setChoices(choices);
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

	public int getMultipleChoiceId() {
		return multipleChoiceId;
	}

	public void setMultipleChoiceId(int multipleChoiceId) {
		this.multipleChoiceId = multipleChoiceId;
	}

	public String getQuestionString() {
		return questionString;
	}

	public void setQuestionString(String questionString) {
		this.questionString = questionString;
	}

	public ArrayList<MultipleChoiceChoices> getChoices() {
		return choices;
	}

	public void setChoices(ArrayList<MultipleChoiceChoices> choices) {
		this.choices = choices;
	}
}
