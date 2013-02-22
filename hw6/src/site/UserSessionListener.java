package site;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Application Lifecycle Listener implementation class UserSessionListener
 *
 */
@WebListener
public class UserSessionListener implements HttpSessionListener {

    /**
     * Default constructor. 
     */
    public UserSessionListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see HttpSessionListener#sessionCreated(HttpSessionEvent)
     */
    public void sessionCreated(HttpSessionEvent arg0) {
    	AccountManager manager = new AccountManager();
    	User user = null;
        HttpSession context = arg0.getSession();
        context.setAttribute("user", user);
        context.setAttribute("manager", manager);
    }

	/**
     * @see HttpSessionListener#sessionDestroyed(HttpSessionEvent)
     */
    public void sessionDestroyed(HttpSessionEvent arg0) {
        // TODO Auto-generated method stub
    }
	
}
