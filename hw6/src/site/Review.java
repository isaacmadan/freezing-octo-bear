package site;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

/*
CREATE TABLE reviews (
	review_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT,
	quiz_id INT,
	string TEXT,
	review_score INT,
	created_timestamp TIMESTAMP default now();
);
 */

/**Encapsulates a Review of a quiz*/
public class Review extends Object {
	@Override
	public String toString() {
		return "Review [reviewId=" + reviewId + ", userId=" + userId
				+ ", quizId=" + quizId + ", text=" + text + ", review_score="
				+ review_score + "]\n";
	}

	public final int reviewId;
	public final int userId;
	public final int quizId;
	public final String text;
	public final int review_score;
	public final Timestamp time;

	public Review(int review, int user, int quiz, String text, int score, Timestamp timestamp){
		this.reviewId = review;
		this.userId = user;
		this.quizId = quiz;
		this.text = text;
		this.review_score = score;
		this.time = timestamp;
	}
	
	public String dateString(){
		DateFormat formatter = new SimpleDateFormat ("MM/dd/yy hh:mm aa");
		 return formatter.format(this.time);
	}
}
