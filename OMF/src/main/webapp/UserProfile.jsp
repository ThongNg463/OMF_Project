<%-- 
    Document   : userProfile
    Created on : Mar 7, 2024, 2:24:31 PM
    Author     : mthon
--%>

<%@page import="DAOs.UserAccountDAO"%>
<%@page import="Models.UserAccount"%>
<%@page import="Models.Account"%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Profile</title>
        <!-- Favicons -->
        <link href="./assets/img/favicon.png" rel="icon">
        <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css'>
        <script src='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js'></script>
        <link href="/UI/css/sb-admin-2.min.css" rel="stylesheet">
        <style>
            /* The Modal (background) */
            .modal {
                display: none; /* Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 1; /* Sit on top */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                overflow: hidden; /* Enable scroll if needed */
                background-color: rgb(0,0,0); /* Fallback color */
                background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            }

            .modal-button {
                cursor: pointer; /* Con trỏ chuột */
            }

            .modal-button:focus {
                outline: none; /* Bỏ viền nổi */
                box-shadow: 0 0 0 0.2rem rgba(255, 193, 7, 0.5); /* Bóng khi focus giống như Bootstrap */
            }

            /* Modal Content/Box */
            .modal-content {
                margin: 15px auto; /* Điều chỉnh lề */
                padding: 20px; /* Điều chỉnh đệm */
                border: 1px solid #888;
                width: 80%; /* Chỉnh chiều rộng tùy theo nhu cầu */
                max-width: 800px; /* Đặt giới hạn chiều rộng tối đa để tránh quá lớn trên màn hình rộng */
                overflow: hidden; /* Ẩn nội dung tràn ra ngoài */
                background: #fff; /* Màu nền cho modal */
                border-radius: 8px; /* Bo tròn góc */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Bóng đổ nhẹ */
                position: relative; /* Để thêm "close" button vào vị trí */
                max-height: calc(100vh - 40px); /* Đảm bảo modal không quá cao */
                overflow-y: auto; /* Cho phép cuộn nếu nội dung quá dài */
            }

            /* Định dạng cho bảng bên trong modal */
            .modal-content table {
                width: 100%; /* Chiều rộng tối đa */
                max-width: 100%; /* Đảm bảo bảng không quá rộng */
                margin-bottom: 1rem;
                border-collapse: collapse; /* Bỏ các khoảng cách giữa các cell */
            }

            .modal-content th,
            .modal-content td {
                padding: .75rem; /* Đệm cho từng cell */
                vertical-align: top; /* Căn đỉnh cho nội dung */
                border-top: 1px solid #dee2e6; /* Đường viền trên mỗi cell */
            }

            .modal-content th {
                vertical-align: bottom; /* Căn đáy cho header */
                border-bottom: 2px solid #dee2e6; /* Đường viền đậm cho header */
            }

            /* Thêm phong cách cho nút đóng */
            .close {
                position: absolute; /* Định vị tuyệt đối so với .modal-content */
                right: 20px; /* Lề phải */
top: 20px; /* Lề trên */
                z-index: 2; /* Đảm bảo nút ở trên cùng */
            }
        </style>
    </head>
    <body class="bg-gradient-primary">
        <%
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
            UserAccountDAO AccDAO = new UserAccountDAO();
            UserAccount userAcc = AccDAO.getUserAccount(username);

            AccountDAO accDAO = new AccountDAO();
            Account UserAcc = accDAO.getAccount(username);
        %>
        <div class="container-xl px-4 mt-4">
            <nav class="nav nav-borders">
                <a class="nav-link active ms-0" href="#">Profile</a>
                <a class="nav-link" href="/Home">Back to Home page</a>
            </nav>

            <hr class="mt-0 mb-4">
            <div class="row">
                <div class="col-xl-4">
                    <!-- Profile picture card-->
                    <div class="card mb-4 mb-xl-0">
                        <div class="card-header">Profile Picture</div>
                        <div class="card-body text-center">
                            <!-- Profile picture image-->
                            <img class="img-account-profile rounded-circle mb-2" src="<%= UserAcc.getAccPic()%>" alt="" style="height: 110px; width: 110px">
                            <!-- Profile picture help block-->
                            <div class="small font-italic text-muted mb-4">JPG or PNG no larger than 5 MB</div>
                            <!-- Profile picture upload button-->
                            <h4><%=userAcc.getUserID()%></h4>
                            <p class="text-secondary mb-1">Full Stack Developer</p>
                            <p class="text-muted font-size-sm">Nguyen Van Cu, Ninh Kieu</p>
                            <button class="btn btn-warning btn-sm text-light shadow-lg rounded modal-button" data-modal="myModalAddNew">
                                <i class="fa-solid fa-circle-plus"></i> Update Picture Profile
                            </button>
                            <div id="myModalAddNew" class="modal">
                                <!-- Modal content -->

                                <div class="modal-content">

                                    <H1>Update Profile Picture</H1>
                                    <span class="close" style="cursor: pointer">&times;</span>
                                    <br>
                                    <form method="post">


                                        <input type="hidden" name="Username" value="<%=UserAcc.getUsername()%>">
                                        <input type="hidden" name="Password" value="<%=UserAcc.getPassword()%>">
                                        <input type="hidden" name="Role" value="<%=UserAcc.getRole()%>">
                                        <div class="form-group">
                                            <label class="form-label h4">Picture Url:</label> 
                                            <div><input class="form-control" type="text" name="AccPic" placeholder="Enter image URL here" required></div> <br/>    
                                        </div>
                                        <button onclick="return confirm('Update this pic?')" class="btn btn-primary" type="submit" name="btnUpdate" value="Update">Upload new image</button>       
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-8">
                    <!-- Account details card-->
                    <div class="card mb-4">
                        <div class="card-header">Account Details</div>
                        <div class="card-body">
                            <form method="post">
                                <!-- Form Group (username)-->
                                <div class="mb-3">
                                    <label class="small mb-1" for="inputUsername">Full Name</label>
                                    <input class="form-control" type="text" placeholder="Enter your full name" name="Fullname" value="<%=userAcc.getFullname()%>">
                                </div>
                                <!-- Form Row-->
                                <div class="row gx-3 mb-3">
                                    <!-- Form Group (first name)-->
                                    <div class="col-md-6">
                                        <label class="small mb-1" for="inputFirstName">UserID</label>
                                        <input readonly class="form-control" type="text" placeholder="Enter your UserID" name="UserID" value="<%=userAcc.getUserID()%>">
                                    </div>
                                    <!-- Form Group (last name)-->
                                    <div class="col-md-6">
                                        <label class="small mb-1" for="inputLastName">Wallet</label>
                                        <input class="form-control" type="text" placeholder="Total Money" name="Wallet" value="<%=userAcc.getWallet()%>">
                                    </div>
                                </div>
                                <!-- Form Row        -->
                                <div class="row gx-3 mb-3">
                                    <!-- Form Group (organization name)-->
                                    <div class="col-md-6">
                                        <label class="small mb-1" for="inputOrgName">Address</label>
                                        <input class="form-control" type="text" placeholder="Enter your address" name="Address" value="<%=userAcc.getAddress()%>">
                                    </div>
                                    <!-- Form Group (location)-->
                                    <div class="col-md-6">
                                        <label class="small mb-1" for="inputLocation">City</label>
                                        <input class="form-control" type="text" placeholder="Enter your city" name="City" value="<%=userAcc.getCity()%>">
                                    </div>
                                </div>
                                <!-- Form Group (email address)-->
                                <div class="mb-3">
                                    <label class="small mb-1" for="inputEmailAddress">Email address</label>
                                    <input class="form-control" type="email" placeholder="Enter your email address" name="Mail" value="<%=userAcc.getMail()%>">
                                </div>
                                <!-- Form Row-->
                                <div class="row gx-3 mb-3">
                                    <!-- Form Group (phone number)-->
                                    <div class="col-md-6">
                                        <label class="small mb-1" for="inputPhone">Phone number</label>
                                        <input class="form-control" type="tel" placeholder="Enter your phone number" name="Phone" value="<%=userAcc.getPhone()%>">
                                    </div>
                                    <!-- Form Group (birthday)-->
                                    <div class="col-md-6">
                                        <label class="small mb-1" for="inputBirthday">Total orders</label>
                                        <input class="form-control" type="text" name="birthday" placeholder="Total orders" value="Orders count">
                                    </div>
                                </div>
                                <!-- Save changes button-->
                                <button onclick="return confirm('Save changes?')" class="btn btn-primary" type="submit" name="btnUpdates" value="Updates">Save changes</button>
                            </form>
                        </div>
                    </div>

                </div>
            </div>
        </div>
                                    <script>

            // Get all buttons that opens a modal
            var modalButtons = document.querySelectorAll('.modal-button');

            // Get all modals
            var modals = document.querySelectorAll('.modal');

            // Get all elements that closes the modal
            var closeSpans = document.querySelectorAll('.close');

            // Attach click event listener to modal buttons
            modalButtons.forEach(function (btn) {
                btn.onclick = function () {
                    var modal = document.getElementById(btn.getAttribute('data-modal'));
                    modal.style.display = "block";
                }
            });

            // Attach click event listener to close buttons
            closeSpans.forEach(function (span) {
                span.onclick = function () {
                    span.closest('.modal').style.display = "none";
                }
            });

            // Click anywhere outside of the modal to close it
            window.onclick = function (event) {
                if (event.target.classList.contains('modal')) {
                    event.target.style.display = "none";
                }
            }
        </script>
    </body>
</html>
