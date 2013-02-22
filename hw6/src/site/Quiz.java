package site;

import java.util.ArrayList;

public class Quiz {
	
	ArrayList<Question> questions;
	int quiz_id;
	int max_score;
	
	public Quiz() {
		this.questions = new ArrayList<Question>();
	}
	
	public void addQuestion(Question question) {
		this.questions.add(question);
	}
	
	public ArrayList<Question> getQuestions() {
		return questions;
	}
}
