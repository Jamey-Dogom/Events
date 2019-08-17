<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet" href='<c:url value="/css/style4.css"/>'
	type="text/css" />
<script type="text/javascript" src="js/myscript.js"></script>
<meta charset="UTF-8">
<title>${event.name}</title>
</head>
<body>
	<div
		class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-black border-bottom box-shadow">
		<h5 class="my-0 mr-md-auto font-weight-normal wh">
			Welcome,
			<c:out value="${user.firstName}"></c:out>
			!
		</h5>

		<nav class="my-2 my-md-0 mr-md-3 mgb"></nav>
		<a class="btn btn-light mgrt" href="/logout">Logout</a>
	</div>
	<div class="container">
		<h2 class="mgb mgt">${event.name}</h2>
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<h4>
						Host:
						<c:out value="${event.host.firstName}"></c:out>
						<c:out value="${event.host.lastName}"></c:out>
					</h4>
					<h4>
						Date:
						<c:out value="${event.date}"></c:out>
					</h4>
					<h4>
						Location:
						<c:out value="${event.location}"></c:out>
						,
						<c:out value="${event.state}"></c:out>
					</h4>
					<h4>
						People who are attending this event:
						<c:out value="${(event.attendees).size()}"></c:out>
					</h4>
					<table class="table table-striped mgt">
						<thead>
							<tr>
								<th scope="col">Name</th>
								<th scope="col">Location</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${attendees}" var="attendee">
								<tr>
									<td>${attendee.firstName}${attendee.lastName}</td>
									<td>${attendee.location}</td>
								</tr>
							</c:forEach>

						</tbody>
					</table>
				</div>
				<div class="col-md-6">
					<h4>Message Wall</h4>
					<div class="overflow-auto">
						<c:forEach items="${messages}" var="message">
							<p> <c:out value = "${message.user.firstName}"></c:out> says: <c:out value = "${message.message}"></c:out></p>
							<p>-----------------------------</p>
						</c:forEach>
					</div>
					<form method= "POST" action="/events/${event.id}/addMessage">
						<div class="form-group mgt">
							<label for="exampleFormControlTextarea1">Add comment:</label>
							<textarea name = "message" class="form-control" id="exampleFormControlTextarea1"
								rows="3"></textarea>
						</div>
						 <button type="submit" class="btn btn-dark">Submit</button>
					</form>
				</div>

			</div>
		</div>
	</div>

</body>
</html>