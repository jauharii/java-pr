<%-- 
    Document   : deleteBooking
    Created on : 13 Oct 2026, 21:56:50
    Author     : jauhari
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbConnection.jsp" %>
<%
    String idToDelete = request.getParameter("id");

    if (idToDelete != null && !idToDelete.trim().isEmpty()) {
        try {
            String deleteSql = "DELETE FROM booking WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(deleteSql);
            ps.setInt(1, Integer.parseInt(idToDelete));
            ps.executeUpdate();

            ps.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            out.println("Deletion error: " + e.getMessage());
        }
    }

    response.sendRedirect("booking.jsp");
%>
