<%@ page
	import="com.carrental.dao.VehicleDAO, com.carrental.model.Vehicle"%>
<%@ page
	import="com.carrental.dao.BookingDAO, com.carrental.model.Booking"%>

<%
String license = request.getParameter("license");
String adharCard = request.getParameter("adharCard");
String phoneNumber = request.getParameter("phoneNumber");
String paymentMode = request.getParameter("paymentMode");
int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));

VehicleDAO vehicleDAO = new VehicleDAO();
Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);

boolean bookingSuccess = false;
String errorMessage = "";

if (vehicle != null) {
	try {
		// Create booking object
		Booking booking = new Booking();
		booking.setVehicle(vehicle);
		booking.setLicense(license);
		booking.setAdharCard(adharCard);
		booking.setPhoneNumber(phoneNumber);
		booking.setPaymentMode(paymentMode);

		// Save booking to DB
		BookingDAO bookingDAO = new BookingDAO();
		bookingSuccess = bookingDAO.saveBooking(booking);

	} catch (Exception e) {
		errorMessage = "Error: " + e.getMessage();
		e.printStackTrace();
	}
} else {
	errorMessage = "Vehicle not found!";
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Booking Confirmation</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f9;
	color: #333;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.container {
	background-color: #fff;
	padding: 30px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	text-align: center;
	max-width: 600px;
	width: 100%;
}

h2 {
	color: #4CAF50;
	margin-bottom: 20px;
}

.message {
	font-size: 18px;
	margin-bottom: 20px;
}

.details {
	background-color: #f9f9f9;
	padding: 15px;
	border-radius: 8px;
	margin-bottom: 20px;
}

.details p {
	margin: 8px 0;
	font-size: 16px;
}

.success {
	color: green;
	font-weight: bold;
}

.failure {
	color: red;
	font-weight: bold;
}

.btn-back {
	display: inline-block;
	padding: 10px 20px;
	background-color: #4CAF50;
	color: white;
	text-decoration: none;
	border-radius: 5px;
	transition: background-color 0.3s ease;
}

.btn-back:hover {
	background-color: #45a049;
}
</style>
</head>
<body>
	<div class="container">
		<h2>Booking Confirmation</h2>
		<div class="message">
			<%
			if (bookingSuccess) {
			%>
			<p class="success">Your booking has been successfully confirmed!</p>
			<div class="details">
				<p>
					<strong>Vehicle:</strong>
					<%=vehicle.getName()%></p>
				<p>
					<strong>Type:</strong>
					<%=vehicle.getType()%></p>
				<p>
					<strong>Cost Per Hour:</strong> $<%=vehicle.getCostPerHour()%></p>
				<p>
					<strong>License:</strong>
					<%=license%></p>
				<p>
					<strong>Adhar Card:</strong>
					<%=adharCard%></p>
				<p>
					<strong>Phone Number:</strong>
					<%=phoneNumber%></p>
				<p>
					<strong>Payment Mode:</strong>
					<%=paymentMode%></p>
			</div>
			<p>Thank you for booking with us!</p>
			<%
			} else {
			%>
			<p class="failure">Sorry, there was an error processing your
				booking.</p>
			<p><%=errorMessage%></p>
			<%
			}
			%>
		</div>
		<a href="dashboard.jsp" class="btn-back">Back to Dashboard</a>
	</div>
</body>
</html>
