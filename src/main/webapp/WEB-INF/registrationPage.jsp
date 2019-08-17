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
<link rel="stylesheet" href='<c:url value="/css/style.css"/>'
  type="text/css" />
<script type="text/javascript" src="js/myscript.js"></script>
<meta charset="UTF-8">
<title>Welcome</title>
</head>
<body>
  <div class="container-fluid">
    <div class="container">
      <div class="row">
        <div class="col-md-5 bx">


          <p class="text-uppercase pull-center wh">Register Here!</p>

          <p class="wh">
            <form:errors path="user.*" />
          </p>

          <form:form method="POST" action="/registration" modelAttribute="user">
            <p>
              <form:label class="wh ilb" path="firstName">First Name:</form:label>
              <form:input type="text" path="firstName" />
            </p>
            <p>
              <form:label class="wh ilb" path="lastName">Last Name:</form:label>
              <form:input type="text" path="lastName" />
            </p>
            <p>
              <form:label class="wh ilb" path="email">Email:</form:label>
              <form:input type="email" path="email" />
            </p>
            <p>
              <form:label class="wh ilb" path="location">Location:</form:label>
              <form:input type="text" path="location" />
            </p>
            <form:select path="state" class="ilb vt">
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
            <p>
              <form:label class="wh ilb al" path="password">Password:</form:label>
              <form:password path="password" />
            </p>
            <p>
              <form:label class="wh ilb" path="passwordConfirmation">PW Conf:</form:label>
              <form:password path="passwordConfirmation" />
            </p>
            <button type="submit" class="btn btn-dark">Register!</button>
          </form:form>
        </div>

        <div class="col-md-2 "></div>

        <div class="col-md-5 bx">
          <p class="text-uppercase pull-center wh">Login!</p>
          <p class = "wh">
            <c:out value="${error}" />
          </p>
          <form method="post" action="/login">
            <p>
              <label class="wh ilb" for="email">Email:</label> <input
                type="text" id="email" name="email" />
            </p>
            <p>
              <label class="wh ilb" for="password">Password:</label> <input
                type="password" id="password" name="password" />
            </p>
            <button type="submit" class="btn btn-dark">Log In!</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</body>


</html>