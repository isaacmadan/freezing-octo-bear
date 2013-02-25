package site;

import java.util.ArrayList;
import java.util.HashMap;

public class Achievements {

	private boolean amateurAuthor;
	private boolean prolificAuthor;
	private boolean prodigiousAuthor;
	private boolean quizMachine;
	private boolean iAmTheGreatest;
	private boolean practiceMakesPerfect;
	
	public Achievements() {
		// TODO Auto-generated constructor stub
	}
	
	public Achievements(boolean amateurAuthor, boolean prolificAuthor, boolean prodigiousAuthor, boolean quizMachine, boolean iAmTheGreatest, boolean practiceMakesPerfect) {
		this.setAmateurAuthor(amateurAuthor);
		this.setProlificAuthor(prolificAuthor);
		this.setProdigiousAuthor(prodigiousAuthor);
		this.setQuizMachine(quizMachine);
		this.setiAmTheGreatest(iAmTheGreatest);
		this.setPracticeMakesPerfect(practiceMakesPerfect);
	}

	public ArrayList<String> getStrings() {
		ArrayList<String> result = new ArrayList<String>();
		if(amateurAuthor) result.add("Amateur Author");
		if(prolificAuthor) result.add("Prolific Author");
		if(prodigiousAuthor) result.add("Prodigious Author");
		if(quizMachine) result.add("Quiz Machine");
		if(iAmTheGreatest) result.add("I Am The Greatest");
		if(practiceMakesPerfect) result.add("Practice Makes Perfect");
		return result;
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	public boolean isAmateurAuthor() {
		return amateurAuthor;
	}

	public void setAmateurAuthor(boolean amateurAuthor) {
		this.amateurAuthor = amateurAuthor;
	}

	public boolean isProlificAuthor() {
		return prolificAuthor;
	}

	public void setProlificAuthor(boolean prolificAuthor) {
		this.prolificAuthor = prolificAuthor;
	}

	public boolean isProdigiousAuthor() {
		return prodigiousAuthor;
	}

	public void setProdigiousAuthor(boolean prodigiousAuthor) {
		this.prodigiousAuthor = prodigiousAuthor;
	}

	public boolean isQuizMachine() {
		return quizMachine;
	}

	public void setQuizMachine(boolean quizMachine) {
		this.quizMachine = quizMachine;
	}

	public boolean isiAmTheGreatest() {
		return iAmTheGreatest;
	}

	public void setiAmTheGreatest(boolean iAmTheGreatest) {
		this.iAmTheGreatest = iAmTheGreatest;
	}

	public boolean isPracticeMakesPerfect() {
		return practiceMakesPerfect;
	}

	public void setPracticeMakesPerfect(boolean practiceMakesPerfect) {
		this.practiceMakesPerfect = practiceMakesPerfect;
	}

}
