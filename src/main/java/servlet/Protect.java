package servlet;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Protect
 */
@WebServlet("/Protect")
public class Protect extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Protect() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = System.getenv("DB_URL");
			String username = System.getenv("DB_USER");
			String password = System.getenv("DB_PASSWORD");
			Connection connection = DriverManager.getConnection(url, username, password);	
			
			LocalDate now = LocalDate.now();
			LocalDate end = now.plusYears(5);
			
			PreparedStatement premStmt = connection.prepareStatement("SELECT standard_premium FROM protection_plan_types WHERE protection_plan_type_id = ?");
			premStmt.setInt(1, Integer.parseInt(request.getParameter("plantier")));
			ResultSet premiums = premStmt.executeQuery();
			
			int premium = 0;
			if (premiums.next()) premium = premiums.getInt(1);
			else throw new SQLException("Failed to fetch premium");
			
			String plansSql = "INSERT INTO protection_plans (start_date, expiry_date, protection_plan_type_id, user_id, premium) VALUES (?, ?, ?, ?, ?)";
			PreparedStatement plansStmt = connection.prepareStatement(plansSql, Statement.RETURN_GENERATED_KEYS);
			plansStmt.setString(1, now.toString());
			plansStmt.setString(2, end.toString());
			plansStmt.setString(3, request.getParameter("plantier"));
			plansStmt.setInt(4, Integer.parseInt(request.getParameter("userid")));
			plansStmt.setInt(5, premium);
			plansStmt.executeUpdate();
			
			ResultSet planIds = plansStmt.getGeneratedKeys();
			int planId = -1;
			if (planIds.next()) {
				planId = planIds.getInt(1);
			} else {
				throw new SQLException("Failed to fetch plan ID");
			}
			
			String productsSql = "INSERT INTO products (serial_no, purchase_date, product_type_id, protection_plan_id, user_id) VALUES (?, ?, ?, ?, ?)";
			PreparedStatement productsStmt = connection.prepareStatement(productsSql, Statement.RETURN_GENERATED_KEYS);
			productsStmt.setString(1, request.getParameter("serialno"));
			productsStmt.setString(2, request.getParameter("purchasedate"));
			productsStmt.setInt(3, Integer.parseInt(request.getParameter("devicename")));
			productsStmt.setInt(4, planId);
			productsStmt.setInt(5, Integer.parseInt(request.getParameter("userid")));
			productsStmt.executeUpdate();
			
			response.sendRedirect("home.jsp");
		} catch (ClassNotFoundException | SQLException e) {
			// Forward the error
			System.err.println(e);
			response.sendError(400, e.toString());
		}
	}

}
