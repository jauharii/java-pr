<%-- 
    Document   : logout
    Created on : 13 Oct 2026, 21:47:41
    Author     : jauhari
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate();
    response.sendRedirect("login.jsp");
%>
