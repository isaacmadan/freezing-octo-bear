package site;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;


/**Admin Control allows an admin to do bunch of things to people's stuff without them asking
 * Admin Control does not check if the user is an admin. The caller to AdminControl should check beforehand
 * 
 * */


public class AdminControl {

	private static Connection con;
	private static Statement stmt; 

	public AdminControl(){
		con = MyDB.getConnection();
		try {
			stmt = con.createStatement();
		} catch (SQLException e) {

		}
	}

	
	/**Adds an announcement to the announcements list*/
	public static void AddAnouncement(int userId, String text){
		String execution = "INSERT INTO announcements value(NULL," + userId + ",'"+text+"',NOW())";
		try {
			stmt.executeUpdate(execution);
		} catch (SQLException e) {
		}
	}



	/**Returns an ArrayList of Announcements ordered by date created
	 * Pass it a limit!
	 * */
	
	public static ArrayList<Announcement> getAnnouncements(int limit){
		String execution = "SELECT * FROM announcements ORDER BY created_timestamp DESC LIMIT 0," + limit;
		ArrayList<Announcement> result = new ArrayList<Announcement>();
		try {
			ResultSet set = stmt.executeQuery(execution);
			set.last();
			int numRows = set.getRow();
			for (int i = 1; i <= numRows; i ++){
				set.absolute(i);
				result.add(generateAnnouncement(set));
			}
			return result;
		} catch (SQLException e) {
		}
		return null;
	}

	private static Announcement generateAnnouncement(ResultSet set){
		try {
			int userId = set.getInt("user_id");
			String text = set.getString("string");
			Timestamp time = set.getTimestamp("created_timestamp");
			return new Announcement(userId, text, time);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new Announcement(-1,"FailedRetrievalofAnnouncement",new Timestamp(0));
	}


	/**Removes an account and EVERYTHING associated with it. 
	 * Removes all quizzes created by that user
	 * Removes all results taken by those quizzes
	 * Removes all questions and answers associated with that stuff
	 * Returns true if successful and false if anything goes wrong. Also has a high chance of
	 * quitting with the database in terrible condition
	 * */
	
	public static boolean removeAccount(int userId){	
		return false;
	}

	/**Remove quiz removes a quiz and all results and questions associated with it*/
	public static boolean removeQuiz(int quizId){
		return false;
	}

	/**Clears all the results associated with a quizId. This will not affect user achievements
	 * returns true on working, returns false
	 * */
	public static boolean clearQuizHistory(int quizId){
		String execution = "DELETE FROM results WHERE quiz_id = " + quizId;
		try {
			stmt.executeUpdate(execution);
			return true;
		} catch (SQLException e) {
			return false;
		}
	}

	/**Makes a user an admin and sends them a message telling them so
	 * Returns true if successful, returns false if userId is not a valid Id
	 * or something else goes wrong
	 * 
	 * */
	public static boolean promoteToAdmin(int adminId, int userId){
		String execution = "UPDATE users SET is_admin = TRUE WHERE user_id = " + userId;
		try {
			AccountManager manager = new AccountManager();
			if (!manager.isExistingAccountById(Integer.toString(userId))) return false; 
			stmt.executeUpdate(execution);
			String name = manager.getAccountById(Integer.toString(adminId)).getUsername();
			String message = "Congratulations, you have been promoted to an admin by " + name + "\n You can now modify quizzes, other user accounts and more!";
			User admin = manager.getAccountById(Integer.toString(adminId));
			User user = manager.getAccountById(Integer.toString(userId));
			Inbox.sendTextMessage(new TextMessage(admin, user, 3, message));
			return true;
		} catch (SQLException ignored) {	}		
		return false;
	}

	/**Returns a bunch of stats in an arraylist of objects.
	 * Most of them will be -1 on failure
	 * 0 - Integer - number of users
	 * 1 - Integer - number of quizzes
	 * 2 - Integer - number of quizzes taken
	 * 3 - User - User object of most something user
	 * 
	 * 
	 * */

	public static ArrayList<Integer> getStatistics(){
		ArrayList<Integer> stats = new ArrayList<Integer>();
		stats.add(getUserCount());
		stats.add(getQuizCount());
		stats.add(getResultCount());
		return null;
	}

	private static int getUserCount(){
		String execution = "SELECT COUNT(*) FROM users";
		try {
			ResultSet set = stmt.executeQuery(execution);
			set.first();
			return set.getInt(1);
		} catch (SQLException ignored) {}
		return -1;
	}
	
	private static int getQuizCount(){
		String execution = "SELECT COUNT(*) FROM quizzes";
		try {
			ResultSet set = stmt.executeQuery(execution);
			set.first();
			return set.getInt(1);
		} catch (SQLException ignored) {}
		return -1;	
	}
	
	private static int getResultCount(){
		String execution = "SELECT COUNT(*) FROM results";
		try {
			ResultSet set = stmt.executeQuery(execution);
			set.first();
			return set.getInt(1);
		} catch (SQLException ignored) {}
		return -1;	
	}
	
	
	
}


