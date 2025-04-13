<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>



<%
    Integer userid = (Integer) session.getAttribute("userid");
    if (userid == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Protect your device</title>
	<script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body>
	<div class="max-w-screen-lg mx-auto my-24">
		<h1 class="text-4xl mb-1">Protect your device</h1>
		<p class="text-lg mb-10">Leave the burden of fixing your broken home appliances to us!</p>	
	
		<sql:setDataSource
			driver="com.mysql.cj.jdbc.Driver"
			url="jdbc:mysql://localhost:3306/device_insurance"
			user="root"
			password="Humber"
			var="db"
		/>
	
		<sql:query var="resultPlans" dataSource="${db}">
			SELECT * FROM protection_plan_types;
		</sql:query>
		
		<sql:query var="resultItems" dataSource="${db}">
			SELECT * FROM product_types;
		</sql:query>
	
		<form method="post" action="Protect">
			<div class="space-y-12 border-b border-gray-900/10 pb-12">
				<div class="grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">

				
				<div class="sm:col-span-2">				
						<label for="serialno">User Name</label>
						<input type="text" id="serialno" name="serialno" class="mt-2 block w-full outline-1 focus:outline-2 outline-gray-300 py-1.5 px-3 rounded-md min-w-0 grow focus-within:outline-indigo-600" />
					</div>

					<input type="hidden" name="userid" value="1">

				
					<div class="sm:col-span-4">				
						<label for="devicename">Device name</label>
						<div class="mt-2 grid grid-cols-1">
						<select id="devicename" name="devicename" class="col-start-1 row-start-1 w-full appearance-none rounded-md bg-white py-1.5 pr-8 pl-3 text-gray-900 outline-1 -outline-offset-1 outline-gray-300 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6">
						  	<option value="" selected disabled hidden>Choose an option</option>
						  	<c:forEach var="row" items="${resultItems.rows}">
						  		<option value="${row.product_type_id}">${row.name}</option>
						  	</c:forEach>
						</select>
						<svg class="pointer-events-none col-start-1 row-start-1 mr-2 size-5 self-center justify-self-end text-gray-500 sm:size-4" viewBox="0 0 16 16" fill="currentColor" aria-hidden="true" data-slot="icon">
						  	<path fill-rule="evenodd" d="M4.22 6.22a.75.75 0 0 1 1.06 0L8 8.94l2.72-2.72a.75.75 0 1 1 1.06 1.06l-3.25 3.25a.75.75 0 0 1-1.06 0L4.22 7.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
						</svg>
						</div>
					</div>
					
					<div class="sm:col-span-2">				
						<label for="serialno">Serial number</label>
						<input type="text" id="serialno" name="serialno" class="mt-2 block w-full outline-1 focus:outline-2 outline-gray-300 py-1.5 px-3 rounded-md min-w-0 grow focus-within:outline-indigo-600" />
					</div>
					
					<div class="sm:col-span-2">				
						<label for="purchasedate">Date of purchase</label>
						<input type="date" id="purchasedate" name="purchasedate" class="mt-2 block w-full outline-1 focus:outline-2 outline-gray-300 py-1.5 px-3 rounded-md min-w-0 grow focus-within:outline-indigo-600" />
					</div>
					
					<div class="sm:col-span-4">				
						<label for="plantier">Plan</label>
						<div class="mt-2 grid grid-cols-1">
						<select id="plantier" name="plantier" class="col-start-1 row-start-1 w-full appearance-none rounded-md bg-white py-1.5 pr-8 pl-3 text-gray-900 outline-1 -outline-offset-1 outline-gray-300 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6">
						  	<option value="" selected disabled hidden>Choose an option</option>
						  	<c:forEach var="row" items="${resultPlans.rows}">
						  		<option value="${row.protection_plan_type_id}">${row.name}</option>
						  	</c:forEach>
						</select>
						<svg class="pointer-events-none col-start-1 row-start-1 mr-2 size-5 self-center justify-self-end text-gray-500 sm:size-4" viewBox="0 0 16 16" fill="currentColor" aria-hidden="true" data-slot="icon">
						  	<path fill-rule="evenodd" d="M4.22 6.22a.75.75 0 0 1 1.06 0L8 8.94l2.72-2.72a.75.75 0 1 1 1.06 1.06l-3.25 3.25a.75.75 0 0 1-1.06 0L4.22 7.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
						</svg>
						</div>
					</div>
					
				</div>
			</div>
			
			<div class="mt-6 flex items-center gap-x-6 justify-end">
				<button type="reset" class="font-semibold">Reset</button>
				<button type="submit" class="font-semibold text-white rounded-md bg-indigo-600 px-3 py-2 shadow-xs hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">Submit</button>
			</div>
		</form>
	</div>
</body>
</html>