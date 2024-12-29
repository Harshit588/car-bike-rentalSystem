package com.carrental.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.carrental.dao.UserDAO;
import com.carrental.model.User;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private UserDAO userDAO = new UserDAO();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		User user = new User();
		user.setUsername(username);
		user.setEmail(email);
		user.setPassword(password);

		if (userDAO.registerUser(user)) {
			response.sendRedirect("index.html?signup=success");
		} else {
			response.sendRedirect("index.html?signup=fail");
		}
	}
}
