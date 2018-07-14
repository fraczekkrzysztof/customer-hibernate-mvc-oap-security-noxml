<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>List Customers</title>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>
	<div id="wrapper">
		<div id="header">
			<h2>CRM - Customer Relationship Manager</h2>
		</div>
	</div>
	<div id="container">
		<div id="content">
		<p>
		User: <security:authentication property="principal.username"/>, Role(s): <security:authentication property="principal.authorities"/>
		</p>
			<!-- put new button: Add Customer -->
			<security:authorize access="hasAnyRole('MANAGER','ADMIN')">
			<input type="button" value="Add Customer" 
				   onclick="window.location.href='showFormForAdd'; return false;" 
				   class="add-button"/>
			</security:authorize>	   
			<!-- add a search box -->
			<form:form action="search" method = "POST">
				Search customer: <input type="text" name="theSearchName"/>
				<input type = "submit" value="Search" class="add-button"/>
			</form:form>	   
			<!-- add out htm table here -->
			<table>
				<tr>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Email</th>
					<th>Action</th>
				</tr>
				<!-- loop over adn print our customers -->
				<c:forEach var="tempCustomer" items="${customers}">
				<!-- construct an "update" link with customer id -->
				<c:url var="updateLink" value="/customer/showFormForUpdate">
					<c:param name = "customerId" value="${tempCustomer.id}"/>
				</c:url>
				<!-- construct an "delete" link with customer id -->
				<c:url var="deleteLink" value="/customer/delete">
					<c:param name = "customerId" value="${tempCustomer.id}"/>
				</c:url>
					<tr>
						<td>${tempCustomer.firstName}</td>
						<td>${tempCustomer.lastName}</td>
						<td>${tempCustomer.email}</td>
						<td>
							<!-- display the update link -->
							<security:authorize access="hasAnyRole('ADMIN','MANAGER')">
							<a href="${updateLink}">Update</a> 
							</security:authorize>  
							| 
							<security:authorize access="hasRole('ADMIN')">
							<a href="${deleteLink}"
							onclick="if (!(confirm('Are you sure you want to delete this customer?'))) return false">Delete</a>
							</security:authorize>  
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<p></p>
	<!-- Add a logout button -->
	<form:form action="${pageContext.request.contextPath}/logout" 
			   method="POST">
	
		<input type="submit" value="Logout" class="add-button" />
	
	</form:form>
</body>

</html>