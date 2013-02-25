package site;

import java.util.HashSet;

public class Answer {

	private HashSet<String> answers;
	
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
}
