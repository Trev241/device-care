<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, service.ClaimDao, util.Claim" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    Integer userid = (Integer) session.getAttribute("userid");
    if (userid == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    ClaimDao claimDao = new ClaimDao();
    List<Claim> userClaims = claimDao.getClaimsByUserId(userid); 
    request.setAttribute("claims", userClaims);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Claim History</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-10">

    <div class="bg-white p-6 rounded shadow-md max-w-7xl mx-auto">
        <h1 class="text-2xl font-bold mb-4">My Claims</h1>

        <table class="table-auto w-full border">
            <thead class="bg-gray-200">
                <tr>
                    <th class="px-4 py-2">Date</th>
                    <th class="px-4 py-2">Status</th>
                    <th class="px-4 py-2">Description</th>
                    <th class="px-4 py-2">Settlement</th>
                    <th class="px-4 py-2">Product ID</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="claim" items="${claims}">
                    <tr class="border-t">
                        <td class="px-4 py-2">${claim.claimDate}</td>
                        <td class="px-4 py-2">${claim.status}</td>
                        <td class="px-4 py-2">${claim.description}</td>
                        <td class="px-4 py-2">${claim.settlement}</td>
                        <td class="px-4 py-2">${claim.productId}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</body>
</html>
