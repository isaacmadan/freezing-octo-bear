package site;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashSet;

public class Answer {

	private HashSet<String> answers;
	
	public Answer() {
		answers = new HashSet<String>();
	}
	
	public Answer(String strToSplit, String symbol) {
		String[] result = strToSplit.split(symbol);
		answers = new HashSet<String>();
		for(int i = 0; i < result.length; i++) {
			answers.add(result[i]);
		}
	}
	
	public Answer(HashSet<String> answers) {
		this.setAnswers(answers);
	}
	
	public boolean contains(String response) {
		if(answers.contains(response)) return true;
		return false;
	}

	public void addAnswer(String str) {
		answers.add(str);
	}
	
	public void removeAnswer(String str) {
		answers.remove(str);
	}
	
	public HashSet<String> getAnswers() {
		return answers;
	}

	public void setAnswers(HashSet<String> answers) {
		this.answers = answers;
	}
	
	public static Answer getAnswerForQuestion(int questionID){
			Connection con = MyDB.getConnection();
			try {
				Statement stmt = con.createStatement();
				String execution = "Select * from answers WHERE question_id = " + Integer.toString(questionID);
				ResultSet set = stmt.executeQuery(execution);
				set.first();
				Answer result = (new Answer(set.getString("string"),","));
				MyDB.close();
				return result;
			} catch (SQLException e) {
				MyDB.close();
				return (new Answer("FailedQuery"," "));
			}
			
		}
}
