package servlet;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.Period;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exceptions.ClaimsExceededException;

/**
 * Servlet implementation class Claim
 */
@WebServlet("/Claim")
public class Claim extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Claim() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LocalDate nextOpenClaimDate = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = System.getenv("DB_URL");
			String username = System.getenv("DB_USER");
			String password = System.getenv("DB_PASSWORD");
			
			Connection connection = DriverManager.getConnection(url, username, password);
			
			String pastClaimsSql = ""
					+ "SELECT * "
					+ "FROM products "
					+ "JOIN claims USING (product_id) "
					+ "JOIN protection_plans USING (protection_plan_id) "
					+ "WHERE product_id = ? AND TIMESTAMPDIFF(YEAR, claim_date, CURDATE()) <= 5 "
					+ "ORDER BY claim_date";
			PreparedStatement pastClaimsStmt = connection.prepareStatement(pastClaimsSql);
			pastClaimsStmt.setInt(1, Integer.parseInt(request.getParameter("devicename")));
			ResultSet resultSet = pastClaimsStmt.executeQuery();
			
			int claims = 0;
			Date earliestClaimDate = null;
			
			while (resultSet.next()) {
				if (earliestClaimDate == null) earliestClaimDate = resultSet.getDate("claim_date");
				claims++;
			}
			
			String userSql = ""
					+ "SELECT * "
					+ "FROM products "
					+ "WHERE product_id = ?";
			PreparedStatement userStmt = connection.prepareStatement(userSql);
			userStmt.setInt(1, Integer.parseInt(request.getParameter("devicename")));
			ResultSet userResultSet = userStmt.executeQuery();
			
			int userId = -1;
			if (userResultSet.next()) userId = userResultSet.getInt("user_id");
			else throw new SQLException("Failed to get user ID");
			
			if (claims >= 3) {
				// Calculate the next available date where a claim can be made
				LocalDate now = LocalDate.now();
				LocalDate then = now.minusYears(5);
				Period diff = then.until(earliestClaimDate.toLocalDate());
				nextOpenClaimDate = now.plus(diff).plusDays(1);
				
				throw new ClaimsExceededException("Number of claims exceeded.");
			}
			
			// Hike premium
			String premiumSql = ""
					+ "UPDATE protection_plans "
					+ "JOIN products USING (protection_plan_id) "
					+ "SET premium = premium * 1.25 " 
					+ "WHERE product_id = ?";
			PreparedStatement premiumStmt = connection.prepareStatement(premiumSql);
			premiumStmt.setInt(1, Integer.parseInt(request.getParameter("devicename")));
			premiumStmt.executeUpdate();
			
			String claimSql = "INSERT INTO claims (claim_date, status, description, product_id) VALUES (?, ?, ?, ?)";
			PreparedStatement claimStmt = connection.prepareStatement(claimSql);
			claimStmt.setDate(1, new Date(System.currentTimeMillis()));
			claimStmt.setString(2, "PENDING");
			claimStmt.setString(3, request.getParameter("description"));
			claimStmt.setString(4, request.getParameter("devicename"));
			claimStmt.executeUpdate();
			
			String notifSql = "INSERT INTO notifications (title, message, user_id) VALUES (?, ?, ?)";
			PreparedStatement notifStmt = connection.prepareStatement(notifSql, Statement.RETURN_GENERATED_KEYS);
			String title = "Revised Premium";
			String message = "After looking into your recent history with us, we have decided to revise your monthly premium. This new premium rate will be effective immediately.";
			notifStmt.setString(1, title);
			notifStmt.setString(2, message);
			notifStmt.setInt(3, userId);
			notifStmt.executeUpdate();
			
			response.sendRedirect("claim.jsp");
		} catch (Exception e) {
			// Forward error
			System.err.println(e);
			String title;
			String message;
			
			if (e instanceof ClaimsExceededException) {
				title = "Claims exceeded";
				message = "You have exceeded the number of claims on this device in the last five years. Your next claim can be made on " + nextOpenClaimDate.toString() + ".";				
			} else {
				title = "An error occurred";
				message = e.toString();
			}
			
			response.sendRedirect(""
					+ "error.jsp"
					+ "?title="+ URLEncoder.encode(title, "utf-8") + ""
					+ "&message=" + URLEncoder.encode(message, "utf-8"));
		}
	}

}
