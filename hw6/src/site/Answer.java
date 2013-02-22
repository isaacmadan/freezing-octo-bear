package site;

import java.util.HashSet;

public class Answer {

	private HashSet<String> answers;
	
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
}
