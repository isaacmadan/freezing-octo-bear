package site;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class QuizManager {

	private Connection con;
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
	
	public QuizManager(HttpServletRequest request) {
		con = MyDB.getConnection();
		this.request = request;
		this.session = request.getSession();
		this.user_id = ((User)session.getAttribute("user")).getId();
		this.practice_mode = (Boolean) request.getAttribute("practice_mode");
		this.description = (String)request.getAttribute("quiz_description");
		this.title = (String)request.getAttribute("quiz_title");
		this.max_score = Integer.parseInt((String)request.getAttribute("max_score"));
		this.random_question = (Boolean) request.getAttribute("random_question");
		this.one_page = (Boolean) request.getAttribute("one_page");
		this.immediate_correction = (Boolean) request.getAttribute("immediate_correction");
	}
	
	public void addQuizToDataBase() {
		try {
			Statement stmt = con.createStatement();
			stmt.executeQuery("INSERT INTO quizzes (user_id, practice_mode, description, title, max_score," +
					"random_question, one_page, immediate_correction) VALUES(" + user_id + "," + practice_mode + "," +
					description + "," + title + "," + max_score + "," + random_question + "," + one_page + "," + immediate_correction + ");");
			if(request.getParameter("question_response_count") != null) addQuestionResponseToDataBase();
			if(request.getParameter("fill_in_the_blank_count") != null) addFillInTheBlankToDataBase();
			if(request.getParameter("multiple_choice_count") != null) addMultipleChoiceToDataBase();
			if(request.getParameter("picture_response_count") != null) addPictureResponseToDataBase();
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
	
}
