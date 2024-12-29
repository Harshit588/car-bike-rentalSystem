package com.carrental.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.carrental.dao.VehicleDAO;
import com.carrental.model.Vehicle;

@WebServlet("/addVehicle")
@MultipartConfig
public class AddVehicleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("type");
        String name = request.getParameter("name");
        double costPerHour = Double.parseDouble(request.getParameter("costPerHour"));

        Part filePart = request.getPart("image");
        String fileName = filePart.getSubmittedFileName();

        // Save the file to the server
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadFilePath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String filePath = uploadFilePath + File.separator + fileName;
        filePart.write(filePath);

        // Save vehicle details to the database
        Vehicle vehicle = new Vehicle(type, name, costPerHour, UPLOAD_DIR + "/" + fileName);
        VehicleDAO vehicleDAO = new VehicleDAO();
        vehicleDAO.saveVehicle(vehicle);

        response.sendRedirect("dashboard.jsp");
    }
}
