package com.carrental.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.carrental.dao.VehicleDAO;
import com.carrental.model.Vehicle;

@WebServlet("/confirmBooking")
public class ConfirmBookingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Retrieve user information from form
		String license = request.getParameter("license");
		String aadhaar = request.getParameter("aadhaar");
		String phone = request.getParameter("phone");
		String paymentMode = request.getParameter("paymentMode");
		int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));

		// Retrieve vehicle details
		VehicleDAO vehicleDAO = new VehicleDAO();
		Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);

		// You can save the booking details to a database here if needed
		// For now, we'll just display the confirmation to the user.

		response.setContentType("text/html");
		response.getWriter().println("<h2>Booking Confirmed!</h2>");
		response.getWriter().println("<p><strong>Vehicle:</strong> " + vehicle.getName() + "</p>");
		response.getWriter().println("<p><strong>License:</strong> " + license + "</p>");
		response.getWriter().println("<p><strong>Aadhaar Card:</strong> " + aadhaar + "</p>");
		response.getWriter().println("<p><strong>Phone:</strong> " + phone + "</p>");
		response.getWriter().println("<p><strong>Payment Mode:</strong> " + paymentMode + "</p>");
		response.getWriter().println("<p>Your booking is confirmed. Thank you!</p>");
	}
}
