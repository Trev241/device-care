<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

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
    <title>Protect Your Device - Device Care</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">

   

    <!-- Main Content -->
    <div class="max-w-4xl mx-auto my-12 bg-white p-8 rounded shadow">
        <h2 class="text-3xl font-semibold mb-4">Protect your device</h2>
        <p class="text-gray-600 mb-8">Leave the burden of fixing your broken home appliances to us!</p>

        <sql:setDataSource
            driver="com.mysql.cj.jdbc.Driver"
            url="${applicationScope.dbUrl}"
            user="${applicationScope.dbUser}"
            password="${applicationScope.dbPass}"
            var="db" />

        <sql:query var="resultPlans" dataSource="${db}">
            SELECT * FROM protection_plan_types;
        </sql:query>

        <sql:query var="resultItems" dataSource="${db}">
            SELECT * FROM product_types;
        </sql:query>

        <form method="post" action="Protect" class="space-y-6">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label for="username" class="block text-sm font-medium text-gray-700">User Name</label>
                    <input type="text" id="username" name="username" value="<%= username %>" readonly
                           class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
                </div>

                <input type="hidden" name="userid" value="<%= userid %>">

                <div>
                    <label for="serialno" class="block text-sm font-medium text-gray-700">Serial Number</label>
                    <input type="text" id="serialno" name="serialno"
                           class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
                </div>

                <div>
                    <label for="purchasedate" class="block text-sm font-medium text-gray-700">Date of Purchase</label>
                    <input type="date" id="purchasedate" name="purchasedate"
                           class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
                </div>

                <div>
                    <label for="devicename" class="block text-sm font-medium text-gray-700">Device Name</label>
                    <select id="devicename" name="devicename"
                            class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
                        <option value="" disabled selected hidden>Select a device</option>
                        <c:forEach var="row" items="${resultItems.rows}">
                            <option value="${row.product_type_id}">${row.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div>
                    <label for="plantier" class="block text-sm font-medium text-gray-700">Protection Plan</label>
                    <select id="plantier" name="plantier"
                            class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm">
                        <option value="" disabled selected hidden>Select a plan</option>
                        <c:forEach var="row" items="${resultPlans.rows}">
                            <option value="${row.protection_plan_type_id}">${row.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="flex justify-end space-x-4 mt-6">
                <button type="reset"
                        class="text-gray-700 font-semibold px-4 py-2 rounded hover:bg-gray-100">Reset</button>
                <button type="submit"
                        class="bg-indigo-600 text-white font-semibold px-4 py-2 rounded hover:bg-indigo-500">Submit</button>
            </div>
        </form>
    </div>

</body>
</html>