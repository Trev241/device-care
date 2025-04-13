package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.ProductTypeDao;
import util.ProductType;

/**
 * Servlet implementation class ProductTypeServlet
 */
@WebServlet("/ProductTypeServlet")
public class ProductTypeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductTypeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 String action = request.getParameter("action");
	        if ("add".equals(action)) {
	            String name = request.getParameter("name");
	            String model = request.getParameter("model");
	            int discontinued = Integer.parseInt(request.getParameter("discontinued"));

	            ProductTypeDao dao = new ProductTypeDao();
	            dao.insertProductType(new ProductType(name, model, discontinued));
	        }

	        response.sendRedirect("manageProducts.jsp");
	}

}
