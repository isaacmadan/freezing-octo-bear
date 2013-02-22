package site;

public interface Question {
 
    public int getQuestionId();
    
    public int getQuizId();
    
    public int getPointValue();
    
    public int getQuestionType();
    
    public Answer getAnswer();
}
