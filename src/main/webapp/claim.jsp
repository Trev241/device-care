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
    <title>File a Claim - Device Care</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">

   
    <div class="max-w-4xl mx-auto my-12 bg-white p-8 rounded shadow">
        <sql:setDataSource
            driver="com.mysql.cj.jdbc.Driver"
            url="${applicationScope.dbUrl}"
            user="${applicationScope.dbUser}"
            password="${applicationScope.dbPass}"
            var="db"
        />

        <sql:query var="resultProducts" dataSource="${db}">
            SELECT * 
            FROM products 
            JOIN product_types USING (product_type_id) 
            JOIN protection_plans USING (protection_plan_id) 
            WHERE protection_plan_id IS NOT NULL AND products.user_id = <%= userid %>;
        </sql:query>

        <c:choose>
            <c:when test="${not empty param.devicename && not empty param.description}">
                <!-- Summary and Final Submit -->
                <form method="post" action="Claim" class="space-y-6">
                    <input type="hidden" name="devicename" value="${param.devicename}">
                    <input type="hidden" name="description" value="${param.description}">

                    <sql:query var="resultDevice" dataSource="${db}">
                        SELECT * 
                        FROM products
                        JOIN product_types USING (product_type_id)
                        WHERE product_id = ?
                        <sql:param value="${param.devicename}" />
                    </sql:query>

                    <sql:query var="resultPlan" dataSource="${db}">
                        SELECT *
                        FROM products
                        JOIN protection_plans USING (protection_plan_id)
                        JOIN protection_plan_types USING (protection_plan_type_id)
                        WHERE product_id = ?
                        <sql:param value="${param.devicename}" />
                    </sql:query>

                    <c:forEach var="row" items="${resultDevice.rows}">
                        <c:set var="device" value="${row}" />
                    </c:forEach>

                    <c:forEach var="row" items="${resultPlan.rows}">
                        <c:set var="plan" value="${row}" />
                    </c:forEach>
                   
                    <div>
                        <h2 class="text-2xl font-bold mb-4">Claim Summary</h2>
                        <div class="space-y-4">
                            <div><strong>Device:</strong> ${device.name}</div>
                            <div><strong>Protection Plan:</strong> ${plan.name}</div>
                            <div><strong>Description:</strong> ${param.description}</div>
                            <div>
                            	<div>
	                            	<strong>Current Premium:</strong> ${plan.premium}
                            	</div>
                            	<p class="italic">Making frequent claims will increase your monthly premium.</p>
                            </div>
                        </div>
                    </div>

                    <div class="flex justify-end space-x-4 mt-6">
                        <button type="reset" class="text-gray-700 font-semibold px-4 py-2 rounded hover:bg-gray-100">Cancel</button>
                        <button type="submit" class="bg-indigo-600 text-white font-semibold px-4 py-2 rounded hover:bg-indigo-500">Submit</button>
                    </div>
                </form>
            </c:when>

            <c:otherwise>
                <!-- Step-by-step Form -->
                <form method="get" class="space-y-6">
                    <div>
                        <h2 class="text-2xl font-bold mb-4">File a Claim</h2>
                        <p class="mb-6 text-gray-600">Provide details about your device issue.</p>

                        <c:choose>
                            <c:when test="${empty param.devicename}">
                                <!-- Step 1: Choose Device -->
                                <label for="devicename" class="block text-sm font-medium text-gray-700">Select Device</label>
                                <select id="devicename" name="devicename" required
                                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                                    <option value="" selected disabled hidden>Choose an option</option>
                                    <c:forEach var="row" items="${resultProducts.rows}">
                                        <option value="${row.product_id}">${row.name} - ${row.serial_no}</option>
                                    </c:forEach>
                                </select>
                            </c:when>

                            <c:when test="${not empty param.devicename && empty param.description}">
                                <!-- Step 2: Enter Description -->
                                <input type="hidden" name="devicename" value="${param.devicename}">
                                <label for="description" class="block text-sm font-medium text-gray-700 mt-4">Describe the issue</label>
                                <textarea name="description" id="description" required maxlength="255"
                                          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                          rows="4"></textarea>
                                <div class="text-xs text-gray-400 mt-1">Max 255 characters</div>
                            </c:when>
                        </c:choose>
                    </div>

                    <div class="flex justify-end space-x-4 mt-6">
                        <button type="reset" class="text-gray-700 font-semibold px-4 py-2 rounded hover:bg-gray-100">Cancel</button>
                        <button type="submit" class="bg-indigo-600 text-white font-semibold px-4 py-2 rounded hover:bg-indigo-500">Next</button>
                    </div>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>