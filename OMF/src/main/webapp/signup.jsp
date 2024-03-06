<%@page import="DAOs.ProductDAO"%>
<%@page import="Models.account"%>
<%@page import="DAOs.accountDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <title>Restaurantly</title>
        <meta content="" name="description">
        <meta content="" name="keywords">

        <!-- Favicons -->
        <link href="./assets/img/favicon.png" rel="icon">
        <link href="./assets/img/apple-touch-icon.png" rel="apple-touch-icon">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

        <!-- Vendor CSS Files -->
        <link href="./assets/vendor/animate.css/animate.min.css" rel="stylesheet">
        <link href="./assets/vendor/aos/aos.css" rel="stylesheet">
        <link href="./assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="./assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="./assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
        <link href="/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
        <link href="./assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.1/css/boxicons.min.css" integrity="sha512-1G4xgZ6x60t7U0LyT0xMl0Zn8DVLb5Qgj5LbLh0zzzFJQaCRW8ZZT3wHjVdYKdY5mreMZc4E6xFVKA+joz9/gQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <!-- Template Main CSS File -->
        <link href="assets/css/home.css" rel="stylesheet">

    </head>

    <body>
        <!-- ======= Top Bar ======= -->
        <div id="topbar" class="d-flex align-items-center fixed-top">
            <div class="container d-flex justify-content-center justify-content-md-between">
                <div class="contact-info d-flex align-items-center">
                    <div>Contact: +84 123456789 |</div> <br>
                    <div>Opening: Mon-Sat: 7AM - 22PM</div>
                </div>
                <%
                    accountDAO AccDAO = new accountDAO();
                    account userAcc = new account();

                    String username = null;
                    Cookie[] cookies = request.getCookies();
                    if (cookies != null) {
                        for (Cookie cookie : cookies) {
                            if ("User".equals(cookie.getName())) {
                                username = cookie.getValue();
                                break;
                            }
                        }
                    }

                    boolean isLogin = false;

                    if (username != null && !username.isEmpty()) {
                        isLogin = true;
                        userAcc = AccDAO.getAccount(username);
                        // Người dùng đã đăng nhập, hiển thị chào mừng với tên người dùng
%>
                <div class="languages d-none d-md-flex align-items-center">
                    <h4><%= username%> | <a href="/logout" style="text-decoration: none;"> (Sign out)</a></h4>
                </div>
                <%
                } else {
                    // Người dùng chưa đăng nhập, hiển thị các tùy chọn đăng nhập/đăng ký
                %>
                <div class="languages d-none d-md-flex align-items-center">
                    <h4><a href="/Login">Login</a> | <a href="/signup.jsp">Sign Up</a></h4>
                </div>
                <%
                    }
                %>
            </div>


        </div>

        <!-- ======= Header ======= -->
        <header id="header" class="fixed-top d-flex align-items-cente">
            <div class="container-fluid container-xl d-flex align-items-center justify-content-lg-between">

                <h1 class="logo me-auto me-lg-0"><a href="/Home">Restaurantly</a></h1>
                <!-- Uncomment below if you prefer to use an image logo -->
                <!-- <a href="index.html" class="logo me-auto me-lg-0"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

                <nav id="navbar" class="navbar order-last order-lg-0">
                    <ul>
                        <li><a class="nav-link scrollto active" href="#hero">Home</a></li>
                        <li><a class="nav-link scrollto" href="#about">About</a></li>
                        <li><a class="nav-link scrollto" href="#menu">Menu</a></li>
                        <li><a class="nav-link scrollto" href="#specials">Specials</a></li>
                        <li><a class="nav-link scrollto" href="#events">Events</a></li>
                        <li><a class="nav-link scrollto" href="#gallery">Gallery</a></li>
                        <li><a class="nav-link scrollto" href="#chefs">Members</a></li>
                        <li><a class="nav-link scrollto" href="#contact">Contact</a></li>
                            <%  if (isLogin && userAcc.getRole().equals("Admin")) { %>
                        <li class="dropdown"><a href="#"><span>Admin</span></a>
                            <ul>
                                <li><a href="/prlist/ds">Products List</a></li>
                                <li><a href="/olist/ds">Orders List</a></li>
                            </ul>
                        </li>       
                        <% }%>
                    </ul>
                    <i class="bi bi-list mobile-nav-toggle"></i>
                </nav><!-- .navbar -->
                <a href="#book-a-table" class="book-a-table-btn scrollto d-none d-lg-flex">Order food</a>

            </div>
        </header><!-- End Header -->

        <!-- ======= Contact Section ======= -->
        <section id="contact" class="contact">
            <div class="container" data-aos="fade-up">

                <div class="section-title">
                    <h2>Contact</h2>
                    <p>Contact Us</p>
                </div>
            </div>

            <div class="container" data-aos="fade-up">

                <div class="row mt-5">

                    <div class="col-lg-4">
                        <div class="info">
                            <div class="address">
                                <i class="bi bi-geo-alt"></i>
                                <h4>Location:</h4>
                                <p>NVC District, FPT University, Can Tho</p>
                            </div>

                            <div class="open-hours">
                                <i class="bi bi-clock"></i>
                                <h4>Open Hours:</h4>
                                <p>
                                    Monday-Saturday:<br>
                                    7:00 AM - 22:00 PM
                                </p>
                            </div>

                            <div class="email">
                                <i class="bi bi-envelope"></i>
                                <h4>Email:</h4>
                                <p>nhom1.fpt@hotmail.com</p>
                            </div>

                            <div class="phone">
                                <i class="bi bi-telephone"></i>
                                <h4>Call:</h4>
                                <p>+84 123456789</p>
                            </div>

                        </div>

                    </div>

                    <div class="col-lg-8 mt-5 mt-lg-0">

                        <form action="signup" method="POST" role="form" class="php-email-form">
                            <%
                                String error = request.getParameter("error");
                                if ("usernameexists".equals(error)) {
                            %>
                            <h2 style="color: #ff0000; text-align: center" class="error-msg">Account already exist! Please try again!</h2>
                            <%
                            } else if ("Password".equals(error)) {
                            %>
                            <h2 style="color: #ff0000; text-align: center" class="error-msg">Passwords do not match! Please try again!</h2>
                            <%
                                }
                            %>

                            <div class="row mb-3">
                                <div class="col-md-6 form-group">
                                    <input type="text" name="username" class="form-control" id="user-name" placeholder="Username" required>
                                </div>
                                <div class="col-md-6 form-group mt-3 mt-md-0">
                                    <input type="password" class="form-control" name="userpass" id="user-pass" placeholder="Password" required>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-6 form-group">
                                    <input type="password" class="form-control" name="repass" id="user-repass" placeholder="Confirm Password" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-check">
                                        <input  type="checkbox" value="" id="terms-checkbox" required>
                                        <label class="form-check-label" for="terms-checkbox">
                                            I Agree To The Terms & Conditions
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center">
                                <input type="submit" id="submit-btn" value="SIGNUP">Sign Up
                            </div>
                        </form>

                    </div>

                </div>

            </div>
        </section><!-- End Contact Section -->

    </main><!-- End #main -->

    <!-- ======= Footer ======= -->
    <footer id="footer">
        <div class="footer-top">
            <div class="container">
                <div class="row">

                    <div class="col-lg-3 col-md-6">
                        <div class="footer-info">
                            <h3>Restaurantly</h3>
                            <p>
                                NVC District <br>
                                FPT University, Can Tho<br><br>
                                <strong>Phone:</strong> +84 123456789<br>
                                <strong>Email:</strong> nhom1.fpt@hotmail.com<br>
                            </p>
                            <div class="social-links mt-3">
                                <a href="#" class="twitter"><i class="bx bxl-twitter"></i></a>
                                <a href="#" class="facebook"><i class="bx bxl-facebook"></i></a>
                                <a href="#" class="instagram"><i class="bx bxl-instagram"></i></a>
                                <a href="#" class="google-plus"><i class="bx bxl-skype"></i></a>
                                <a href="#" class="linkedin"><i class="bx bxl-linkedin"></i></a>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-2 col-md-6 footer-links">
                        <h4>Useful Links</h4>
                        <ul>
                            <li><i class="bx bx-chevron-right"></i> <a href="#">Home</a></li>
                            <li><i class="bx bx-chevron-right"></i> <a href="#">About us</a></li>
                            <li><i class="bx bx-chevron-right"></i> <a href="#">Services</a></li>
                            <li><i class="bx bx-chevron-right"></i> <a href="#">Terms of service</a></li>
                            <li><i class="bx bx-chevron-right"></i> <a href="#">Privacy policy</a></li>
                        </ul>
                    </div>

                    <div class="col-lg-3 col-md-6 footer-links">
                        <h4>Our Services</h4>
                        <ul>
                            <li><i class="bx bx-chevron-right"></i> <a href="#">Web Design</a></li>
                            <li><i class="bx bx-chevron-right"></i> <a href="#">Web Development</a></li>
                            <li><i class="bx bx-chevron-right"></i> <a href="#">Product Management</a></li>
                            <li><i class="bx bx-chevron-right"></i> <a href="#">Marketing</a></li>
                            <li><i class="bx bx-chevron-right"></i> <a href="#">Graphic Design</a></li>
                        </ul>
                    </div>

                    <div class="col-lg-4 col-md-6 footer-newsletter">
                        <h4>Our Newsletter</h4>
                        <p>Please follow and subscribe to receive new information about us</p>
                        <form action="" method="post">
                            <input type="email" name="email"><input type="submit" value="Subscribe">
                        </form>

                    </div>

                </div>
            </div>
        </div>

        <div class="container">
            <div class="copyright">
                &copy; Copyright <strong><span>Nhom 1</span></strong>. All Rights Reserved
            </div>
            <div class="credits"> 
                Designed by <a href="#">Nhom 1 Mai Dinh</a>
            </div>
        </div>
    </footer><!-- End Footer -->

    <div id="preloader"></div>
    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

    <!-- Vendor JS Files -->
    <script src="assets/vendor/aos/aos.js"></script>
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
    <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
    <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
    <script src="assets/vendor/php-email-form/validate.js"></script>
    <script src="javascripts/jquery-3.7.0.min.js"></script>

    <!-- Template Main JS File -->
    <script src="assets/js/main.js"></script>

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