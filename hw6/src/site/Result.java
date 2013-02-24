package site;

import java.sql.Date;

/**Result encapsulates all the fields relevant to a single quiz result
 * */
public class Result extends Object{
	public final int resultId;
	public final int userId;
	public final int quizId;
	public final int pointsScored;
	public final int maxPossiblePoints;
	public final java.sql.Date timeStamp;
	public final long durationOfQuiz;
	
	/**Constructs a new Result, doesn't ask for a resultID*/
	public Result(int takerID, int quizID, int pointsScored,int maxPointsPossible, Date timeTaken, long duration){
		this.resultId = QuizResult.getNewId();
		this.userId = takerID;
		this.quizId = quizID;
		this.pointsScored = pointsScored;
		this.maxPossiblePoints = maxPointsPossible;
		this.timeStamp = timeTaken;
		this.durationOfQuiz = duration;
	}
	
	/**Constructs an old Result, give it the old id
	 * If you want a copy of a Result, use QuizResult.getResult(ID);
	 * 
	 * 
	 * */
	public Result(int takerID, int rsId, int quizID, int pointsScored,int maxPointsPossible, Date timeTaken, long duration){
		this.resultId = rsId;
		this.userId = takerID;
		this.quizId = quizID;
		this.pointsScored = pointsScored;
		this.maxPossiblePoints = maxPointsPossible;
		this.timeStamp = timeTaken;
		this.durationOfQuiz = duration;
	}
	
	@Override
	public String toString() {
		String str = "Result: "+ this.resultId + " User: " + this.userId; 
		str += " QuizId: " + this.quizId;
		str += " Points: " + this.pointsScored;
		str += " MaxPoints: " + this.maxPossiblePoints;
		str += " Duration: " + this.durationOfQuiz;
		return str;
	}

	/**Returns a formatted date string from a Result*/
	public String dateString(){
		return "NOt implemented yet";
	}
	
}
