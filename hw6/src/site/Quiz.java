package site;

import java.util.ArrayList;

public class Quiz {
	
	ArrayList<Question> questions;
	
	public Quiz() {
		this.questions = new ArrayList<Question>();
	}
	
	public void addQuestion(Question question) {
		this.questions.add(question);
	}
	
	
	
	
	
}
