<%-- 
    Document   : index
    Created on : Jun 27, 2023, 9:20:37 PM
    Author     : ACER
--%>

<%@page import="DAOs.accountDAO"%>
<%@page import="Models.account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="javascripts/jquery-3.7.0.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@500&display=swap" rel="stylesheet">
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <link href="./assets/css/signup.css" rel="stylesheet" type="text/css" media="all">
        <link href="//fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,700,700i" rel="stylesheet">
        <style>
            * {
                font-family: 'Nunito', sans-serif;
            }
        </style>
        <style>
            /* ... (css code) ... */
            /* Thêm luật CSS để định dạng màu chữ cho thông báo lỗi */
            .error-msg {
                color: red;
            }
        </style>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <div class="main-w3layouts wrapper">
            <h1>Login Page</h1>
            <div class="main-agileinfo">
                <div class="agileits-top">
                    <form method="post">

                        <%
                            String error = request.getParameter("error");
                            if ("invalid".equals(error)) {
                        %>
                        <h2 style="color: #ff0000; text-align: center" class="error-msg">Username does not exist!</h2>
                        <%
                            } else if ("password".equals(error)) {
                        %>
                        <h2 style="color: #ff0000; text-align: center" class="error-msg">Invalid Username or Password!</h2>
                        <%
                            }
                        %>
                        <input class="text" placeholder="Username" type="text" id="usrname" name="username" required> <br> <br> 
                        <input class="text" placeholder="Password" type="password" name="userpass" id="psw" required> <br> <br> 
                        
                        <button class="btn btn-success col-md-offset-2" type="submit" id="submit-btn" value="Submit" name="btnSubmit">Login</button>
                        <button type="reset" class="btn btn-success col-md-offset-2">Cancel</button> 
                        <button class="btn btn-success col-md-offset-2"><a class="nav-link"  href="/signup.jsp">SignUp<a/></button>
                    </form> 

                </div>
                <div class="col-md-3"></div>
            </div>
        </div>       
        <script>
            $(document).ready(function () {
                $("#submit-btn").click(function (e) {
                    var username = $("#usrname").val();
                    var password = $("#psw").val();

                    // Remove any old error messages
                    $(".error-msg").remove();

                    // Check if either "Username" or "Password" is empty and display error messages
                    if (username === "" || password === "") {
                        e.preventDefault(); // Prevent form submission
                        if (username === "") {
                            $("#usrname").after('<p class="error-msg">Username is required</p>');
                        }
                        if (password === "") {
                            $("#psw").after('<p class="error-msg">Password is required</p>');
                        }
                    }
                });

                // Existing code for user interactions
            });
        </script>


    </body>
</html>
