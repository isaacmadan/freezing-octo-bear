package site;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

/**A simple wrapper class for a user_id, a text message, and a timestamp. If you want a formated timestamp just call
 * announcement.dateString() */

public class Announcement extends Object{

	public final int user_id;
	public final String text;
	public final Timestamp time;
	
	public Announcement(int userId, String str, Timestamp tim){
		this.user_id = userId;
		this.text = str;
		this.time = tim;
	}
	
	@Override
	public String toString() {
		return "Announcement [user_id=" + user_id + ", text=" + text + "]";
	}
	public String dateString(){
		DateFormat formatter = new SimpleDateFormat ("MM/dd/yy hh:mm aa");
		 return formatter.format(this.time);
	}

}
