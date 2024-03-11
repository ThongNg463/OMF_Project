<%-- 
    Document   : changePassword
    Created on : Oct 11, 2023, 11:30:20 PM
    Author     : ASUS
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
    <head>
        <script src="eye.js"></script>
        <title>Change Password</title>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

        <!-- Custom fonts for this template-->
        <link href="UI/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="UI/css/sb-admin-2.min.css" rel="stylesheet">
        <style>
            body {
                font-family: "Poppins", sans-serif;
                margin: 0;
                padding: 0;
            }
            .form-box h1{
                font-size: 2em;
                color: white;
                text-align: center;
            }
            .input-box{
                position: relative;
                width: 100%;
                height: 50px;
                border-bottom: 2px solid #000;
                margin: 30px 0;
            }
            .input-box:hover{
                border-bottom: 2px solid #27A4F2;
            }
            .input-box i{
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                font-size: 20px;
                color: white;
                right: 0px;
                cursor: pointer;
            }
            .input-box label{
                position: absolute;
                top: 50%;
                left: 5px;
                transform: translateY(-50%);
                font-size: 1em;
                color: white;
                font-weight: 500;
                pointer-events: none;
                transition: .5s;
            }
            .input-box input:focus~label,
            .input-box input:valid~label{
                top: -5px;
            }
            .input-box input{
                width: 100%;
                height: 100%;
                background: transparent;
                border: none;
                outline: none;
                font-size: 1em;
                color: white;
                font-weight: 600;
            }
            .submit-button{
                width: 100%;
                height: 45px;
                background: #27A4F2;
                border: none;
                outline: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 1em;
                color: white;
                font-weight: 500;
            }
            .button-back button{
                transition: all 0.3s;
            }
            .button-back button:hover{
                background-color: #5eb5ff;
                transform: scale(0.95);
            }
        </style>
    </head>
    <body class="bg-gradient-primary">

        <div class="container">

            <div class="card o-hidden border-0 shadow-lg my-5">
                <div class="card-body p-0">
                    <!-- Nested Row within Card Body -->
                    <div class="row">
                        <div class="col-lg-5 d-none d-lg-block bg-register-image">

                        </div>
                        <div class="col-lg-7">
                            <div class="p-5">
                                <div class="text-center">
                                    <h1 class="h4 text-gray-900 mb-4">Change Password</h1>
                                </div>
                                <form class="user" method="POST">
                                   
                                        <input type="hidden" name="email" value="<%= session.getAttribute("email")%>">
                                        <div class="form-group">
                                            <input class="form-control form-control-user" type="password" id="newPassword" name="newPassword" placeholder="Password" style="color: black;" required>
                                           
                                           
                                        </div>

                                        <div class="form-group">
                                            <input class="form-control form-control-user" type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" style="color: black;" required>
                                          
                                            
                                        </div>

                                        <p style="color: red">${msg}</p>

                                        <div class="button-back">
                                            <button type="submit" class="btn btn-primary btn-user btn-block" name="btnReset">Change password</button>
                                        </div>
                                   
                                </form>
                                <hr>
                                <div class="text-center">
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>



        <script>
            //code cript bat loi o day
            if ("${requestScope.loginStatus}" === "failure") {
                showErrorLogin();
            <%
                request.setAttribute("loginStatus", null);
            %>
            }
            $(document).ready(function () {
                $('#loginform').validate({
                    rules: {
                        // Define validation rules for your form fields


                        newPassword: {
                            required: true, // Field is required
                            minlength: 6, // Minimum length of 5 characters
                            maxlength: 50, // Minimum length of 5 characters
                        },
                        confirmPassword: {
                            required: true,
                            equalTo: "#password"
                        },

                        // Add more fields and rules as needed
                    },
                    messages: {
                        // Define error messages for your form fields                        
                        newPassword: {
                            required: 'Please enter a value for this field',
                            minlength: 'Minimum length is 6 characters',
                            maxlength: 'Maximum length is 50 characters',
                        },
                        confirmPassword: {
                            required: 'Please enter a value for this field',
                            equalTo: 'Passwords do not match'
                        },
                        // Add more fields and messages as needed
                    }
                });
            });
        </script>
        <script>
            let eyeiconNew = document.getElementById("eyeiconNew");
            let passwordNew = document.getElementById("newPassword");

            eyeiconNew.onclick = function () {
                if (passwordNew.type === "password") {
                    passwordNew.type = "text";
                    eyeiconNew.classList.remove("fa-eye-slash");
                    eyeiconNew.classList.add("fa-eye");
                } else {
                    passwordNew.type = "password";
                    eyeiconNew.classList.remove("fa-eye");
                    eyeiconNew.classList.add("fa-eye-slash");
                }
            }

            let eyeiconConfirm = document.getElementById("eyeiconConfirm");
            let passwordConfirm = document.getElementById("confirmPassword");

            eyeiconConfirm.onclick = function () {
                if (passwordConfirm.type === "password") {
                    passwordConfirm.type = "text";
                    eyeiconConfirm.classList.remove("fa-eye-slash");
                    eyeiconConfirm.classList.add("fa-eye");
                } else {
                    passwordConfirm.type = "password";
                    eyeiconConfirm.classList.remove("fa-eye");
                    eyeiconConfirm.classList.add("fa-eye-slash");
                }
            }
        </script>
    </body>
</html>
