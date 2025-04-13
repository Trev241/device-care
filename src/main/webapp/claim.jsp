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
	<title>File a claim</title>
	<script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body>
	<div class="max-w-screen-lg mx-auto my-24">
		<sql:setDataSource
			driver="com.mysql.cj.jdbc.Driver"
			url="jdbc:mysql://localhost:3306/device_insurance"
			user="root"
			password="root"
			var="db"
		/>
		
		<sql:query var="resultProducts" dataSource="${db}">
			SELECT * 
				FROM products 
				JOIN product_types USING (product_type_id) 
				JOIN protection_plans USING (protection_plan_id) 
				WHERE protection_plan_id IS NOT NULL;
		</sql:query>
	
		<c:choose>
			<c:when test="${not empty param.devicename && not empty param.description}">
				<form method="post" action="Claim">
					<div class="space-y-12 border-b border-gray-900/10 pb-12">
						<h1 class="text-4xl mb-1">Claim Summary</h1>
						<p class="mb-12">Review your details before submitting your claim.</p>
						
						<input type="hidden" name="devicename" value="${param.devicename}">
						<input type="hidden" name="description" value="${param.description}">
						
						<div class="grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">
							<sql:query var="resultDevice" dataSource="${db}">
								SELECT * 
									FROM products
									JOIN product_types USING (product_type_id)
									WHERE product_id = ?;
								<sql:param value="${param.devicename}" />
							</sql:query>
							
							<sql:query var="resultPlan" dataSource="${db}">
								SELECT *
									FROM products
									JOIN protection_plans USING (protection_plan_id)
									JOIN protection_plan_types USING (protection_plan_type_id)
									WHERE product_id = ?;
									<sql:param value="${param.devicename}" />
							</sql:query>
							
							<c:forEach var="row" items="${resultDevice.rows}">
								<c:set var="device" value="${row}" />
							</c:forEach>
							
							<c:forEach var="row" items="${resultPlan.rows}">
								<c:set var="plan" value="${row}" />
							</c:forEach>
							
							<div class="col-span-6">
								<h2 class="text-xl">Device</h2>
								<p>${device.name}</p>
								<h2 class="text-xl mt-6">Protection type</h2>
								<p>${plan.name}</p>
								<h2 class="text-xl mt-6">Description</h2>
								<p>${param.description}</p>
							</div>
						</div>
					</div>
					
					<div class="mt-6 flex items-center gap-x-6 justify-end">
						<button type="reset" class="font-semibold">Cancel</button>
						<button type="submit" class="font-semibold text-white rounded-md bg-indigo-600 px-3 py-2 shadow-xs hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">Submit</button>
					</div>
				</form>
			</c:when>
			<c:otherwise>
				<form>
					<div class="space-y-12 border-b border-gray-900/10 pb-12">								
						<div class="grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">
							<div class="col-span-6">	
								<h1 class="text-4xl mb-1">File a claim</h1>
								<p class="text-lg mb-10">We will need some information from you before we can make a claim.</p>
							</div>
						
							<c:choose>
								<c:when test="${empty param.devicename}">
									<div class="col-span-6 sm:col-span-4">				
										<label for="devicename">Which device would you like to file a claim for?</label>
										<div class="mt-2 grid grid-cols-1">
										<select id="devicename" name="devicename" class="col-start-1 row-start-1 w-full appearance-none rounded-md bg-white py-1.5 pr-8 pl-3 text-gray-900 outline-1 -outline-offset-1 outline-gray-300 focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6">
										  	<option value="" selected disabled hidden>Choose an option</option>
										  	<c:forEach var="row" items="${resultProducts.rows}">
										  		<option value="${row.product_id}">${row.name} - ${row.serial_no}</option>
										  	</c:forEach>
										</select>
										<svg class="pointer-events-none col-start-1 row-start-1 mr-2 size-5 self-center justify-self-end text-gray-500 sm:size-4" viewBox="0 0 16 16" fill="currentColor" aria-hidden="true" data-slot="icon">
										  	<path fill-rule="evenodd" d="M4.22 6.22a.75.75 0 0 1 1.06 0L8 8.94l2.72-2.72a.75.75 0 1 1 1.06 1.06l-3.25 3.25a.75.75 0 0 1-1.06 0L4.22 7.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
										</svg>
										</div>
									</div>									
								</c:when>
								
								<c:when test="${not empty param.devicename && empty param.description}">
									<div class="col-span-6">			
										<input name="devicename" hidden value="${param.devicename}">				
										<label for="description">Describe your claim.</label>
										<textarea 
											id="description"
											name="description"
											class="mt-2 block w-full outline-1 focus:outline-2 outline-gray-300 py-1.5 px-3 rounded-md min-w-0 grow focus-within:outline-indigo-600"
										></textarea>
										<div class="flex items-center justify-end mt-2 text-xs text-gray-400">Character limit: 255 characters</div>
									</div>
								</c:when>
							</c:choose>
						</div>
					</div>
					
					<div class="mt-6 flex items-center gap-x-6 justify-end">
						<button type="reset" class="font-semibold">Cancel</button>
						<button type="submit" class="font-semibold text-white rounded-md bg-indigo-600 px-3 py-2 shadow-xs hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">Next</button>
					</div>
				</form>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>