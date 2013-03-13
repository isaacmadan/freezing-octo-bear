package site;

import java.sql.SQLException;


/** Allows users to report quizzes as inappropriate and also give a complaint message
	public final int reportId;
	public final int userId;
	public final int quizId;
	public final String text;
	public final Timestamp time;

 * */
public class ReportManager {

	public ReportManager(){
	con = MyDB.getConnection();
	try {
		stmt = con.createStatement();
	} catch (SQLException e) {

	}

}
