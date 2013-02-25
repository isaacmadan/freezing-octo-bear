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
	
	public QuizManager(HttpServletRequest request) {
		con = MyDB.getConnection();
		this.request = request;
		this.session = request.getSession();
		this.user_id = session.getAttribute(arg0);
	}
	
	public void addQuizToDataBase() {
		try {
			Statement stmt = con.createStatement(); //construct search query based on inputs
			ResultSet rs = stmt.executeQuery("SELECT * FROM quizzes WHERE user_id='"+user_id+"'");
			while(rs.next()) {
				
			}
		}
		catch(Exception e) {}
	}
	
	private void addQuestionResponseToDataBase() {
		
	}
	
}
