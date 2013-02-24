package site;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		
		if(questionResponseStatus = true) printOutQuestionResponse(Integer.parseInt(request.getParameter("question_response_num")), out);
		if(fillInTheBlankStatus = true) printOutFillInTheBlank(Integer.parseInt(request.getParameter("fill_in_the_blank_num")), out);
		if(multipleChoiceStatus = true) printOutMultipleChoice(Integer.parseInt(request.getParameter("multiple_choice_num")), out);
		if(pictureResponseStatus = true) printOutPictureResponse(Integer.parseInt(request.getParameter("picture_response_num")), out);
		
		out.println("</form>");
		out.println("</body>");
		out.println("</html>");
	}
	
	private void printOutQuestionResponse(int numOfQuestions, PrintWriter out) {
		out.println("<h3>Question-Response</h3>");
		out.println("<p>");
		for(int i = 0; i < numOfQuestions; i++) {
			out.println("Enter Question: ");
			out.println("<input type = \"text\" name = \"question_response_\"" + Integer.toString(i) + "id = \"question_response_\" + <%= Integer.toString(i) %>>");
			out.println("<br>");
			out.println("Enter Answers (separate with comma): ");
			out.println("<input type = \"text\" name = \"question_response_answer_\" + <%= Integer.toString(i) %> id = \"question_response_answer_\" + <%= Integer.toString(i) %>>");
			out.println("<br>");
		}
		out.println("</p>");
	}
	
	private void printOutFillInTheBlank(int numOfQuestions, PrintWriter out) {
		out.println("<h3>Fill in the Blank</h3>");
		out.println("<p>");
		for(int i = 0; i < numOfQuestions; i++) {
			out.println("Enter Front String: ");
			out.println("<input type = \"text\" name = \"fill_in_the_blank_\"" + Integer.toString(i) + "id = \"fill_in_the_blank_\" + <%= Integer.toString(i) %>>");
			out.println("<br>");
			out.println("Enter Back String: ");
			out.println("<input type = \"text\" name = \"question_response_answer_\" + <%= Integer.toString(i) %> id = \"question_response_answer_\" + <%= Integer.toString(i) %>>");
			out.println("<br>");
		}
		out.println("</p>");
	}
	
	private void printOutMultipleChoice(int numOfQuestions, PrintWriter out) {
		out.println("<h3>Fill in the Blank</h3>");
		out.println("<p>");
		for(int i = 0; i < numOfQuestions; i++) {
			
		}
		out.println("</p>");
	}
	
	private void printOutPictureResponse(int numOfQuestions, PrintWriter out) {
		out.println("<h3>Fill in the Blank</h3>");
		out.println("<p>");
		for(int i = 0; i < numOfQuestions; i++) {
			
		}
		out.println("</p>");
	}
}
