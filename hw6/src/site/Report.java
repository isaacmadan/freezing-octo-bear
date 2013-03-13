package site;

import java.sql.Timestamp;

/**Allows users to flag as inappropriate*/
public class Report extends Object {

	public final int reportId;
	public final int userId;
	public final int quizId;
	public final String text;
	public final Timestamp time;

	public Report(int report, int user, int quiz, String text, Timestamp timestamp){
		this.reportId = report;
		this.userId = user;
		this.quizId = quiz;
		this.text = text;
		this.time = timestamp;
	}
	
	public String dateString(){
		return  java.text.DateFormat.getDateTimeInstance().format(
				this.time);
	}
	
}