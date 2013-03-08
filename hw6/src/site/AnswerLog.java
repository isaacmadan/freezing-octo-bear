package site;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/** AnswerLog is responsible for querying the database and generating all of the answers for a result id
 * As well as storing the user given answers 
 * 
 * 
 * There needs to be a link between the answers and a particular result. This one is hard....
 * 
 * I can have them reserve a result_id which will be updated later, but then if something else reads that result_id then it's screwed
 * 
 * How bout there is a function that takes all the answers at the end of a thing and appends them to a resultId?. It will be a metatag
 * that other calls to the database should not read
 * 
 * I think the taker code needs to keep track of some variable
 * 
 * 
 * Magic code- taker only adds stuff to answerLog
 * 
 */
public class AnswerLog{

	/*user_answers (
			result_id INT,
			question_id INT,
			string TEXT,
			correct BOOLEAN default FALSE*/
	
	public AnswerLog(){
		Connection con = MyDB.getConnection();
		Statement stmt;
		try {
			stmt = con.createStatement();
		} catch (SQLException e) {

		}
	}
	
	public static void cacheUserAnswer(int questionId, int userId, int resultId, String answer) {
		
	}
	
	/***/
	public static ArrayList<String> getUserAnswers(int result_id){
		ArrayList<Answer> ans = null;
		
		return null;
		
	}
	
	private static String getUserAnswer(Statement stmt){
		return "";
	}
	
}