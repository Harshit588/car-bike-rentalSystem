<%@ page
	import="com.carrental.dao.VehicleDAO, com.carrental.model.Vehicle"%>
<%
// Fetch the vehicle details based on the vehicleId passed in the URL
Vehicle vehicle = null;
String vehicleIdStr = request.getParameter("vehicleId");

if (vehicleIdStr != null && !vehicleIdStr.isEmpty()) {
	try {
		int vehicleId = Integer.parseInt(vehicleIdStr);
		VehicleDAO vehicleDAO = new VehicleDAO();
		vehicle = vehicleDAO.getVehicleById(vehicleId);
	} catch (NumberFormatException e) {
		out.println("Error: Invalid vehicle ID format.");
	}
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Confirm Booking</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f9;
	color: #333;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	margin: 0;
}

.container {
	background-color: #fff;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	text-align: center;
	width: 80%;
	max-width: 600px;
}

h2 {
	color: #4CAF50;
	margin-bottom: 20px;
}

.vehicle-details {
	background-color: #f9f9f9;
	padding: 20px;
	border-radius: 8px;
	margin-bottom: 30px;
}

.vehicle-details img {
	width: 200px;
	height: auto;
	border-radius: 10px;
	margin-bottom: 15px;
}

.vehicle-details h3 {
	margin: 10px 0;
	color: #555;
}

.vehicle-details p {
	margin: 5px 0;
	font-size: 16px;
}

.input-field {
	width: 80%;
	padding: 12px;
	margin: 10px 0;
	border: 1px solid #ddd;
	border-radius: 5px;
	font-size: 14px;
}

select.input-field {
	width: 85%;
	cursor: pointer;
}

.btn-confirm {
	margin-top: 20px;
	padding: 12px 25px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s ease;
}

.btn-confirm:hover {
	background-color: #45a049;
}

.error-message {
	color: red;
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="container">
		<h2>Confirm Your Booking</h2>
		<%
		if (vehicle != null) {
		%>
		<div class="vehicle-details">
			<img src="<%=vehicle.getImageUrl()%>" alt="Vehicle Image">
			<h3><%=vehicle.getName()%></h3>
			<p>
				<strong>Type:</strong>
				<%=vehicle.getType()%></p>
			<p>
				<strong>Cost Per Hour:</strong> $<%=vehicle.getCostPerHour()%></p>
		</div>

		<form action="finalizeBooking.jsp" method="POST">
			<h3>Your Information</h3>
			<input type="text" name="license" class="input-field"
				placeholder="License Number" required> <input type="text"
				name="adharCard" class="input-field" placeholder="Adhar Card Number"
				required> <input type="text" name="phoneNumber"
				class="input-field" placeholder="Phone Number" required> <select
				name="paymentMode" class="input-field" required>
				<option value="" disabled selected>Select Payment Mode</option>
				<option value="COD">Cash On Delivery (COD)</option>
				<option value="Online">Online Payment</option>
			</select> <input type="hidden" name="vehicleId" value="<%=vehicle.getId()%>">
			<button type="submit" class="btn-confirm">Confirm Booking</button>
		</form>

		<%
		} else {
		%>
		<p class="error-message">Vehicle not found!</p>
		<%
		}
		%>
	</div>
</body>
</html>
