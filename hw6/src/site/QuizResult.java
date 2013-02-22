package site;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;



/** Quiz result will be a static class that returns data 
 *  queried by webpages and other classes
 * 
 * */
public class QuizResult {
/***/
	private static final String RESULT_DATABASE = "results";	
	
	private Connection con;
	private Statement stmt; 
	
	public QuizResult(){
		con = MyDB.getConnection();
		try {
			stmt = con.createStatement();
		} catch (SQLException e) {
			
		}
		
	}
	
	
	
	public Result getResultFromID(int resultID){
		Result rs = null;
		String ID = Integer.toString(resultID);
		String execution = "SELECT * FROM " + RESULT_DATABASE + " WHERE result_id= '" +ID+ "'";  
		try {
			ResultSet set = stmt.executeQuery(execution);
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		
		
		return rs;
	}
	
	
	/** Returns an ordered set of Results/Strings containing past results that the 
	 *  user has gotten on a quiz
	 *
	 * Throws some kind of exception when set is not found?
	 * */
	
	public void getUserPerformanceOnQuiz(){
		//TODO
	}

	/**Give a new quizresult an ID that no other quiz has used*/
	public static int getNewId() {
		// TODO 
		return 0;
	}
	
	
}
