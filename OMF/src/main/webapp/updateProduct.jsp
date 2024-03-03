<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Product</title>
        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <link href="/img/favicon.ico" rel="icon">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
        <link href="/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
        <link href="/css/bootstrap.min.css" rel="stylesheet">
        <link href="/css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css"/>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.3/dist/jquery.validate.min.js"></script>
        <link href="img/favicon.ico" rel="icon">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha384-KyZXEAg3QhqLMpG8r+eq6f4zffFz6l5r5w2oZKfObw5urpE4Ehnmz5b5BXzgf8Ud" crossorigin="anonymous">
    </head>

    <style>
        .bg-light{
            background: #daecff;
        }
        .product-button-word:hover{
            color: white;
        }
        #brand-button {
            margin-bottom: 15px;
            transition: all 0.3s; /* Thời gian chuyển tiếp khi hover (0.3 giây) */
        }

        #brand-button:hover {
            background-color: #5eb5ff; /* Màu nền khi hover */
            transform: scale(0.95); /* Thu nhỏ nút khi hover (90% kích thước gốc) */
        }
        .dropdown-item{
            color: black;
            background: white;
        }
        .dropdown-item:hover{
            color: white;
            background: #5eb5ff;
        }
        .error-field {
            color: red;
        }
    </style>

    <body>
        <!-- Sidebar Start -->
        <div class="sidebar bg-light pe-4 pb-3">
            <nav class="navbar bg-light navbar-light">
                <a href="/homeManagement" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary"></i>HOME</h3>
                </a>

                <div class="d-flex align-items-center ms-4 mb-4">
                    <div class="position-relative">
                        <i style="color: black;" class="fas fa-user-tie fa-lg"></i>
                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                    </div>
                    <div class="ms-3">
                        <h6 class="mb-0">
                            <c:choose>
                                <c:when test="${role_id == 1}">
                                    ADMIN
                                </c:when>
                                <c:when test="${role_id == 2}">
                                    STAFF
                                </c:when>
                            </c:choose>
                        </h6>
                    </div>
                </div>

                <div class="navbar-nav w-100 bg-light">
                    <a href="homeManagement.jsp" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Manager</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="/OMF/productManagement" class="dropdown-item active">Product</a>
                            <a href="/homeManagement/brandManagement" class="dropdown-item">Brand</a>
                            <a href="/homeManagement/categoryManagement" class="dropdown-item">Category</a>
                            <a href="/homeManagement/customerManagement" class="dropdown-item">Customer</a>
                            <a href="/homeManagement/staffManagement" class="dropdown-item">Staff</a>
                            <a href="/homeManagement/voucherManagement" class="dropdown-item">Voucher</a>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->

        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
                <a href="index.html" class="navbar-brand d-flex d-lg-none me-4">
                    <h2 class="text-primary mb-0"><i class="fas fa-house"></i></h2>
                </a>
                <a href="#" class="sidebar-toggler flex-shrink-0">
                    <i class="fa fa-bars"></i>
                </a>
                <div class="navbar-nav align-items-center ms-auto">

                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                            <i class="fas fa-user-tie fa-lg"></i>
                            <span class="d-none d-lg-inline-flex">${username}</span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end bg-white rounded-0 rounded-bottom m-0" >
                            <a href="/account/managerProfile" class="dropdown-item">My Profile</a>
                            <a href="/user/logout" class="dropdown-item">Log Out</a>
                        </div>
                    </div>
                </div>
            </nav>
            <!-- Navbar End -->

            <!-- Content Start -->
            <div class="content">
                <!-- Form Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="row g-4">
                        <div class="col-12">
                            <div class="bg-light rounded h-100 p-4">
                                <div class="in-brand-management" style="background-color: white; padding: 15px; border-radius: 20px;">
                                    <h6 class="mb-4">EDIT PRODUCT</h6>
                                    <form id="update-form" method="post" action="updateProduct">

                                        <input type="hidden" name="action" value="updateProduct"> <!-- Hidden field to indicate update action -->

                                        <label style="color: black; width: 90px;" >Product ID</label>
                                        <input style="width: 70%;" name="ProID" type="text" class="form-control validate" required value="${product.proID}" readonly/>

                                        <label style="color: black;" for="ProName">Product Name</label>
                                        <input style="width: 70%;" id="ProName" name="ProName" type="text" class="form-control validate" required value="${product.proName}"/>

                                        <label style="color: black;" for="ProStock">Stock</label>
                                        <input style="width: 70%;" id="ProStock" name="ProStock" type="number" class="form-control validate" required value="${product.proStock}" />

                                        <label style="color: black;" for="ProPrice">Price</label>
                                        <input style="width: 70%;" id="ProPrice" name="ProPrice" type="text" class="form-control validate" required value="${product.proPrice}" />

                                        <label style="color: black;" for="ProDes">Description</label>
                                        <textarea style="width: 70%;" class="form-control validate" id="ProDes" name="ProDes" rows="3" required>${product.proDes}</textarea>

                                        <label style="color: black;" for="ProType">Type</label>
                                        <input style="width: 70%;" id="ProType" name="ProType" type="text" class="form-control validate" required value="${product.proType}" readonly/>

                                        <label style="color: black;" for="ProPic">Picture</label>
                                        <input style="width: 70%;" id="ProPic" name="ProPic" type="text" class="form-control validate" required value="${product.proPic}" readonly/>

                                        <c:if test="${not empty errorMessage}">
                                            <p class="error-field">${errorMessage}</p>
                                        </c:if>
                                        <c:if test="${not empty successMessage}">
                                            <p class="success-field">${successMessage}</p>
                                        </c:if>

                                        <div class="col-12" style="margin-top: 10px;">
                                            <button type="submit" name="btnEditProduct" class="btn btn-primary btn-block text-uppercase">Update</button>
                                        </div>
                                    </form> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Table End -->


            <!-- Footer Start -->
            <div class="container-fluid pt-4 px-4">
            </div>
            <!-- Footer End -->
        </div>
        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>



        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/lib/chart/chart.min.js"></script>
        <script src="/lib/easing/easing.min.js"></script>
        <script src="/lib/waypoints/waypoints.min.js"></script>
        <script src="/lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="/lib/tempusdominus/js/moment.min.js"></script>
        <script src="/lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


    </body>
</html>
