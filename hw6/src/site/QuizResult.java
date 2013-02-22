package site;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;



/** Quiz result will be a static class that returns data 
 *  queried by webpages and other classes
 * 
 * */
public class QuizResult {
	/***/
	private static final String RESULT_DATABASE = "results";	

	private static Connection con;
	private static Statement stmt; 

	public QuizResult(){
		con = MyDB.getConnection();
		try {
			stmt = con.createStatement();
		} catch (SQLException e) {

		}

	}


	/**Returns a Result object given an ID
	 * 
	 * @param resultID integer ID of interest
	 * */
	public Result getResultFromID(int resultID){
		Result rs = null;
		String ID = Integer.toString(resultID);
		String execution = "SELECT * FROM " + RESULT_DATABASE + " WHERE result_id= '" +ID+ "'";  
		try {
			ResultSet set = stmt.executeQuery(execution);
			int taker = set.getInt(1);
			int rsId = set.getInt(2);
			int quiz = set.getInt(3);
			int score = set.getInt(4);
			int mxScore = set.getInt(5); 
			long dur =set.getLong(6);
			Date dt = set.getDate(7);
			rs = new Result(taker, rsId, quiz, score, mxScore, dt, dur);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}


	/** Returns an ordered set of Results/Strings containing past results that the 
	 *  user has gotten on a quiz. If an order is provided, the list will be sorted
	 *  by one of the fields
	 *  
	 *  Quiz summary asks for: date, percent correct, by amount of time the quiz took
	 */
	public void getUserPerformanceOnQuiz(){
		//TODO
	}

	/** Returns an ordered set of Results/Strings containing past results that the 
	 *  user has gotten on a quiz. If an order is provided, the list will be sorted
	 *  by one of the fields
	 *  
	 *  Quiz summary asks for: date, percent correct, by amount of time the quiz took
	 */
	public void getUserPerformanceOnQuiz(String order){
		//TODO
	}

	/** Returns a sorted ArrayList of Results for the highest scores for a quiz
	 * @param quizID integer ID number of quiz
	 * @param numUsers length of quiz 
	 * */
	public  ArrayList<Result> getBestQuizTakers(int quizID, int numUsers){
		return null;
	}

	/** Returns a sorted ArrayList of Results for the lowers scores for a quiz
	 * @param quizID integer ID number of quiz
	 * @param numUsers length of quiz 
	 * */
	public ArrayList<Result> getWorstQuizTakers(int quizID, int numUsers){
		return null;
	}

	/** Returns a sorted ArrayList of Results for the highest scores for a quiz
	 * in the last day
	 * @param quizID integer ID number of quiz
	 * @param numUsers length of quiz 
	 * */
	public  ArrayList<Result> getBestTakerslastDay(int quizID, int numUsers){
		return null;
	}
	
	/** Returns a sorted ArrayList of Results for the highest scores for a quiz
	 * in the last day
	 * @param quizID integer ID number of quiz
	 * @param numUsers length of quiz 
	 * */
	public  ArrayList<Result> getRecentTakers(int quizID, int numUsers){
		return null;
	}
	
	/** Returns a sorted ArrayList of Results for the highest scores for a quiz
	 * ever 
	 * @param quizID integer ID number of quiz
	 * @param numUsers length of quiz 
	 * */
	public  ArrayList<Result> getAllTimeBest(int quizID, int numUsers){
		return null;
	}
	
	/** Returns an ArrayList of doubles, with each double representing a different
	 * statistic 
	 * 
	 * Relevant Statistics by Index:
	 * 
	 * 0 - Number of users who have taken this quiz
	 * 1 - Number of times this quiz has been taken
	 * 2 - Average Percent Correct
	 * 3 - Best percent score
	 * 4 - Worst percent score
	 * 5 - Average time taken
	 * 6 - Longest time taken
	 * 7 - Shortest time taken
	 * 8 - Most recent play
	 * 9 - First date played
	 * 10 - Number of plays within the last day
	 * 
	 * @param quizID integer number of quiz
	 * @return DoubleList of statistics
	 * */
	public  ArrayList<Double> getStatistics(int quizID){
		return null;
	}
	
	private class Statistic{
		private double stat;
		private Date dt;
	}
	
	/**Give a new quizresult an ID that no other quiz has used
	 * If something goes wrong, gives a resultID of -1
	 * @return The number of results + 1
	 * */
	
	public static int getNewId() {	
		String execution = "SELECT * FROM " + RESULT_DATABASE;  
			try {
				ResultSet set = stmt.executeQuery(execution);
				set.last();
				return set.getRow() + 1;
			} catch (SQLException e) {
				
			}
		return -1;
			
	}
}