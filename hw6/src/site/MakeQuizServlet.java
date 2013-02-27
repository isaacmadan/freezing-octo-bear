package site;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class MakeQuizServlet
 */
@WebServlet("/MakeQuizServlet")
public class MakeQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MakeQuizServlet() {
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
		
		/**DONT TOUCH THIS -- USER AUTH CODE **/
		HttpSession session = request.getSession();
		if(session == null) {
			RequestDispatcher dispatch = request.getRequestDispatcher("index.jsp");
			dispatch.forward(request, response);
			return;
		}
		
		User user = (User)session.getAttribute("user");
		if(user == null) {
			RequestDispatcher dispatch = request.getRequestDispatcher("unauthorized.jsp");
			dispatch.forward(request, response);
			return;
		}
		/** END **/
		
		boolean questionResponseStatus = true, fillInTheBlankStatus = true, multipleChoiceStatus = true, pictureResponseStatus = true;
		if(request.getParameter("question_response") == null) questionResponseStatus = false;
		if(request.getParameter("fill_in_the_blank") == null) fillInTheBlankStatus = false;
		if(request.getParameter("multiple_choice") == null) multipleChoiceStatus = false;
		if(request.getParameter("picture_response") == null) pictureResponseStatus = false;
		
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">");
		out.println("<html>");
		out.println("<head>");
		out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=US-ASCII\">");
		out.println("<title>Making Quiz</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<form action=\"GenerateQuizServlet\" method=\"post\">");
		out.println("<input name=\"quiz_name\" type=\"hidden\" value=\"" + request.getParameter("quiz_name") + "\">");
		out.println("<input name=\"quiz_description\" type=\"hidden\" value=\"" + request.getParameter("quiz_description") + "\">");
		if(request.getParameter("practice_mode") != null)
			out.println("<input name=\"practice_mode\" type=\"hidden\" value=\"" + request.getParameter("practice_mode") + "\">");
		if(request.getParameter("random_question") != null)
			out.println("<input name=\"random_question\" type=\"hidden\" value=\"" + request.getParameter("random_question") + "\">");
		if(request.getParameter("one_page") != null)
			out.println("<input name=\"one_page\" type=\"hidden\" value=\"" + request.getParameter("one_page") + "\">");
		if(request.getParameter("immediate_correction") != null)
			out.println("<input name=\"immediate_correction\" type=\"hidden\" value=\"" + request.getParameter("immediate_correction") + "\">");
		int maxScore = 0;
		
		if(questionResponseStatus == true) {
			printOutQuestionResponse(Integer.parseInt(request.getParameter("question_response_num")), out);
			maxScore += Integer.parseInt(request.getParameter("question_response_num"));
			System.out.println(Integer.parseInt(request.getParameter("question_response_num")));
		}
		if(fillInTheBlankStatus == true) {
			printOutFillInTheBlank(Integer.parseInt(request.getParameter("fill_in_the_blank_num")), out);
			maxScore += Integer.parseInt(request.getParameter("fill_in_the_blank_num"));
			System.out.println(Integer.parseInt(request.getParameter("fill_in_the_blank_num")));
		}
		if(multipleChoiceStatus == true) {
			printOutMultipleChoice(Integer.parseInt(request.getParameter("multiple_choice_num")), out);
			maxScore += Integer.parseInt(request.getParameter("multiple_choice_num"));
			System.out.println(Integer.parseInt(request.getParameter("multiple_choice_num")));
		}
		if(pictureResponseStatus == true) {
			printOutPictureResponse(Integer.parseInt(request.getParameter("picture_response_num")), out);
			maxScore += Integer.parseInt(request.getParameter("picture_response_num"));
			System.out.println(Integer.parseInt(request.getParameter("picture_response_num")));
		}
		
		out.println("<input name=\"max_score\" type=\"hidden\" value=\"" + Integer.toString(maxScore) + "\">");
		out.println("<input type=\"submit\" value=\"Submit\">");
		out.println("</form>");
		out.println("</body>");
		out.println("</html>");
	}
	
	private void printOutQuestionResponse(int numOfQuestions, PrintWriter out) {
		out.println("<input name=\"question_response_count\" type=\"hidden\" value=\"" + Integer.toString(numOfQuestions) + "\">");
		out.println("<h3>Question-Response</h3>");
		out.println("<p>");
		for(int i = 0; i < numOfQuestions; i++) {
			out.println("Enter Question: ");
			out.println("<input type = \"text\" name = \"question_response_" + Integer.toString(i) + "\" id = \"question_response_" + Integer.toString(i) + "\">");
			out.println("<br>");
			out.println("Enter Answers (separate with comma): ");
			out.println("<input type = \"text\" name = \"question_response_answer_" + Integer.toString(i) + "\" id = \"question_response_answer_" + Integer.toString(i) + "\">");
			out.println("<br>");
			out.println("<br>");
		}
		out.println("</p>");
	}
	
	private void printOutFillInTheBlank(int numOfQuestions, PrintWriter out) {
		out.println("<input name=\"fill_in_the_blank_count\" type=\"hidden\" value=\"" + Integer.toString(numOfQuestions) + "\">");
		out.println("<h3>Fill in the Blank</h3>");
		out.println("<p>");
		for(int i = 0; i < numOfQuestions; i++) {
			out.println("Enter Front String: ");
			out.println("<input type = \"text\" name = \"fill_in_the_blank_front_" + Integer.toString(i) + "\" id = \"fill_in_the_blank_front_" + Integer.toString(i) + "\">");
			out.println("<br>");
			out.println("Enter Answer: ");
			out.println("<input type = \"text\" name = \"fill_in_the_blank_answer_" + Integer.toString(i) + "\" id = \"fill_in_the_blank_answer_" + Integer.toString(i) + "\">");
			out.println("<br>");
			out.println("Enter Back String: ");
			out.println("<input type = \"text\" name = \"fill_in_the_blank_back_" + Integer.toString(i) + "\" id = \"fill_in_the_blank_back_" + Integer.toString(i) + "\">");
			out.println("<br>");
			out.println("<br>");
		}
		out.println("</p>");
		
	}
	
	private void printOutMultipleChoice(int numOfQuestions, PrintWriter out) {
		out.println("<input name=\"multiple_choice_count\" type=\"hidden\" value=\"" + Integer.toString(numOfQuestions) + "\">");
		out.println("<h3>Multiple Choice</h3>");
		out.println("<p>");
		for(int i = 0; i < numOfQuestions; i++) {
			out.println("Enter Question: ");
			out.println("<input type = \"text\" name = \"multiple_choice_" + Integer.toString(i) + "\" id = \"multiple_choice_" + Integer.toString(i) + "\">");
			out.println("<br>");
			out.println("Enter Answer Choices (separate with commas): ");
			out.println("<input type = \"text\" name = \"multiple_choice_answer_choice_" + Integer.toString(i) + "\" id = \"multiple_choice_answer_choice_" + Integer.toString(i) + "\">");
			out.println("Enter Answer: ");
			out.println("<input type = \"text\" name = \"multiple_choice_answer_" + Integer.toString(i) + "\" id = \"multiple_choice_answer_" + Integer.toString(i) + "\">");
			out.println("<br>");
			out.println("<br>");
		}
		out.println("</p>");
	}
	
	private void printOutPictureResponse(int numOfQuestions, PrintWriter out) {
		out.println("<input name=\"picture_response_count\" type=\"hidden\" value=\"" + Integer.toString(numOfQuestions) + "\">");
		out.println("<h3>Picture Response</h3>");
		out.println("<p>");
		for(int i = 0; i < numOfQuestions; i++) {
			out.println("Enter Picture Link: ");
			out.println("<input type = \"text\" name = \"picture_response_" + Integer.toString(i) + "\" id = \"picture_response_" + Integer.toString(i) + "\">");
			out.println("<br>");
			out.println("Enter Answer: ");
			out.println("<input type = \"text\" name = \"picture_response_answer_" + Integer.toString(i) + "\" id = \"picture_response_answer_" + Integer.toString(i) + "\">");
			out.println("<br>");
			out.println("<br>");
		}
		out.println("</p>");
	}
}
