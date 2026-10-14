<%-- 
    Document   : login
    Created on : 13 Oct 2026, 21:34:52
    Author     : jauhari
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Movie Booking Login</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <div class="login-box">
        <h2>Movie Booking Login</h2>
        <form action="loginProcess.jsp" method="post">
            <div class="form-row">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-row">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <input type="submit" value="Login" class="btn-login">
        </form>
    </div>
</body>
</html>