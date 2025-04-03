<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Error</title>
	<script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body>
	<div class="max-w-screen-lg mx-auto my-24">
		<div class="mb-4">		
			<h1 class="text-4xl mb-4">${param.title}</h1>
			<p>${param.message}</p>
		</div>
		<div class="flex items-center justify-end">
			<button onclick="window.location.href='claim.jsp'" class="font-semibold text-white rounded-md bg-indigo-600 px-3 py-2 shadow-xs hover:bg-indigo-500 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">Okay</button>
		</div>
	</div>
</body>
</html>