<%-- 
    Document   : booking
    Created on : 13 Oct 2026, 21:49:33
    Author     : jauhari
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbConnection.jsp" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String editId = request.getParameter("editId");
    String currentMovie = "Upin Ipin The Movie 3";
    String currentDate = "";
    String currentHall = "Hall A";
    String currentSeat = "A1";
    boolean isEditMode = false;

    if (editId != null && !editId.trim().isEmpty()) {
        try {
            PreparedStatement psEdit = conn.prepareStatement("SELECT * FROM booking WHERE id = ?");
            psEdit.setInt(1, Integer.parseInt(editId));
            ResultSet rsEdit = psEdit.executeQuery();
            if (rsEdit.next()) {
                isEditMode = true;
                currentMovie = rsEdit.getString("movie");
                currentDate = rsEdit.getString("date");
                currentHall = rsEdit.getString("hall");
                currentSeat = rsEdit.getString("seat");
            }
            rsEdit.close();
            psEdit.close();
        } catch (Exception e) {
            out.println("Error fetching record: " + e.getMessage());
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Movie Booking System</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <div class="booking-box">
        <h2>Movie Booking System</h2>
        <a href="logout.jsp" class="logout-link">Logout</a>

        <!-- Form: Handles both Add and Edit operations -->
        <form action="bookingProcess.jsp" method="post">
            <input type="hidden" name="booking_id" value="<%= isEditMode ? editId : "" %>">
            <input type="hidden" name="operation" value="<%= isEditMode ? "update" : "insert" %>">

            <table class="form-table">
                <tr>
                    <td><label for="movie">Movie:</label></td>
                    <td>
                        <select id="movie" name="movie">
                            <option value="Upin Ipin The Movie 3" <%= currentMovie.equals("Upin Ipin The Movie 3") ? "selected" : "" %>>Upin Ipin The Movie 3</option>
                            <option value="Pride and Prejudice" <%= currentMovie.equals("Pride and Prejudice") ? "selected" : "" %>>Pride and Prejudice</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="date">Date:</label></td>
                    <td>
                        <input type="date" id="date" name="date" value="<%= currentDate %>">
                    </td>
                </tr>
                <tr>
                    <td><label for="hall">Hall:</label></td>
                    <td>
                        <select id="hall" name="hall">
                            <option value="Hall A" <%= currentHall.equals("Hall A") ? "selected" : "" %>>Hall A</option>
                            <option value="Hall B" <%= currentHall.equals("Hall B") ? "selected" : "" %>>Hall B</option>
                            <option value="Hall C" <%= currentHall.equals("Hall C") ? "selected" : "" %>>Hall C</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="seat">Seat:</label></td>
                    <td>
                        <select id="seat" name="seat">
                            <option value="A1" <%= currentSeat.equals("A1") ? "selected" : "" %>>A1</option>
                            <option value="A2" <%= currentSeat.equals("A2") ? "selected" : "" %>>A2</option>
                            <option value="A3" <%= currentSeat.equals("A3") ? "selected" : "" %>>A3</option>
                            <option value="A4" <%= currentSeat.equals("A4") ? "selected" : "" %>>A4</option>
                            <option value="B1" <%= currentSeat.equals("B1") ? "selected" : "" %>>B1</option>
                            <option value="B2" <%= currentSeat.equals("B2") ? "selected" : "" %>>B2</option>
                            <option value="B3" <%= currentSeat.equals("B3") ? "selected" : "" %>>B3</option>
                            <option value="B4" <%= currentSeat.equals("B4") ? "selected" : "" %>>B4</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="btn-group">
                        <input type="submit" value="<%= isEditMode ? "Update" : "Book" %>">
                        <input type="reset" value="Reset" onclick="<%= isEditMode ? "window.location.href='booking.jsp';" : "" %>">
                    </td>
                </tr>
            </table>
        </form>

        <!-- Booking Records Table -->
        <table class="records-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Movie</th>
                    <th>Date</th>
                    <th>Hall</th>
                    <th>Seat</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM booking ORDER BY id ASC");
                        while (rs.next()) {
                            int id = rs.getInt("id");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= rs.getString("movie") %></td>
                    <td><%= rs.getDate("date") %></td>
                    <td><%= rs.getString("hall") %></td>
                    <td><%= rs.getString("seat") %></td>
                    <td>
                        <a href="booking.jsp?editId=<%= id %>">Edit</a> | 
                        <a href="deleteBooking.jsp?id=<%= id %>" onclick="return confirm('Confirm deletion of this record?');">Delete</a>
                    </td>
                </tr>
                <%
                        }
                        rs.close();
                        stmt.close();
                        if (conn != null) conn.close();
                    } catch (Exception e) {
                        out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
