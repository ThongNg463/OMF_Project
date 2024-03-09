<%-- 
    Document   : otpCf
    Created on : Oct 11, 2023, 7:03:06 PM
    Author     : ASUS
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>OTP</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
        <!-- Additional CSS Files -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap">
        <link rel="stylesheet" href="/assets/css/fontawesome.css">
        <link rel="stylesheet" href="/assets/css/style.css">
        <link rel="stylesheet" href="/assets/css/owl.css">
        <link rel="stylesheet" href="/assets/css/animate.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css" />
    </head>
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }

        body {
            background-color:#000000;
            background-image:linear-gradient(180deg,#000000 10%, #232323 100%);
            background-size:cover;
            padding: 0;
        }

        header {
            height: 60px; /* Đặt chiều cao của header */
            background: transparent; /* Đặt màu nền trong suốt hoặc thứ khác cho header */
        }


        @keyframes blink-animation {
            0% {
                box-shadow: 0 0 5px rgba(33, 150, 243, 0.7);
            }
            50% {
                box-shadow: 0 0 20px rgba(33, 150, 243, 0.7);
            }
            100% {
                box-shadow: 0 0 5px rgba(33, 150, 243, 0.7);
            }
        }
        .text-center h3{
            margin-top:30px;
            color: #000000;
            padding: 20px;
            padding-bottom: 20px;
            letter-spacing: 5px;
        }
        .list-otp{
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100%;
            margin-bottom: 18px;
        }
        .otp-input-container {
            display: flex;
            gap: 5px;
            margin-top: 10px;
        }
        .otp-input-container input[type="text"] {
            width: 40px;
            height: 40px;
            text-align: center;
            align-items: center;
            border: 1px solid #999999;
            border-radius: 5px;
            font-size: 16px;
        }
        .login-button{
            margin-left: 33%;
            width: auto;
        }
        .confirm:hover{
            background-color: #4e73df;
        }
        .confirm{
            background: #4e73df;
            border: none;
            padding: 5px;
            text-decoration: none;
            margin-bottom: 15px;
        }
    </style>
    <body>
        <div class="container-fluid" style="padding: 150px 0;">
            <div id="toast" style="z-index: 1000000;"></div>
            <div class="">
                <div class="rounded d-flex justify-content-center" >
                    <div class="col-lg-4 col-md-6 col-sm-12 background-light" style="background-color: rgba(255, 255, 255, .9); border-radius: 25px; box-shadow: 0 0 30px black;border: 2px solid rgba(255, 255, 255, .5); backdrop-filter: blur(20px);">
                        <div class="text-center">
                            <h3>ENTER OTP</h3>
                            <% if (request.getParameter("error") != null && request.getParameter("error").equals("1")) { %>
                            <p class="error-message">Wrong OTP. Please try again</p>
                            <% }%>
                        </div>
                        <form method="post" class="otp-form">
                            <div class="list-otp">
                                <div class="otp-input-container">
                                    <input type="text" name="characters1" maxlength="1" required style="width: 30px; margin: 0 5px;">
                                    <input type="text" name="characters2" maxlength="1" required style="width: 30px; margin: 0 5px;">
                                    <input type="text" name="characters3" maxlength="1" required style="width: 30px; margin: 0 5px;">
                                    <input type="text" name="characters4" maxlength="1" required style="width: 30px; margin: 0 5px;">
                                    <input type="text" name="characters5" maxlength="1" required style="width: 30px; margin: 0 5px;">
                                    <input type="text" name="characters6" maxlength="1" required style="width: 30px; margin: 0 5px;">
                                    <input type="hidden" name="sentOTP" value="<%= session.getAttribute("otp")%>">
                                    <input type="hidden" name="sentOTP" value="<%= session.getAttribute("email")%>">
                                </div>
                            </div>
                            <div class="login-button">
                                <input class="w-50 btn btn-primary text-center mt-2 confirm" type="submit" value="Confirm" name="btnConfirmOTP">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <!-- Bootstrap core JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.j s"></script>
        <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
        <script src="/assets/js/isotope.js"></script>
        <script src="/assets/js/owl-carousel.js"></script>
        <script src="/assets/js/tabs.js"></script>
        <script src="/assets/js/custom.js"></script>
        <script src="/assets/js/toast.js"></script>
    </body>
</html>