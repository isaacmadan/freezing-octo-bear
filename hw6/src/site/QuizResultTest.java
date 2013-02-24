package site;

import java.text.DateFormat;

import org.junit.Before;
import org.junit.Test;

public class QuizResultTest {
	QuizResult qr;

	@Before
	public void setup(){
		qr = new QuizResult();
	}

	
	
	/**The field that bothers me the most is the date field. How do I deal with the date field and going from 
	 * Java date to mysql date and back?
	 * 
	 * */
	@Test
	public void test1(){
		Result rs = QuizResult.getResultFromID(4);
		Result rs2 = QuizResult.getResultFromID(2);
		System.out.println(rs.toString());
		System.out.println(rs2.toString());
		
		System.out.println(DateFormat.getDateTimeInstance().format(rs.timeStamp));
		System.out.println(DateFormat.getDateTimeInstance().format(rs2.timeStamp));
	}
}
