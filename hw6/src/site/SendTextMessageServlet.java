package site;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SendTextMessageServlet
 */
@WebServlet("/SendTextMessageServlet")
public class SendTextMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendTextMessageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		AccountManager manager = new AccountManager();
		User fromUser = manager.getAccount(request.getParameter("from_user"));
		User toUser = manager.getAccount(request.getParameter("to_user"));
		int messageType = Integer.parseInt(request.getParameter("message_type"));
		String content = request.getParameter("content");
		
		TextMessage message = new TextMessage(fromUser,toUser,messageType,content);
		boolean result = Inbox.sendTextMessage(message);
		
		PrintWriter out = response.getWriter();		
		if(result) {
			//out.println("<p>Your message was sent successfully.<br />");
			//out.println("<a href='inbox.jsp'>Back to inbox</a>.</p>");
			
			request.setAttribute("send_success", "true");
			RequestDispatcher dispatch = request.getRequestDispatcher("inbox.jsp");
			dispatch.forward(request, response);
		}
		else {
			//out.println("<p>There was a problem sending your message.<br />");
			//out.println("<a href='compose.jsp'>Try again</a>.</p>");
			
			request.setAttribute("send_failure", "true");
			RequestDispatcher dispatch = request.getRequestDispatcher("compose.jsp");
			dispatch.forward(request, response);
		}
	}

}
