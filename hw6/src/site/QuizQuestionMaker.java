package site;

import java.sql.Connection;
import java.sql.Statement;

/**QuizQuestionMaker is responsible for all database updating relating to making a quiz
 * QuizQuestionMaker also keeps a stored within in all the various fields and questions related to a quiz.
 * 
 * 
 * Quizzes are created by make_quiz and added to the session variable 
 * Questions are created by making_quiz and added to the quizquestionmaker
 * On completing a quiz everything in that quizquestionmanager is added to the database
 * 
 * 
 * */

public class QuizQuestionMaker {

	private static Connection con;
	private static Statement stmt;

	//Things I should know before adding ques
	private String description;
	private String title;
	private int user_id;
	private boolean practice_mode;
	private boolean random_question;
	private boolean one_page;
	private boolean immediate_correction;
	//private String tags;
	//private String category;
	
	//Things I should know after adding all the questions;


	/**Order of operations:
	 * make_quiz - pass all variables down to
	 * 		parameters: all of INIT_VARS, 
	 * 		
	 * making_quiz - take those variables and create a QQM and store as a session variable "qqm"
	 * making_quiz - get "qqm" and add questions to it one by one
	 * 		parameters: starting, not starting
	 * 		information to know:
	 * 			current maxScore possible
	 * 			current number of questions
	 * 			current number of each type of question			
	 * 		functionality - 
	 * 			be able to go to make_quiz_review and edit questions
	 * 					
	 * make_quiz_review
	 * 		parameters:
	 * 		functionality:	
	 * 			show all the questions;
	 * 			edit every part of a question
	 * 			submit button
	 * 
	 * make_quiz_finish		
	 * 		shows finished quiz
	 * 		take quiz right away
	 * 		challenge quiz
	 * 
	 * Make Quiz servlet should behave as follows
	 * 
	 * Landing page - quiz name, quiz description, 
	 * 					quiz choices 
	 * 
	 * Start quiz making - "empty quiz - add a question!"
	 * 
	 * 		display types of questions - then add question button, add point value button, add possible scores
	 * 		finish quiz button - takes you to 
	 * 
	 * quiz summarypage
	 *	 allows user to review and change questions, especially picture questions, which might be awful

 	Relevant methods and their locations
 		addQuiz to database - quizmanager
 		generatequizservlet - displays quiz at end of making session
	 */
	
	public QuizQuestionMaker(){

	}
}
