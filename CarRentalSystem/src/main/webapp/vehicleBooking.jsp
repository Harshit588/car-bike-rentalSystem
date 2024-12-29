<%@ page
	import="java.util.*, com.carrental.dao.VehicleDAO, com.carrental.model.Vehicle"%>
<%
// Fetch all available vehicles from the database
VehicleDAO vehicleDAO = new VehicleDAO();
List<Vehicle> vehicles = vehicleDAO.getAllVehicles();
%>

<html>
<head>
<title>Vehicle Booking</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f9;
	color: #333;
}

.container {
	width: 80%;
	margin: 20px auto;
	text-align: center;
}

h2 {
	color: #4CAF50;
}

.vehicle-list {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-around;
}

.vehicle-card {
	width: 250px;
	padding: 20px;
	margin: 10px;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.vehicle-card img {
	width: 100%;
	border-radius: 5px;
}

.vehicle-card h3 {
	color: #333;
}

.vehicle-card p {
	color: #555;
}

.btn-book {
	margin-top: 10px;
	padding: 10px 20px;
	background-color: #4CAF50;
	color: white;
	border: none;
	cursor: pointer;
	border-radius: 5px;
}

.btn-book:hover {
	background-color: #45a049;
}
</style>
</head>
<body>
	<div class="container">
		<div class="vehicle-list">
			<%
			// Iterate over the list of vehicles and display them
			for (Vehicle vehicle : vehicles) {
			%>
			<div class="vehicle-card">
				<img src="<%=vehicle.getImageUrl()%>" alt="Vehicle Image">
				<h3><%=vehicle.getName()%></h3>
				<p>
					Type:
					<%=vehicle.getType()%></p>
				<p>
					Cost Per Hour: $<%=vehicle.getCostPerHour()%></p>
				<a href="bookingConfirmation.jsp?vehicleId=<%=vehicle.getId()%>">
					<button class="btn-book">Book Now</button>
				</a>
			</div>
			<%
			}
			%>
		</div>
	</div>
</body>
</html>
