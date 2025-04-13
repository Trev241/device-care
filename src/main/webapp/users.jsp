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
    <title>User Accounts</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">

    <div class="min-h-screen flex items-center justify-center py-12 px-6">
        <div class="w-full max-w-6xl bg-white p-8 rounded-lg shadow-lg">
            <h2 class="text-3xl font-semibold text-gray-900 mb-6">Registered Users</h2>

            <!-- Search Form -->
            <form method="get" class="mb-6">
                <input type="text" name="searchQuery" placeholder="Search by username or email" class="border p-2 rounded w-full">
                <button type="submit" class="bg-blue-500 text-white p-2 mt-2 rounded">Search</button>
            </form>

            <table class="min-w-full table-auto border-collapse">
                <thead class="bg-gray-100">
                    <tr>
                        <th class="px-4 py-2 text-left text-sm font-medium text-gray-700">Username</th>
                        <th class="px-4 py-2 text-left text-sm font-medium text-gray-700">Email</th>
                        <th class="px-4 py-2 text-left text-sm font-medium text-gray-700">Phone</th>
                        <th class="px-4 py-2 text-left text-sm font-medium text-gray-700">Address</th>
                    </tr>
                </thead>
                <tbody>
                    
                    <%
                        UserDao userDao = new UserDao();
                        List<User> users = new ArrayList<>();
                        
                        String searchQuery = request.getParameter("searchQuery");

                        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                            users = userDao.searchUsers(searchQuery);  
                        } else {
                            users = userDao.getAllUsers(); 
                        }

                        request.setAttribute("users", users);
                    %>

                    <c:forEach var="user" items="${users}">
                        <tr class="border-b hover:bg-gray-50">
                            <td class="px-4 py-2 text-sm text-gray-600">${user.username}</td>
                            <td class="px-4 py-2 text-sm text-gray-600">${user.email}</td>
                            <td class="px-4 py-2 text-sm text-gray-600">${user.phoneNumber}</td>
                            <td class="px-4 py-2 text-sm text-gray-600">${user.address}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </div>
    </div>

</body>
</html>
