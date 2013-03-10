package site;

import java.sql.Connection;
import java.sql.ResultSet;
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
	private static Connection con;
	private static Statement stmt;

	public AnswerLog(){
		con = MyDB.getConnection();
		try {
			stmt = con.createStatement();
		} catch (SQLException e) {

		}
	}


	/**Adds an answer to the database of answers
	 * returns false on some kind of failure, of which kinds there could be many.
	 * 
	 * */
	public static boolean storeUserAnswer(int questionId, int quizId, int resultId, String answer) {
		String execution = "INSERT INTO user_answers VALUES(" + resultId + "," + quizId + "," + questionId + ",'" + answer + "')"; 
		System.out.println(execution);
		try {
			stmt.executeUpdate(execution);
			return true;
		} catch (SQLException e) {
		}
		return false;
	}

	/**Returns only the text portion of the answers and questionId for a given result Id.
	 * userAnswer.questionId gets the id
	 * userAnswer.text = gets text
	 * */
	
	public static ArrayList<UserAnswer> getUserAnswers(int result_id){
		ArrayList<UserAnswer> ans = new ArrayList<UserAnswer>();
		String execution = "SELECT * FROM user_answers WHERE result_id = " + result_id;
		try {
			ResultSet set = stmt.executeQuery(execution);
			while(set.next()){
				ans.add(getUserAnswer(set));
			}
			return ans;
		} catch (SQLException e) {
		}
		return null;
	}
	
	
	
/**Returns a UserAnswer object for a set already on the row with the user_answer*/
	private static UserAnswer getUserAnswer(ResultSet set){
	
		try {
			int id = set.getInt("question_id");
			String text = set.getString("string");
			return new UserAnswer(id, text);
		} catch (SQLException e) {
			return new UserAnswer(-1, "FailedRetrieval");
		}
	}

}