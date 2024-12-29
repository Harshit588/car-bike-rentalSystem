<%-- logout.jsp --%>
<%@ page language="java" %>
<%
    session.invalidate(); // End user session
    response.sendRedirect("index.html"); // Redirect to login page
%>
