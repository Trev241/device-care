<%@ page import="java.util.*, service.ProductTypeDao, util.ProductType" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
Integer userid = (Integer) session.getAttribute("userid");
if (userid == null) {
    response.sendRedirect("login.jsp");
    return;
}

String nameParam = request.getParameter("name");
ProductTypeDao dao = new ProductTypeDao();
ProductType type = dao.getProductTypeByName(nameParam);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Product Type</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-8">
    <div class="max-w-3xl mx-auto bg-white p-6 rounded shadow">
        <h2 class="text-2xl font-bold mb-4">Update Product Type</h2>
        <form method="post" action="ProductTypeServlet" class="space-y-4">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="originalName" value="<%= type.getName() %>">
            <div>
                <label class="block text-sm font-medium text-gray-700">Name</label>
                <input name="name" class="border p-2 w-full rounded" required value="<%= type.getName() %>">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700">Model</label>
                <input name="model" class="border p-2 w-full rounded" required value="<%= type.getModel() %>">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700">Discontinued</label>
                <select name="discontinued" class="border p-2 w-full rounded">
                    <option value="0" <%= type.getDiscontinued() == 0 ? "selected" : "" %>>No</option>
                    <option value="1" <%= type.getDiscontinued() == 1 ? "selected" : "" %>>Yes</option>
                </select>
            </div>
            <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded">Update Product Type</button>
        </form>
    </div>
</body>
</html>
