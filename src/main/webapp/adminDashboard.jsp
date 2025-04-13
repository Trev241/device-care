<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Integer userid = (Integer) session.getAttribute("userid");
    Integer isAdmin = (Integer) session.getAttribute("admin");
    String username = (String) session.getAttribute("name");

   
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Device Care</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">

    <!-- Admin Navigation -->
    <div class="bg-gray-800 text-white p-4 flex justify-between items-center">
        <h1 class="text-xl font-bold">Admin Dashboard - Device Care</h1>
        <div class="flex items-center gap-4">
            <span class="text-lg">Hello, <%= username %> (Admin)</span>
            <a href="logout.jsp" class="bg-red-500 px-3 py-1 rounded hover:bg-red-600">Logout</a>
        </div>
    </div>

    <!-- Admin Controls -->
    <div class="max-w-5xl mx-auto py-12 px-4 grid gap-6 md:grid-cols-2">

        <a href="manageClaims.jsp" class="bg-white p-6 rounded-lg shadow hover:shadow-lg text-center">
            <h2 class="text-xl font-semibold text-blue-700 mb-2">Manage Claims</h2>
            <p>Review, approve, or reject user-submitted insurance claims.</p>
        </a>

        <a href="manageProducts.jsp" class="bg-white p-6 rounded-lg shadow hover:shadow-lg text-center">
            <h2 class="text-xl font-semibold text-green-700 mb-2">Manage Products</h2>
            <p>Manage all registered products across the system.</p>
        </a>

        <a href="users.jsp" class="bg-white p-6 rounded-lg shadow hover:shadow-lg text-center">
            <h2 class="text-xl font-semibold text-yellow-700 mb-2">View All Users</h2>
            <p>View all user accounts information.</p>
        </a>

        <a href="registeredProducts.jsp" class="bg-white p-6 rounded-lg shadow hover:shadow-lg text-center">
            <h2 class="text-xl font-semibold text-purple-700 mb-2">View All Registered Produts</h2>
            <p>View all registered products across the system.</p>
        </a>

    </div>

</body>
</html>
