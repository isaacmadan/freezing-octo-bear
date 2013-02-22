package site;

import java.sql.Connection;



/** Quiz result will be a static class that returns data 
 *  queried by webpages and other classes
 * 
 * */
public class QuizResult {
/***/
	
	
	
	
	private Connection con;
	
	
	public QuizResult(){
		con = MyDB.getConnection();
	}
	
	/** Returns an ordered set of Results/Strings containing
	 *  
	 * 
	 * */
	
	public void getUserPerformanceOnQuiz(String orderType){
		//TODO
	}

	/**Give a new quizresult an ID that no other quiz has used*/
	public static int getNewId() {
		// TODO 
		return 0;
	}
	
	
}
