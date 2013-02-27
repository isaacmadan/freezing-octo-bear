package site;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class QuizManager {

	private Connection con;
	private Quiz quiz;
	private HttpServletRequest request;
	private HttpSession session;
	private int user_id;
	private boolean practice_mode;
	private String description;
	private String title;
	private int max_score;
	private boolean random_question;
	private boolean one_page;
	private boolean immediate_correction;
	
	public QuizManager() {
		con = MyDB.getConnection();
	}
	
	public QuizManager(Quiz quiz) {
		this.quiz = quiz;
	}
	
	public QuizManager(HttpServletRequest request, Quiz quiz) {
		con = MyDB.getConnection();
		this.request = request;
		this.session = request.getSession();
		this.user_id = ((User)session.getAttribute("user")).getId();
		if(quiz.isPractice_mode()) this.practice_mode = true;
		else this.practice_mode = false;
		if(quiz.getDescription() != null) this.description = quiz.getDescription();
		else this.description = "";
		if(quiz.getTitle() != null) this.title = quiz.getTitle();
		else this.title = "";
		if(quiz.getMax_score() != 0) this.max_score = quiz.getMax_score();
		else this.max_score = 0;
		if(quiz.isRandom_question()) this.random_question = true;
		else this.random_question = false;
		if(quiz.isOne_page()) this.one_page = true;
		else this.one_page = false;
		if(quiz.isImmediate_correction()) this.immediate_correction = true;
		else this.immediate_correction = false;
		this.quiz = quiz;
	}
	
	public void addQuizToDataBase() {
		try {
			Statement stmt = con.createStatement();
			String exeStr = "INSERT INTO quizzes (user_id, practice_mode, description, title, max_score," +
					"random_question, one_page, immediate_correction) VALUES(" + user_id + "," + practice_mode + ",\"" +
					description + "\",\"" + title + "\"," + max_score + "," + random_question + "," + one_page + "," + immediate_correction + ");";
			
			stmt.executeUpdate(exeStr);
			/*
			if(request.getParameter("question_response_count") != null) addQuestionResponseToDataBase();
			if(request.getParameter("fill_in_the_blank_count") != null) addFillInTheBlankToDataBase();
			if(request.getParameter("multiple_choice_count") != null) addMultipleChoiceToDataBase();
			if(request.getParameter("picture_response_count") != null) addPictureResponseToDataBase();
			*/
		}
		catch(Exception e) { }
	}
	
	private void addQuestionResponseToDataBase() {
		/*try {
			Statement stmt = con.createStatement();
			for(int i = 0; i < Integer.parseInt(request.getParameter("question_response_count")); i++) {
				String addingToQuestionDB = "INSERT INTO questions (quiz_id, point_value, question_type)"
						+ "VALUES(" + ;
			}
			stmt.executeQuery("INSERT INTO quizzes (user_id, practice_mode, description, title, max_score," +
					"random_question, one_page, immediate_correction) VALUES(" + user_id + "," + practice_mode + "," +
					description + "," + title + "," + max_score + "," + random_question + "," + one_page + "," + immediate_correction + ");");
		} catch(Exception e) { }*/
	}
	
	private void addFillInTheBlankToDataBase() {
		
	}

	private void addMultipleChoiceToDataBase() {
	
	}

	private void addPictureResponseToDataBase() {
	
	}
	
	public ArrayList<Quiz> getQuizzesByUserId(int user_id) {
		
		int quiz_id = 0;
		//int user_id = 0;
		int max_score = 0;
		boolean practice_mode = false;
		String description = "";
		String title = "";
		boolean random_question = false;
		boolean one_page = false;
		boolean immediate_correction = false;
		Timestamp created_timestamp = null;
		
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		
		try {
			Statement stmt = con.createStatement(); //construct search query based on inputs
			ResultSet rs = stmt.executeQuery("SELECT * FROM quizzes WHERE user_id="+user_id);
			while(rs.next()) {
				quiz_id = rs.getInt("quiz_id");
				//user_id = rs.getInt("user_id");
				max_score = rs.getInt("max_score");
				practice_mode = rs.getBoolean("practice_mode");
				description = rs.getString("description");
				title = rs.getString("title");
				random_question = rs.getBoolean("random_question");
				one_page = rs.getBoolean("one_page");
				immediate_correction = rs.getBoolean("immediate_correction");
				created_timestamp = rs.getTimestamp("created_timestamp");
				
				Quiz quiz = new Quiz(quiz_id, user_id, max_score, practice_mode, description, title, random_question, one_page, immediate_correction, created_timestamp);
				quizzes.add(quiz);
			}
		}
		catch(Exception e) {
			System.out.println(e);
		} 
		
		return quizzes;
	}
	
	public Quiz getQuizByQuizId(int quiz_id) {
		try{
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM quizzes WHERE quiz_id="+quiz_id);
		rs.next();
		Quiz quiz = new Quiz(rs.getInt("quiz_id"), rs.getInt("user_id"), rs.getInt("max_score"),
					rs.getBoolean("practice_mode"), rs.getString("description"), rs.getString("title"), 
					rs.getBoolean("random_question"), rs.getBoolean("one_page"), rs.getBoolean("immediate_correction"), 
					rs.getTimestamp("created_timestamp"));
		return quiz;
		} catch (SQLException e) {
			
		}
		return null;
	}
}
