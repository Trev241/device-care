<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.io.*, java.util.*, service.*, servlet.*, util.*" %>
<%
    Integer userid = (Integer) session.getAttribute("userid");
    if (userid == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registered Products</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">

    <div class="min-h-screen flex items-center justify-center py-12 px-6">
        <div class="w-full max-w-6xl bg-white p-8 rounded-lg shadow-lg">
            <h2 class="text-3xl font-semibold text-gray-900 mb-6">Registered Products</h2>

            <!-- Search Form -->
            <form method="get" class="mb-6">
                <input type="text" name="searchQuery" placeholder="Search by serial number, purchase date or product type" class="border p-2 rounded w-full">
                <button type="submit" class="bg-blue-500 text-white p-2 mt-2 rounded">Search</button>
            </form>

            <table class="min-w-full table-auto border-collapse">
                <thead class="bg-gray-100">
                    <tr>
                        <th class="px-4 py-2 text-left text-sm font-medium text-gray-700">Serial Number</th>
                        <th class="px-4 py-2 text-left text-sm font-medium text-gray-700">Purchase Date</th>
                        <th class="px-4 py-2 text-left text-sm font-medium text-gray-700">Product Type</th>
                    </tr>
                </thead>
                <tbody>
                    
                    <%
   						 ProductDao productDao = new ProductDao();
    						List<Product> products = new ArrayList<>();

    						String searchQuery = request.getParameter("searchQuery");

    						if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        						products = productDao.searchProducts(searchQuery);
    						} else {
    							if(userid.equals(2)){
            						products = productDao.getAllProducts();

    							}else{
            						products = productDao.getProductsByUserId(userid);
    							}
    						}

    						request.setAttribute("products", products);
					%>


                    <c:forEach var="product" items="${products}">
                        <tr class="border-b hover:bg-gray-50">
                            <td class="px-4 py-2 text-sm text-gray-600">${product.serialNo}</td>
                            <td class="px-4 py-2 text-sm text-gray-600">${product.purchaseDate}</td>
                            <td class="px-4 py-2 text-sm text-gray-600">${product.productTypeName}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </div>
    </div>

</body>
</html>
