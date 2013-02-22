package site;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CreateUserServlet
 */
@WebServlet("/CreateUserServlet")
public class CreateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateUserServlet() {
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
		String username = request.getParameter("username");
		String password = request.getParameter("password");
				
		HttpSession session = request.getSession();
		AccountManager manager = (AccountManager)session.getAttribute("manager");
		if(manager == null) {
			manager = new AccountManager();
			session.setAttribute("manager", manager);
		}
				
		if(manager.isExistingAccount(username)) {
			RequestDispatcher dispatch = request.getRequestDispatcher("create_failure.jsp");
			dispatch.forward(request, response);
			return;
		}
		else {
			User user = manager.createNewAccount(username, password, false);
			if(user != null) {
				session.setAttribute("user", user);
				RequestDispatcher dispatch = request.getRequestDispatcher("success.jsp");
				dispatch.forward(request, response);
			}
		}
			
	}

}
