package site;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;




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
		System.out.println("Initialized connection");
	}
	/**Adds a result to the SQL results database, either by passing in a bunch of parameters
	 * Or first generating a Result and passing it in. 
	 * 
	 * The first type takes care of the timestamp and other things by itself
	 * 
	 * How do you add dates to an sql?
	 * These are not functional yet, because I don't know how dates work yet
	 * 
	 * */
	public static void addResult(int quizTakerId, int quizId, int pointsScored, int maxPossiblePoints, long duration ){
		String execution = "INSERT INTO " + RESULT_DATABASE + " VALUES('"+quizTakerId+"', '"+getNewId()+
				"', '"+quizId+"', '"+pointsScored+"', '"+maxPossiblePoints+"', '"+duration+"', NOW()";  
		try {
			stmt.executeUpdate(execution);
		} catch (SQLException e) {
			System.out.print("Failed result addition");
		}
	}

	public static void addResult(Result r){
		String execution = "INSERT INTO " + RESULT_DATABASE + " VALUES('"+r.userId+"', '"+r.resultId+
				"', '"+r.quizId+"', '"+r.pointsScored+"', '"+r.maxPossiblePoints+"', '"+r.durationOfQuiz+"', '"+r.timeStamp+"'";  
		try {
			stmt.executeUpdate(execution);
		} catch (SQLException e) {
			System.out.print("Failed result addition");
		}
	}

	/**Call to see if the quizresult database is empty
	 * True if empty, false if not
	 * */
	public static boolean isEmpty(){
		try {
			ResultSet set = stmt.executeQuery("SELECT * FROM " + RESULT_DATABASE);
			if (!set.next()){
				return true;
			}
			return false;
		} catch (SQLException e) {
		}
		return true;
	}

	/**Generates a Result from a given ResultSet set to a given row
	 * Remember that ResultSets start at index 1
	 * */
	private static Result generateResult(ResultSet set, int row){
		Result result = null;

		try{
			set.absolute(row);
			int taker = set.getInt(1);
			int rsId = set.getInt(2);
			int quiz = set.getInt(3);
			int score = set.getInt(4);
			int mxScore = set.getInt(5); 
			long dur =set.getLong(6);
			Timestamp dt = set.getTimestamp(7);
			result = new Result(taker, rsId, quiz, score, mxScore, dt, dur);
		} catch (SQLException ignored){

		}
		return result;
	}
	
	/**Give it a sql string and this will return an ArrayList*/
	private static ArrayList<Result> generateList(String execution){
		ArrayList<Result> results = new ArrayList<Result>();
		ResultSet set;
		try {
			set = stmt.executeQuery(execution);
			while(set.next()){
				results.add(generateResult(set, set.getRow()));
			}
		} catch (SQLException e) {}
		return results;
	}

	/**Returns the most recent quiz a user has taken. Hopefully used for 
	 * the Quiz Results Page
	 * 
	 * @param userID int
	 * @param quizID int
	 * */
	public static Result getLastQuiz(int userID, int quizID){
		Result rs = null;
		return rs;
	}

	/**Returns a Result object given an ID
	 * 
	 * @param resultID integer ID of interest
	 * */
	public static Result getResultFromID(int resultID){
		Result rs = null;
		String ID = Integer.toString(resultID);
		String execution = "SELECT * FROM " + RESULT_DATABASE + " WHERE result_id= '" +ID+ "'";  
		System.out.println(execution);
		try {
			ResultSet set = stmt.executeQuery(execution);
			set.first();
			int taker = set.getInt(1);
			int rsId = set.getInt(2);
			int quiz = set.getInt(3);
			int score = set.getInt(4);
			int mxScore = set.getInt(5); 
			long dur =set.getLong(6);
			Timestamp dt = set.getTimestamp(7);
			rs = new Result(taker, rsId, quiz, score, mxScore, dt, dur);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}


	/** Returns an ordered set of Results/Strings containing past results that the 
	 *  user has gotten on a quiz. If an order is provided, the list will be sorted
	 *  by one of the fields. Returns newest first, highest first, longest first
	 *  
	 *  Quiz summary asks for: date, percent correct, by amount of time the quiz took
	 *  @param userId
	 *  @param quizID
	 *  @param order - "BY_DATE" - "BY_SCORE" - "BY_DURATION". If none of the above then orders by date 
	 */
	public static ArrayList<Result> getUserPerformanceOnQuiz(int userId, int quizID){
		String execution = "SELECT * FROM " + RESULT_DATABASE + " WHERE user_id = " + userId + " AND quiz_id = " + quizID +
				"  ORDER BY created_timestamp DESC";
		ArrayList<Result> results = generateList(execution);
//		System.out.println(results.toString());
		return results;
	}

	
	public static ArrayList<Result> getUserPerformanceOnQuiz(int userId, int quizId, String order){
		ArrayList<Result> results = new ArrayList<Result>();
		String selectedOrder = "created_timestamp";
		if (order.equals("BY_SCORE")){
			String execution = "SELECT * FROM " + RESULT_DATABASE + " WHERE user_id = " + userId + " AND quiz_id = " + quizId;
			results = generateList(execution);
			Collections.sort(results, new SortByBestScore());
			return results;
				//System.out.println(results.toString());
		}
		//if (order.equals("BY_DATE")) selectedOrder = "created_timestamp";
		if (order.equals("BY_DURATION")) selectedOrder = "duration";
		String execution = "SELECT * FROM " + RESULT_DATABASE + " WHERE user_id = " + userId + " AND quiz_id = " + quizId +
				"  ORDER BY "+ selectedOrder + " DESC";
		results = generateList(execution);
		return results;
	}

	/**Sort by score first looks at higher score, then shorter duration*/
	private static class SortByBestScore implements Comparator<Result>{
		public int compare(Result a, Result b){
			double scoreA = a.pointsScored / (double) a.maxPossiblePoints;
			double scoreB = b.pointsScored / (double) b.maxPossiblePoints;
			if (scoreA > scoreB) return -1;
			if (scoreA < scoreB) return 1;

			long durA = a.durationOfQuiz;
			long durB = b.durationOfQuiz;
			if (durA < durB) return -1;
			if (durA > durB) return 1;
			return 0;
		}
	}
	//TODO make sure the sorting is in the correct direction
	/**Sort by lowest score, then longest duration*/
	private static class SortByWorstScore implements Comparator<Result>{
		public int compare(Result a, Result b){
			double scoreA = a.pointsScored / (double) a.maxPossiblePoints;
			double scoreB = b.pointsScored / (double) b.maxPossiblePoints;
			if (scoreA > scoreB) return 1;
			if (scoreA < scoreB) return -1;
			long durA = a.durationOfQuiz;
			long durB = b.durationOfQuiz;
			if (durA < durB) return 1;
			if (durA > durB) return -1;
			return 0;
		}
	}
	
	private static ArrayList<Result> sublist(int indexStart, int indexEnd, ArrayList<Result> result){
		ArrayList<Result> results = new ArrayList<Result>();
		for(int i = indexStart; i < indexEnd; i ++){
			results.add(result.get(i));
		}
		return results;
	}
	
	/** Returns a sorted ArrayList of Results for the highest scores for a quiz
	 * @param quizID integer ID number of quiz
	 * @param numUsers length of quiz, if zero, return all 
	 * */
	public static ArrayList<Result> getBestQuizTakers(int quizID, int numUsers){
		String execution = "SELECT * FROM " + RESULT_DATABASE + " WHERE quiz_id = " + quizID;
		ArrayList<Result> results = generateList(execution);
		Collections.sort(results, new SortByBestScore());
		if (numUsers > 0){
			return sublist(0, numUsers, results);
		}
		//System.out.println(results.toString());
		return results;
	}

	/** Returns a sorted ArrayList of Results for the lowers scores for a quiz
	 * @param quizID integer ID number of quiz
	 * @param numUsers length of quiz, if zero, return all 
	 * */
	public static ArrayList<Result> getWorstQuizTakers(int quizID, int numUsers){
		String execution = "SELECT * FROM " + RESULT_DATABASE + " WHERE quiz_id = " + quizID;
		ArrayList<Result> results = generateList(execution);
		Collections.sort(results, new SortByWorstScore());
		if (numUsers > 0){
			return sublist(0, numUsers, results);
		}
		//System.out.println(results.toString());
		return results;
	}

	/**Removes all entries from more than a 24 hours ago*/
	private static ArrayList<Result> prunedLastDay(ArrayList<Result> results){
		 ArrayList<Result> newResults = new  ArrayList<Result> ();
		java.util.Date now = new java.util.Date();
		Timestamp stamp =  new Timestamp(now.getTime());
		for(int i = 0; i < results.size(); i ++){
			if (results.get(i).timeStamp.after(stamp)) newResults.add(results.get(i));
		}
		return newResults;
	}

	
	/** Returns a ArrayList of Results for a quiz in the last day WITH no repeated users.
	 *  Sorted by date
	 * @param quizID integer ID number of quiz
	 * @param numUsers length of quiz, if zero, return all  
	 * */
	public static ArrayList<Result> getRecentTakers(int quizID, int numUsers){
		String execution = "SELECT * FROM " + RESULT_DATABASE + " WHERE quiz_id = " + quizID
				+ " ORDER BY created_timestamp";
		ArrayList<Result> results = generateList(execution);
		results = prunedLastDay(results);
		if (numUsers > 0){
			return sublist(0, numUsers, results);
		}
		return null;
	}

	/** Returns a sorted ArrayList of Results for the highest scores for a quiz
	 * in the last day, WITH repeated users. Sorted by score
	 * @param quizID integer ID number of quiz
	 * @param numUsers length of quiz, if zero, return all  
	 * */
	public static ArrayList<Result> getRecentHighScores(int quizID, int numUsers){
		String execution = "SELECT * FROM " + RESULT_DATABASE + " WHERE quiz_id = " + quizID;
		ArrayList<Result> results = generateList(execution);
		results = prunedLastDay(results);
		Collections.sort(results, new SortByBestScore());
		if (numUsers > 0){
			return sublist(0, numUsers, results);
		}
		return null;
	}

	/** Returns a sorted ArrayList of Results for the highest scores for a quiz
	 * ever 
	 * @param quizID integer ID number of quiz
	 * @param numUsers length of quiz, if zero, return all  
	 * */
	public static ArrayList<Result> getAllTimeBest(int quizID, int numUsers){
		String execution = "SELECT * FROM " + RESULT_DATABASE + " WHERE quiz_id = " + quizID;
		ArrayList<Result> results = generateList(execution);
		Collections.sort(results, new SortByBestScore());
		if (numUsers > 0){
			return sublist(0, numUsers, results);
		}
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