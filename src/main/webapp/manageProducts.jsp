<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, service.ProductTypeDao,servlet.*,util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%

Integer userid = (Integer) session.getAttribute("userid");
if (userid == null) {
    response.sendRedirect("login.jsp");
    return;
}


ProductTypeDao dao = new ProductTypeDao();
	List<ProductType> types = dao.getAllProductTypes();  
    request.setAttribute("types", types);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Product Types</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-8">

    <div class="max-w-3xl mx-auto bg-white p-6 rounded shadow">
        <h2 class="text-2xl font-bold mb-4">Add New Product Type</h2>
        <form method="post" action="ProductTypeServlet" class="space-y-4">
            <input type="hidden" name="action" value="add">
            <div>
                <label class="block text-sm font-medium text-gray-700">Name</label>
                <input name="name" class="border p-2 w-full rounded" required>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700">Model</label>
                <input name="model" class="border p-2 w-full rounded" required>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700">Discontinued</label>
                <select name="discontinued" class="border p-2 w-full rounded">
                    <option value="0">No</option>
                    <option value="1">Yes</option>
                </select>
            </div>
            <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded">Add Product Type</button>
        </form>

        <h3 class="text-xl font-semibold mt-8 mb-2">Existing Product Types</h3>
        <table class="w-full border mt-2">
            <thead>
                <tr class="bg-gray-200 text-left">
                    <th class="p-2">Name</th>
                    <th class="p-2">Model</th>
                    <th class="p-2">Discontinued</th>
                    <th class="p-2">update</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="type" items="${types}">
                    <tr class="border-t">
                        <td class="p-2">${type.name}</td>
                        <td class="p-2">${type.model}</td>
                        <td class="p-2">${type.discontinued == 1 ? "Yes" : "No"}</td>
                        <td class="p-2">
    						<form action="updateProductType.jsp" method="get">
        					<input type="hidden" name="name" value="${type.name}" />
        					<button type="submit" class="text-blue-500 underline">Update</button>
    						</form>
						</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
