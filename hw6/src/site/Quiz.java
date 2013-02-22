package site;

import java.util.ArrayList;

public class Quiz {
	
	private ArrayList<Question> questions;
	private int quiz_id;
	private int max_score;
	
	public Quiz(ArrayList<Question> questions) {
		this.setQuestions(questions);
	}
	
	public void addQuestion(Question question) {
		this.questions.add(question);
	}
	
	public ArrayList<Question> getQuestions() {
		return questions;
	}
	
	public void setQuestions(ArrayList<Question> questions) {
		this.questions = questions;
	}

	public int getQuiz_id() {
		return quiz_id;
	}

	public void setQuiz_id(int quiz_id) {
		this.quiz_id = quiz_id;
	}

	public int getMax_score() {
		return max_score;
	}

	public void setMax_score(int max_score) {
		this.max_score = max_score;
	}

	public static Quiz getQuiz(int quiz) {
		// TODO Auto-generated method stub
		return null;
	}
}
