package site;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;


public class Search {

	public Search() {
		// TODO Auto-generated constructor stub
	}
	
	public static ArrayList<User> searchUsers(String inputQuery) {
		Connection con = MyDB.getConnection();
		ArrayList<User> users = new ArrayList<User>();
		
		try {
			Statement stmt = con.createStatement(); //construct search query based on inputs
			ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE MATCH (username) AGAINST ('"+inputQuery+"' IN NATURAL LANGUAGE MODE)");
			while(rs.next()) {
				int id = rs.getInt("user_id");
				String username = rs.getString("username");
				String password = rs.getString("password");
				boolean isAdmin = rs.getBoolean("is_admin");
				int loginCount = rs.getInt("login_count");
				User user = new User(id,username,password,isAdmin,loginCount);
				users.add(user);
			}
		}
		catch(Exception e) { System.out.println(e); } 
		
		return users;
	}
	
	public static ArrayList<Quiz> searchQuizzes(String inputQuery) {
		Connection con = MyDB.getConnection();
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();
		
		try {
			Statement stmt = con.createStatement(); //construct search query based on inputs
			ResultSet rs = stmt.executeQuery("SELECT * FROM quizzes WHERE MATCH (title,description) AGAINST ('"+inputQuery+"' IN NATURAL LANGUAGE MODE)");
			while(rs.next()) {
				int quizId = rs.getInt("quiz_id");
				int userId = rs.getInt("user_id");
				int maxScore = rs.getInt("max_score");
				boolean practiceMode = rs.getBoolean("practice_mode");
				String title = rs.getString("title");
				String description = rs.getString("description");
				boolean randomQuestion = rs.getBoolean("random_question");
				boolean onePage = rs.getBoolean("one_page");
				boolean immediateCorrection = rs.getBoolean("immediate_correction");
				Timestamp createdTimestamp = rs.getTimestamp("created_timestamp");
				
				Quiz quiz = new Quiz(quizId,userId,maxScore,practiceMode,title,description,randomQuestion,onePage,immediateCorrection,createdTimestamp);
				quizzes.add(quiz);
			}
		}
		catch(Exception e) { System.out.println(e); } 
		
		return quizzes;
	}
 
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
