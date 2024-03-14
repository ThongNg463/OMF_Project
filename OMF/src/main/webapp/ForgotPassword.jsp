<%-- 
    Document   : forgot-password
    Created on : Mar 8, 2024, 4:07:08 PM
    Author     : Kara
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Forgot Password</title>
        <!-- Favicons -->
        <link href="./assets/img/favicon.png" rel="icon">

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

    <!-- Custom fonts for this template-->
    <link href="/UI/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/UI/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-password-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-2">Forgot Your Password?</h1>
                                        <p class="mb-4">We get it, stuff happens. Just enter your email address below
                                            and we'll send you a OTP to reset your password</p>
                                    </div>
                                    <div class="form-box change-password">                                     
                                        <form action="#" method="POST">
                                            <div class="form-group" action="forgot-password" method="POST">
                                                <input class="form-control form-control-user" type="email" id="Mail" name="Mail" placeholder="Enter your email"  required>
                                                <label class="input-label" for="email" place></label>
                                                
                                            </div>
                                            <div id="error-message" class="error-message"></div>
                                            <div class="button-back">
                                                <button type="submit" class="btn btn-primary btn-user btn-block" id="sendButton" name="btnSendEmail">
                                                    <div class="loading-bar">
                                                        <div class="loading-progress"></div>
                                                    </div>
                                                    <span class="loading-text">Send OTP to email</span>
                                                </button>
                                            </div>
                                        </form>
                                        <p>${mess}</p>
                                    </div>
                                    <hr>
                                    <div class="text-center">
                                        <a class="small" href="Signup">Create an Account!</a>
                                    </div>
                                    <div class="text-center">
                                        <a class="small" href="/Login">Already have an account? Login!</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>
    <script>
        function validateForm() {
            var emailInput = document.getElementById("email");
            var errorMessage = document.getElementById("error-message");

            if (emailInput.value.trim() === "") {
                errorMessage.textContent = "Please enter your email";
                return false;
            } else {
                errorMessage.textContent = "";
            }
        }
    </script>

</body>
</html>
