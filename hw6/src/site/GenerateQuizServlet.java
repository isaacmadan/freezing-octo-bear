package site;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GenerateQuizServlet
 */
@WebServlet("/GenerateQuizServlet")
public class GenerateQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GenerateQuizServlet() {
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
		if(request.getParameter("question_response_count") == null) questionResponseStatus = false;
		if(request.getParameter("fill_in_the_blank_count") == null) fillInTheBlankStatus = false;
		if(request.getParameter("multiple_choice_count") == null) multipleChoiceStatus = false;
		if(request.getParameter("picture_response_count") == null) pictureResponseStatus = false;
		
		Quiz quiz = new Quiz();
		if(request.getParameter("quiz_description") != null) quiz.setDescription(request.getParameter("quiz_description"));
		else quiz.setDescription(null);
		if(request.getParameter("quiz_name") != null) quiz.setTitle(request.getParameter("quiz_name"));
		else quiz.setTitle(null);
		if(request.getParameter("max_score") != null) quiz.setMax_score(Integer.parseInt(request.getParameter("max_score")));
		else quiz.setMax_score(0);
		if(request.getParameter("practice_mode") != null) quiz.setPractice_mode(true);
		else quiz.setPractice_mode(false);
		if(request.getParameter("random_question") != null) quiz.setRandom_question(true);
		else quiz.setRandom_question(false);
		if(request.getParameter("one_page") != null) quiz.setOne_page(true);
		else quiz.setOne_page(false);
		if(request.getParameter("immediate_correction") != null) quiz.setImmediate_correction(true);
		else quiz.setImmediate_correction(false);
		
		
		PrintWriter out = response.getWriter();
		QuizManager manager = new QuizManager(request, quiz);
		manager.addQuizToDataBase();
		out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">");
		out.println("<html>");
		out.println("<head>");
		out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=US-ASCII\">");
		out.println("<title>Here is the Quiz!</title>");
		out.println("</head>");
		out.println("<body>");
		if(request.getParameter("quiz_name") != null) out.println("<h3>" + request.getParameter("quiz_name") + "</h3>");
		else out.println("<h3>No Name</h3>");
		if(request.getParameter("quiz_description") != null)out.println("<p>" + request.getParameter("quiz_description") + "</p>");
		else out.println("<p>No Description</p>");
		
		if(request.getParameter("question_response_count") != null) genQuestionResponse(out, request, manager);
		if(request.getParameter("fill_in_the_blank_count") != null) genFillInTheBlank(out, request, manager);
		if(request.getParameter("multiple_choice_count") != null) genMultipleChoice(out, request, manager);
		if(request.getParameter("picture_response_count") != null) genPictureResponse(out, request, manager);
		
		out.println("<a href = \"index.jsp\">Go Back to Home Page</a>");
		out.println("</body>");
		out.println("</html>");
	}

	private void genQuestionResponse(PrintWriter out, HttpServletRequest request, QuizManager manager) {
		for(int i = 0; i < Integer.parseInt(request.getParameter("question_response_count")); i++) {
			manager.addQuestionResponseToDataBase(request.getParameter("question_response_" + Integer.toString(i)),
					request.getParameter("question_response_answer_" + Integer.toString(i)));
			out.println("<p>Question: " + request.getParameter("question_response_" + Integer.toString(i)) + "</p>");
			out.println("<p>Answer: " + request.getParameter("question_response_answer_" + Integer.toString(i)) + "</p>");
		}
	}
	
	private void genFillInTheBlank(PrintWriter out, HttpServletRequest request, QuizManager manager) {
		for(int i = 0; i < Integer.parseInt(request.getParameter("fill_in_the_blank_count")); i++) {
			manager.addFillInTheBlankToDataBase(request.getParameter("fill_in_the_blank_front_" + Integer.toString(i)),
					request.getParameter("fill_in_the_blank_back_" + Integer.toString(i)), 
					request.getParameter("fill_in_the_blank_answer_" + Integer.toString(i)));
			out.println("<p>Question: " + request.getParameter("fill_in_the_blank_front_" + Integer.toString(i)) 
					+ " _____ " + request.getParameter("fill_in_the_blank_back_" + Integer.toString(i)) + "</p>");
			out.println("<p>Answer: " + request.getParameter("fill_in_the_blank_answer_" + Integer.toString(i)) + "</p>");
		}
	}

	private void genMultipleChoice(PrintWriter out, HttpServletRequest request, QuizManager manager) {
		for(int i = 0; i < Integer.parseInt(request.getParameter("multiple_choice_count")); i++) {
			manager.addMultipleChoiceToDataBase(request.getParameter("multiple_choice_" + Integer.toString(i)),
					request.getParameter("multiple_choice_answer_choice_" + Integer.toString(i)), 
					request.getParameter("multiple_choice_answer_" + Integer.toString(i)));
			out.println("<p>Question: " + request.getParameter("multiple_choice_" + Integer.toString(i)) + "</p>");
			out.println("<p>Answer Choices: " + request.getParameter("multiple_choice_answer_choice_" + Integer.toString(i)) + "</p>");
			out.println("<p>Answer: " + request.getParameter("multiple_choice_answer_" + Integer.toString(i)) + "</p>");
		}
	}

	private void genPictureResponse(PrintWriter out, HttpServletRequest request, QuizManager manager) {
		for(int i = 0; i < Integer.parseInt(request.getParameter("picture_response_count")); i++) {
			manager.addPictureResponseToDataBase(request.getParameter("picture_response_" + Integer.toString(i)),
					request.getParameter("picture_response_answer_" + Integer.toString(i)));
			out.println("<p>Question: " + request.getParameter("picture_response_" + Integer.toString(i)) + "</p>");
			out.println("<p>Answer: " + request.getParameter("picture_response_answer_" + Integer.toString(i)) + "</p>");
		}
	}
}
