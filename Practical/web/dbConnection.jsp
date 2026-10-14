<%-- 
    Document   : dbConnection
    Created on : 13 Oct 2026, 21:33:17
    Author     : jauhari
--%>

<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/movieticketdb?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    String dbUser = "jauhari";
    String dbPassword = "jauhari3005";
    Connection conn = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);
    } catch (ClassNotFoundException e) {
        // Fallback for older MySQL Connector drivers
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUser, dbPassword);
        } catch (Exception ex) {
            out.println("<p style='color:red;'>Driver Error: " + ex.getMessage() + "</p>");
        }
    } catch (SQLException e) {
        out.println("<p style='color:red;'>Database Connection Error: " + e.getMessage() + "</p>");
    }
%>
