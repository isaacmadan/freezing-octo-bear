package site;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.concurrent.TimeUnit;

/**Result encapsulates all the fields relevant to a single quiz result. All fields
 * are final and can be accessed publicly. 
 * */
public class Result extends Object{
	public final int resultId;
	public final int userId;
	public final int quizId;
	public final int pointsScored;
	public final int maxPossiblePoints;
	public final java.sql.Timestamp timeStamp;
	public final long durationOfQuiz;

	/**Constructs a new Result, doesn't ask for a resultID*/
	public Result(int takerID, int quizID, int pointsScored,int maxPointsPossible, Timestamp timeTaken, long duration){
		this.resultId = 0;
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
	public Result(int takerID, int rsId, int quizID, int pointsScored,int maxPointsPossible, Timestamp timeTaken, long duration){
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
		str += " \n";
		return str;
	}

	/**Returns a formatted date string from a Result*/
	public String dateString(){
		  
		 DateFormat formatter = new SimpleDateFormat ("MM/dd/yy hh:mm aa");
		 
		 return formatter.format(this.timeStamp);
		    
//		return  java.text.DateFormat.getDateTimeInstance().format(
//				this.timeStamp);
	}
	
	public String durationString(){
		long millis = this.durationOfQuiz;
		String dur = String.format("%d min, %d sec", 
			    TimeUnit.MILLISECONDS.toMinutes(millis),
			    TimeUnit.MILLISECONDS.toSeconds(millis) - 
			    TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(millis))
			);
		return dur;
	}

}
