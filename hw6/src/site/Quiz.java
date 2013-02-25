package site;

import java.sql.Timestamp;
import java.util.ArrayList;

/**	quiz_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT,
	practice_mode BOOLEAN,
	max_score INT,
	description TEXT,
	title TEXT,
	random_question BOOLEAN,
	one_page BOOLEAN,
	immediate_correction BOOLEAN,
    created_timestamp TIMESTAMP*/

public class Quiz {
	
	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public boolean isPractice_mode() {
		return practice_mode;
	}

	public void setPractice_mode(boolean practice_mode) {
		this.practice_mode = practice_mode;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public boolean isRandom_question() {
		return random_question;
	}

	public void setRandom_question(boolean random_question) {
		this.random_question = random_question;
	}

	public boolean isOne_page() {
		return one_page;
	}

	public void setOne_page(boolean one_page) {
		this.one_page = one_page;
	}

	public boolean isImmediate_correction() {
		return immediate_correction;
	}

	public void setImmediate_correction(boolean immediate_correction) {
		this.immediate_correction = immediate_correction;
	}

	public Timestamp getCreated_timestamp() {
		return created_timestamp;
	}

	public void setCreated_timestamp(Timestamp created_timestamp) {
		this.created_timestamp = created_timestamp;
	}

	private ArrayList<Question> questions;
	private int quiz_id;
	private int user_id;
	private int max_score;
	private boolean practice_mode;
	private String description;
	private String title;
	private boolean random_question;
	private boolean one_page;
	private boolean immediate_correction;
	private Timestamp created_timestamp;
	
	public Quiz(ArrayList<Question> questions) {
		this.setQuestions(questions);
	}
	
	public Quiz() {
		
	}
	
	public Quiz(int quiz_id, int user_id, int max_score,
			boolean practice_mode, String description, String title, 
			boolean random_question, boolean one_page, boolean immediate_correction, 
			Timestamp created_timestamp) {
		this.setUser_id(user_id);
		this.setMax_score(max_score);
		this.setPractice_mode(practice_mode);
		this.setDescription(description);
		this.setTitle(title);
		this.setRandom_question(random_question);
		this.setOne_page(one_page);
		this.setImmediate_correction(immediate_correction);
		this.setCreated_timestamp(created_timestamp);
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
