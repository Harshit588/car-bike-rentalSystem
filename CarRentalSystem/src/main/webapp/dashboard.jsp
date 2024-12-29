<%@ page
	import="java.util.*, com.carrental.dao.VehicleDAO, com.carrental.model.Vehicle"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Vehicle Dashboard</title>
<style>
/* General Styles */
body {
	font-family: 'Roboto', sans-serif;
	background-color: #f8f9fa;
	color: #212529;
	margin: 0;
	padding: 0;
}

/* Header Styles */
.header {
	background-color: #343a40;
	color: white;
	padding: 15px 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.logo img {
	width: 50px;
	height: auto;
	margin-right: 10px;
}

.logo h1 {
	font-size: 1.5rem;
	margin: 0;
}

.nav-links a {
	color: white;
	text-decoration: none;
	margin-left: 20px;
	font-weight: 500;
	transition: color 0.3s;
}

.nav-links a:hover {
	color: #ffc107;
}

/* Container Styles */
.container {
	width: 90%;
	max-width: 1200px;
	margin: 30px auto;
	background-color: #ffffff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.05);
}

h2 {
	color: #007bff;
	text-align: center;
	margin-bottom: 20px;
}

/* Form Styles */
form {
	display: flex;
	flex-direction: column;
	gap: 15px;
	margin-bottom: 40px;
}

select, input {
	padding: 12px;
	font-size: 1rem;
	border: 1px solid #ced4da;
	border-radius: 5px;
}

button {
	background-color: #28a745;
	color: white;
	padding: 12px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 1rem;
	transition: background-color 0.3s;
}

button:hover {
	background-color: #218838;
}

/* Table Styles */
table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 30px;
}

th, td {
	padding: 15px;
	text-align: center;
	border-bottom: 1px solid #e9ecef;
}

th {
	background-color: #343a40;
	color: white;
}

tr:hover {
	background-color: #f1f1f1;
}

td img {
	width: 120px;
	height: auto;
	border-radius: 8px;
}

.book-btn {
	background-color: #007bff;
	padding: 10px 15px;
	border: none;
	border-radius: 5px;
	color: white;
	cursor: pointer;
	transition: background-color 0.3s;
}

.book-btn:hover {
	background-color: #0056b3;
}

@media ( max-width : 768px) {
	.container {
		width: 95%;
	}
	table {
		font-size: 0.9rem;
	}
	.nav-links {
		display: flex;
		flex-direction: column;
		align-items: flex-start;
	}
}
</style>
</head>
<body>
	<!-- Header with Logo and Navigation -->
	<div class="header">
		<div class="logo">
			<img
				src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRcJRVsDI47T-VnARh8CKwmmLZlbLTu6o5DmQ&s"
				alt="Car Rental Logo">
			<h1>Car-Bike Rental System</h1>
		</div>
		<div class="nav-links">
			<a href="dashboard.jsp">Dashboard</a> <a href="logout.jsp">Logout</a>
		</div>
	</div>

	<!-- Add Vehicle Form -->
	<div class="container">
		<h2>Add a New Vehicle</h2>
		<form method="POST" action="addVehicle" enctype="multipart/form-data">
			<select name="type" required>
				<option value="">Select Type</option>
				<option value="Car">Car</option>
				<option value="Bike">Bike</option>
			</select> <input type="text" name="name" placeholder="Vehicle Name" required>
			<input type="number" name="costPerHour" placeholder="Cost Per Hour"
				step="0.01" required> <input type="file" name="image"
				accept="image/*" required>
			<button type="submit">Add Vehicle</button>
		</form>
	</div>

	<!-- Available Vehicles Table -->
	<div class="container">
		<h2>Available Vehicles</h2>
		<%
		VehicleDAO vehicleDAO = new VehicleDAO();
		List<Vehicle> vehicles = vehicleDAO.getAllVehicles();
		%>
		<table>
			<tr>
				<th>Type</th>
				<th>Name</th>
				<th>Cost Per Hour</th>
				<th>Image</th>
				<th>Action</th>
			</tr>
			<%
			for (Vehicle vehicle : vehicles) {
			%>
			<tr>
				<td><%=vehicle.getType()%></td>
				<td><%=vehicle.getName()%></td>
				<td>$<%=vehicle.getCostPerHour()%></td>
				<td><img src="<%=vehicle.getImageUrl()%>" alt="Vehicle Image"></td>
				<td>
					<form action="bookVehicle" method="POST">
						<input type="hidden" name="vehicleId" value="<%=vehicle.getId()%>">
						<button type="submit" class="book-btn">Book Now</button>
					</form>
				</td>
			</tr>
			<%
			}
			%>
		</table>
	</div>
</body>
</html>
