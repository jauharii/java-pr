<%-- 
    Document   : bookingProcess
    Created on : 13 Oct 2026, 21:53:52
    Author     : jauhari
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbConnection.jsp" %>
<%
    String operation = request.getParameter("operation");
    String bookingId = request.getParameter("booking_id");
    String movie = request.getParameter("movie");
    String bookingDate = request.getParameter("date");
    String hall = request.getParameter("hall");
    String seat = request.getParameter("seat");

    // Requirement d: Verify date is not empty
    if (bookingDate == null || bookingDate.trim().isEmpty()) {
%>
        <script>
            alert("Error: Date cannot be empty. Please select a valid date.");
            window.history.back();
        </script>
<%
        return;
    }

    try {
        if ("update".equalsIgnoreCase(operation) && bookingId != null && !bookingId.isEmpty()) {
            // Requirement f: Update modified booking information
            String updateSql = "UPDATE booking SET movie = ?, date = ?, hall = ?, seat = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(updateSql);
            ps.setString(1, movie);
            ps.setString(2, bookingDate);
            ps.setString(3, hall);
            ps.setString(4, seat);
            ps.setInt(5, Integer.parseInt(bookingId));
            ps.executeUpdate();
            ps.close();
        } else {
            // Requirement d: Insert new booking record
            String insertSql = "INSERT INTO booking (movie, date, hall, seat) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(insertSql);
            ps.setString(1, movie);
            ps.setString(2, bookingDate);
            ps.setString(3, hall);
            ps.setString(4, seat);
            ps.executeUpdate();
            ps.close();
        }

        if (conn != null) conn.close();
        response.sendRedirect("booking.jsp");
    } catch (Exception e) {
        out.println("Database operation failed: " + e.getMessage());
    }
%>