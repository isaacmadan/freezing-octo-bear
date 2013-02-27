package site;

import java.util.ArrayList;

/** AnswerLog is responsible for querying the database and generating all of the answers for a given quiz id
 * As well as storing the user given answers 
 * 
 */
public class AnswerLog extends Object{
	private ArrayList<Answer> realAnswers;
	private ArrayList<String> givenAnswers;
	
	
	
	private static final long serialVersionUID = 1L;

	public AnswerLog(){
		super();
		
	}
	
}
