package site;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

/**Manages code relating to adding, removing, and retrieving reviews from the database*/
public class ReviewManager {
	private static Connection con;
	private static Statement stmt;

	public  ReviewManager(){
		con = MyDB.getConnection();
		try {
			stmt = con.createStatement();
		} catch (SQLException e) {
		}		
	}
	
	
	/**Checks if a user even took a quiz. Users should only review quizzes if they've taken them*/
	public static boolean tookQuiz(int user_id, int quiz_id){
		new QuizResult();
		if (QuizResult.getUserPerformanceOnQuiz(user_id, quiz_id).size() > 0) return true;
		return false;
	}
	
	/**Adds a review to the database, returns the Review Id that was just stored
	 * @param user userId
	 * @param quiz quizId
	 * @param text reviewString
	 * @param score reviewScore
	 * */
	public static int addReview(int user, int quiz, String text, int score){
		String execution = "INSERT INTO reviews VALUES( NULL," + user + "," + quiz + ", '" + text + "'," + score + ",NOW())";
		String execution2 = "SELECT LAST_INSERT_ID()";
		try {
			stmt.executeUpdate(execution);
			ResultSet set = stmt.executeQuery(execution2);
			set.first();
			return set.getInt("LAST_INSERT_ID()");
		} catch (SQLException e) {
		}
		return -1;
	}
	
	/**Returns an arraylist of Review Objects for a given quizId in terms of most recent reviews written*/
	public static ArrayList<Review> getReviews(int quizId){
		String execution = "SELECT * FROM reviews WHERE quiz_id = " + quizId + " ORDER BY created_timestamp DESC";
		ArrayList<Review> reviews = new ArrayList<Review>();
		
		try {
			ResultSet set = stmt.executeQuery(execution);
			while(set.next()){
				reviews.add(getReviewFromSet(set));
			}
			return reviews;
		} catch (SQLException e) {
		}
		return reviews;
	}
	
	/**Returns an arraylist of Review Objects written by a user*/
	public static ArrayList<Review> getReviewsByUser(int user_id){
		String execution = "SELECT * FROM reviews WHERE user_id = " + user_id;
		ArrayList<Review> reviews = new ArrayList<Review>();
		
		try {
			ResultSet set = stmt.executeQuery(execution);
			while(set.next()){
				reviews.add(getReviewFromSet(set));
			}
			return reviews;
		} catch (SQLException e) {
		}
		return reviews;
	}
	/**Assumes Set is looking at the relevant row and returns a Review Object*/
	private static Review getReviewFromSet(ResultSet set){
		try {
			int review = set.getInt("review_id");
			int user = set.getInt("user_id");
			int quiz = set.getInt("quiz_id");
			String text = set.getString("string");
			int score = set.getInt("review_score");
			Timestamp time = set.getTimestamp("created_timestamp");
			return new Review(review, user, quiz, text, score, time);
		} catch (SQLException e) {
		}
		return null;
	}
	
	/**Removes all reviews associated with a quiz*/
	public static boolean clearReviewsByQuiz(int quiz_id){
		String deleteQuiz = "DELETE FROM reviews where quiz_id = " + quiz_id;
		try {
			stmt.executeUpdate(deleteQuiz);
			return true;
		} catch (SQLException e) {
			return false;
		}
	}
	
	/**Removes all reviews associated with a user*/
	public static boolean clearReviewsByUser(int user_id){
		String deleteQuiz = "DELETE FROM reviews where user_id = " + user_id;
		try {
			stmt.executeUpdate(deleteQuiz);
			return true;
		} catch (SQLException e) {
			return false;
		}
	}
	
	/**Pass in a list of ratings and get its score*/
	public static double getAverageRating(ArrayList<Review> reviews){
		double totalScore = 0;
		double scoreCount = 0;
		for (Review rev: reviews){
			totalScore += rev.review_score;
			scoreCount++;
		}
		return totalScore / scoreCount;
	}
	
}