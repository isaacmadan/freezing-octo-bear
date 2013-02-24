package site;

import java.sql.Connection;

public class QuizManager {

	private Connection con;
	
	public QuizManager() {
		con = MyDB.getConnection();
	}
	
	public void addQuizToDataBase() {
		
	}
	
}
