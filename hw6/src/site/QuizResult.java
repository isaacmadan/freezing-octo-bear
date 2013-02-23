package site;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;




/** QuizResult is a class that handles all SQL access to the results database
 * Which is the table of all quiz results. 
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

	
	/**Returns the most recent quiz a user has taken. Hopefully used for 
	 * the Quiz Results Page
	 * 
	 * @param userID int
	 * @param quizID int
	 * */
	public Result getLastQuiz(int userID, int quizID){
		Result rs = null;
		return rs;
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
	public static ArrayList<Result> getUserPerformanceOnQuiz(int userId, int quizID){
		ArrayList<Result> results = null;
		return results;
		//TODO
	}

	/** Returns an ordered set of Results/Strings containing past results that the 
	 *  user has gotten on a quiz. If an order is provided, the list will be sorted
	 *  by one of the fields
	 *  
	 *  Quiz summary asks for: date, percent correct, by amount of time the quiz took
	 */
	public static ArrayList<Result> getUserPerformanceOnQuiz(int userId, int quizId, String order){
		ArrayList<Result> results = null;
		return results;
		//TODO
	}

	/** Returns a sorted ArrayList of Results for the highest scores for a quiz
	 * @param quizID integer ID number of quiz
	 * @param numUsers length of quiz, if zero, return all 
	 * */
	public static ArrayList<Result> getBestQuizTakers(int quizID, int numUsers){
		return null;
	}

	/** Returns a sorted ArrayList of Results for the lowers scores for a quiz
	 * @param quizID integer ID number of quiz
	 * @param numUsers length of quiz, if zero, return all 
	 * */
	public static ArrayList<Result> getWorstQuizTakers(int quizID, int numUsers){
		return null;
	}

	/** Returns a sorted ArrayList of Results for the highest scores for a quiz
	 * in the last day
	 * @param quizID integer ID number of quiz
	 * @param numUsers length of quiz, if zero, return all  
	 * */
	public static ArrayList<Result> getBestTakerslastDay(int quizID, int numUsers){
		return null;
	}
	
	/** Returns a sorted ArrayList of Results for the highest scores for a quiz
	 * in the last day
	 * @param quizID integer ID number of quiz
	 * @param numUsers length of quiz, if zero, return all  
	 * */
	public static ArrayList<Result> getRecentTakers(int quizID, int numUsers){
		return null;
	}
	
	/** Returns a sorted ArrayList of Results for the highest scores for a quiz
	 * ever 
	 * @param quizID integer ID number of quiz
	 * @param numUsers length of quiz, if zero, return all  
	 * */
	public static ArrayList<Result> getAllTimeBest(int quizID, int numUsers){
		return null;
	}
	
	/**Returns a sorted ArrayList of Quizzes for the most popular quizzes
	 * 
	 * @param numQuizzes number of quizzes asked for, if zero, return all 
	 * */
	public static ArrayList<Quiz> getPopularQuizzes(int numQuizzes){
		return null;
	}
	
	/**Returns an ArrayList of quizzes sorted by time taken by a given user
	 * 
	 * @param userId id of user
	 * @param numQuizzes Number of quizzes asked for, if zero, return all
	 * */
	public static ArrayList<Quiz> getRecentQuizTakers(int userId, int numQuizzes){
		return null;
	}
	
	/**Returns an ArrayList of quizzes sorted by time created by a given user
	 * 
	 * @param userId id of user
	 * @param numQuizzes Number of quizzes asked for, if zero, return all
	 * */
	public static ArrayList<Quiz> getCreatedQuizzesByUser(int userId, int numQuizzes){
		return null;
	}
	
	/**Returns an ArrayList of quizzes created by anybody, sorted by time 
	 * 
	 * @param numQuizzes Number of quizzes asked for, if zero, return all
	 * */
	public static ArrayList<Quiz> getRecentlyCreated(int numQuizzes){
		return null;
	}
	
	/**Returns an ArrayList of quizzes taken by friends of a given user, sorted by time 
	 * 
	 * @param numQuizzes Number of quizzes asked for, if zero, return all
	 * */
	public static ArrayList<Quiz> getFriendQuizzes(int userId, int numQuizzes){
		return null;
	}
	
	/**Returns the number of quizzes that a given user has taken
	 * Returns -1 on failure
	 * @param userId integer ID
	 * */
	public static int numTaken(int userId){
		return -1;
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
	public static ArrayList<Double> getNumericStatistics(int quizID){
		return null;
	}
	
	/** Returns an ArrayList of Dates, with each Date representing a different
	 * statistic 
	 * 
	 * Relevant Statistics by Index:
	 * 0 - Most recent play
	 * 1 - First date played
	 * 2 - Number of plays within the last day
	 * 
	 * @param quizID integer number of quiz
	 * @return DateList of statistics
	 * */
	
	public static ArrayList<Date> getDateStatistics(int quizID){
		return null;
	}
	
	/**Give a new quizresult an ID that no other quiz has used
	 * If something goes wrong, gives a resultID of -1
	 * @return The number of results + 1
	 * */
	
	public  static int getNewId() {	
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