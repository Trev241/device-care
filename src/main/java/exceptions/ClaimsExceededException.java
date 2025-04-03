package exceptions;

public class ClaimsExceededException extends Exception {
	private static final long serialVersionUID = 1L;
	
	public ClaimsExceededException() {
		super();
	}
	
	public ClaimsExceededException(String message) {
		super(message);
	}
}
