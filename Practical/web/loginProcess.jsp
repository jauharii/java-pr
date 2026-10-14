<%-- 
    Document   : loginProcess
    Created on : 13 Oct 2026, 21:45:08
    Author     : jauhari
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbConnection.jsp" %>
<%
    String usernameInput = request.getParameter("username");
    String passwordInput = request.getParameter("password");

    try {
        String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, usernameInput);
        ps.setString(2, passwordInput);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            session.setAttribute("user", usernameInput);
            response.sendRedirect("booking.jsp");
        } else {
%>
            <script>
                alert("Invalid username or password. Please re-enter.");
                window.location.href = "login.jsp";
            </script>
<%
        }

        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    } catch (Exception e) {
        out.println("Authentication Error: " + e.getMessage());
    }
%>