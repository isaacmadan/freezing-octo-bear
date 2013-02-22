package site;

import java.sql.Date;

/**Result encapsulates all the fields relevant to a single quiz result
 * */
public class Result {
	public final int resultId;
	public final int userId;
	public final int quizId;
	public final int pointsScored;
	public final int maxPossiblePoints;
	public final Date timeStamp;
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
	
	/**Constructs an old Result, doesn't ask for a resultID*/
	public Result(int takerID, int rsId, int quizID, int pointsScored,int maxPointsPossible, Date timeTaken, long duration){
		this.resultId = rsId;
		this.userId = takerID;
		this.quizId = quizID;
		this.pointsScored = pointsScored;
		this.maxPossiblePoints = maxPointsPossible;
		this.timeStamp = timeTaken;
		this.durationOfQuiz = duration;
	}
	
}
