package site;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteTextMessageServlet
 */
@WebServlet("/DeleteTextMessageServlet")
public class DeleteTextMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteTextMessageServlet() {
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
		
		int numMessages = Integer.parseInt(request.getParameter("num_messages"));
		ArrayList<Integer> messageIds = new ArrayList<Integer>();
		for(int i = 0; i < numMessages; i++) {
			String param = request.getParameter("delete_"+i);
			if(param != null) {
				int messageId = Integer.parseInt(param);
				messageIds.add(messageId);
			}
		}
		
		for(int id : messageIds) {
			@SuppressWarnings("unused")
			boolean success = Inbox.deleteTextMessage(id);
		}
		
		RequestDispatcher dispatch = request.getRequestDispatcher("inbox.jsp");
		dispatch.forward(request, response);
	}

}
