<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>SB Admin 2 - Register</title>
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
                                    <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
                                </div>
                                <form class="user" action="Signup" method="POST">
                                    <% String error = request.getParameter("error");
                                        if ("usernameexists".equals(error)) { %>
                                    <h2 style="color: #ff0000; text-align: center" class="error-msg">Account already exists! Please try again!</h2>
                                    <% } else if ("Password".equals(error)) { %>
                                    <h2 style="color: #ff0000; text-align: center" class="error-msg">Passwords do not match! Please try again!</h2>
                                    <% }%>

                                    <div class="form-group">
                                        <input type="text" class="form-control form-control-user" id="user-name" name="username" placeholder="Username" required>
                                    </div>

                                    <div class="form-group">
                                        <input type="text" class="form-control form-control-user" id="user-fullname" name="fullname" placeholder="Fullname" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="email" class="form-control form-control-user" id="user-email" name="email" placeholder="Email" required>
                                    </div>
                                    <div class="form-group">
                                        <input type="tel" class="form-control form-control-user" id="user-phone" name="phone" placeholder="Phone" required>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-6 mb-3 mb-sm-0">
                                            <input type="password" class="form-control form-control-user" id="user-pass" name="userpass" placeholder="Password" required>
                                        </div>
                                        <div class="col-sm-6">
                                            <input type="password" class="form-control form-control-user" id="user-repass" name="repass" placeholder="Repeat Password" required>
                                        </div>
                                    </div>
                                    <input type="submit" class="btn btn-primary btn-user btn-block" id="Signup" value="SIGNUP">
                                    <hr>
                                    <a href="index.html" class="btn btn-google btn-user btn-block">
                                        <i class="fab fa-google fa-fw"></i> Register with Google
                                    </a>
                                    <a href="index.html" class="btn btn-facebook btn-user btn-block">
                                        <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                                    </a>
                                </form>
                                <hr>
                                <div class="text-center">
                                    <a class="small" href="/Login">Already have an account? Login!</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- Bootstrap core JavaScript-->
        <script src="UI/vendor/jquery/jquery.min.js"></script>
        <script src="UI/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Core plugin JavaScript-->
        <script src="UI/vendor/jquery-easing/jquery.easing.min.js"></script>

        <!-- Custom scripts for all pages-->
        <script src="UI/js/sb-admin-2.min.js"></script>

    </body>

</html>
