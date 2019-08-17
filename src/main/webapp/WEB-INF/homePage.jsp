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
<link rel="stylesheet" href='<c:url value="/css/style2.css"/>'
	type="text/css" />
<script type="text/javascript" src="js/myscript.js"></script>
<meta charset="UTF-8">
<title>Events</title>
<!--  jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.11.3.min.js"></script>

<!-- Isolated Version of Bootstrap, not needed if your site already uses Bootstrap -->
<link rel="stylesheet"
	href="https://formden.com/static/cdn/bootstrap-iso.css" />

<!-- Bootstrap Date-Picker Plugin -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css" />
</head>
<body>
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

		<div class="row">
			<div class="col-lg-12 mgt">
				<h5>Here are some of the events in your state:</h5>
				<table class="table table-striped">
					<thead>
						<tr>
							<th scope="col">Name</th>
							<th scope="col">Date</th>
							<th scope="col">Location</th>
							<th scope="col">Host</th>
							<th scope="col">Action/ Status</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${instate_events}" var="event">
							<tr>
								<td><a href="/events/${event.id}">${event.name}</a></td>
								<td>${event.date}</td>
								<td>${event.location}</td>
								<td>${event.host.firstName}</td>
								<c:if test="${user.id == event.host.id }">
									<td><a href="/events/${event.id}/edit">Edit <span>
										</span></a> | <a href="/events/${event.id}/delete"> Delete</a></td>

								</c:if>
								<c:choose>

									<c:when test="${event.host.id != user.id }">
										<c:set var="attending" value="null" />


										<c:forEach items="${event.attendees}" var="attendee">


											<c:if test="${attendee.id == user.id }">
												<c:set var="attending" value="true" />
											</c:if>
										</c:forEach>


										<c:if test="${attending.contains('null') }">
											<td><a href="/events/${event.id}/join">Join</a></td>
										</c:if>


										<c:if test="${attending == true}">
											<td><span>Joining</span> | <a
												href="/events/${event.id}/cancel">Cancel</a></td>
										</c:if>
									</c:when>
								</c:choose>
							</tr>
						</c:forEach>
					</tbody>
				</table>

			</div>
		</div>


		<div class="row">
			<div class="col-lg-12 mgt pd">
				<h5 class="pd">Here are some of the events in other state:</h5>

				<table class="table table-striped mgb ">
					<thead>
						<tr>
							<th scope="col">Name</th>
							<th scope="col">Date</th>
							<th scope="col">Location</th>
							<th scope="col">State</th>
							<th scope="col">Host</th>
							<th scope="col">Action/ Status</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${outstate_events}" var="event">
							<tr>
								<td><a href="/events/${event.id}">${event.name}</a></td>
								<td>${event.date}</td>
								<td>${event.location}</td>
								<td>${event.state}</td>
								<td>${event.host.firstName}</td>
								<c:if test="${user.id == event.host.id }">
									<td><a href="/events/${event.id}/edit">Edit <span>
										</span></a> | <a href="/events/${event.id}/delete"> Delete</a></td>

								</c:if>
								<c:choose>

									<c:when test="${event.host.id != user.id }">
										<c:set var="attending" value="null" />


										<c:forEach items="${event.attendees}" var="attendee">


											<c:if test="${attendee.id == user.id }">
												<c:set var="attending" value="true" />
											</c:if>
										</c:forEach>


										<c:if test="${attending.contains('null') }">
											<td><a href="/events/${event.id}/join">Join</a></td>
										</c:if>


										<c:if test="${attending == true}">
											<td><span>Joining</span> | <a
												href="/events/${event.id}/cancel">Cancel</a></td>
										</c:if>
									</c:when>
								</c:choose>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-6">
				<p class="text-uppercase pull-center pd">Create and Event!</p>

				<p>
					<form:errors path="event.*" />
				</p>

				<form:form method="POST" action="/createEvent"
					modelAttribute="event">
					<p>
						<form:label class="ilb" path="name">Name: </form:label>
						<form:input type="text" path="name" />
					</p>
					<div class="form-group">
						<!-- Date input -->
						<form:label path="date" class="control-label ilb" for="date">Date: </form:label>
						<form:input path="date" id="date" name="date" type="date" />
					</div>

					<p>
						<form:label class="ilb" path="location">Location:</form:label>
						<form:input type="text" path="location" />
					</p>
					<div class="ilb vt">
						<form:select path="state">
							<option value="AL">AL</option>
							<option value="AK">AK</option>
							<option value="AR">AR</option>
							<option value="AZ">AZ</option>
							<option value="CA">CA</option>
							<option value="CO">CO</option>
							<option value="CT">CT</option>
							<option value="DC">DC</option>
							<option value="DE">DE</option>
							<option value="FL">FL</option>
							<option value="GA">GA</option>
							<option value="HI">HI</option>
							<option value="IA">IA</option>
							<option value="ID">ID</option>
							<option value="IL">IL</option>
							<option value="IN">IN</option>
							<option value="KS">KS</option>
							<option value="KY">KY</option>
							<option value="LA">LA</option>
							<option value="MA">MA</option>
							<option value="MD">MD</option>
							<option value="ME">ME</option>
							<option value="MI">MI</option>
							<option value="MN">MN</option>
							<option value="MO">MO</option>
							<option value="MS">MS</option>
							<option value="MT">MT</option>
							<option value="NC">NC</option>
							<option value="NE">NE</option>
							<option value="NH">NH</option>
							<option value="NJ">NJ</option>
							<option value="NM">NM</option>
							<option value="NV">NV</option>
							<option value="NY">NY</option>
							<option value="ND">ND</option>
							<option value="OH">OH</option>
							<option value="OK">OK</option>
							<option value="OR">OR</option>
							<option value="PA">PA</option>
							<option value="RI">RI</option>
							<option value="SC">SC</option>
							<option value="SD">SD</option>
							<option value="TN">TN</option>
							<option value="TX">TX</option>
							<option value="UT">UT</option>
							<option value="VT">VT</option>
							<option value="VA">VA</option>
							<option value="WA">WA</option>
							<option value="WI">WI</option>
							<option value="WV">WV</option>
							<option value="WY">WY</option>
						</form:select>
					</div>
					<button type="submit" class="btn btn-dark mvl">Create!</button>
				</form:form>
			</div>
		</div>
	</div>

</body>

</html>