package com.carrental.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.carrental.dao.VehicleDAO;
import com.carrental.model.Vehicle;

@WebServlet("/bookVehicle")
public class BookVehicleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
        
        // Assuming you have a VehicleDAO and BookingDAO to handle bookings
        VehicleDAO vehicleDAO = new VehicleDAO();
        Vehicle vehicle = vehicleDAO.getVehicleById(vehicleId);
        
        if (vehicle != null) {
            // Process the booking (e.g., store booking info in the database)
            // You could add more booking logic here, like checking availability, etc.
            
            // For now, redirecting to a confirmation page
            response.sendRedirect("bookingConfirmation.jsp?vehicleId=" + vehicleId);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Vehicle not found.");
        }
    }
}
