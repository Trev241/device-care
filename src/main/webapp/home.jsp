<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Integer userid = (Integer) session.getAttribute("userid");
    String username = (String) session.getAttribute("name");

    if (userid == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard - Device Care</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">

    <!-- Navigation Bar -->
    <div class="bg-blue-600 p-4 text-white flex justify-between">
        <h1 class="text-2xl font-bold">Device Care</h1>
        <div class="flex items-center gap-4">
            <span class="text-lg">Welcome, <%= username %>!</span>
            <a href="logout.jsp" class="bg-red-500 px-3 py-1 rounded hover:bg-red-600">Logout</a>
        </div>
    </div>

    <!-- Dashboard Section -->
    <div class="min-h-screen flex flex-col items-center justify-center py-12 px-6">
        <h2 class="text-3xl font-semibold text-gray-800 mb-8">Welcome to your Dashboard</h2>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 w-full max-w-4xl">

            <a href="protect.jsp" class="bg-white p-6 rounded-lg shadow hover:shadow-lg transition text-center">
                <h3 class="text-xl font-bold text-blue-700 mb-2">Register a Product</h3>
                <p class="text-gray-600">Add your new device for protection coverage.</p>
            </a>

            <a href="registeredProducts.jsp" class="bg-white p-6 rounded-lg shadow hover:shadow-lg transition text-center">
                <h3 class="text-xl font-bold text-green-700 mb-2">My Registered Products</h3>
                <p class="text-gray-600">View all devices you’ve registered so far.</p>
            </a>

            <a href="claim.jsp" class="bg-white p-6 rounded-lg shadow hover:shadow-lg transition text-center">
                <h3 class="text-xl font-bold text-yellow-700 mb-2">File a Claim</h3>
                <p class="text-gray-600">Report an issue or file a damage claim.</p>
            </a>

            <a href="claimHistory.jsp" class="bg-white p-6 rounded-lg shadow hover:shadow-lg transition text-center">
                <h3 class="text-xl font-bold text-purple-700 mb-2">Check Claim Status</h3>
                <p class="text-gray-600">Track progress of your existing claims.</p>
            </a>

        </div>
    </div>

</body>
</html>
