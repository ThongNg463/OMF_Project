<%-- 
    Document   : HomeManagement
    Created on : Feb 13, 2023, 10:26:43 AM
    Author     : Huy
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Home Management</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">
        <link href="/img/favicon.ico" rel="icon">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha384-KyZXEAg3QhqLMpG8r+eq6f4zffFz6l5r5w2oZKfObw5urpE4Ehnmz5b5BXzgf8Ud" crossorigin="anonymous">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
        <link href="/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
        <link href="/css/bootstrap.min.css" rel="stylesheet">
        <link href="/css/style.css" rel="stylesheet">
    </head>

    <style>
        .bg-light{
            background: #daecff;
        }
    </style>

    <body>
        <div class="container-xxl position-relative bg-white d-flex p-0">
            <!-- Spinner Start -->
            <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->


            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3 bg-light">
                <nav class="navbar bg-light navbar-light">
                    <a href="/homeManagement" class="navbar-brand mx-4 mb-3">
                        <h3 class="text-primary"></i>HOME</h3>
                    </a>
                    <div class="d-flex align-items-center ms-4 mb-4">
                        <div class="position-relative" style="color: black;">
                            <i class="fas fa-user-tie fa-lg"></i>
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
                    <div class="navbar-nav w-100">
                        <a href="homeManagement.jsp" class="nav-item nav-link active"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Manager</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="productManagement.jsp" class="dropdown-item">Product</a>
                                <a href="/homeManagement/categoryManagement" class="dropdown-item">Category</a>
                                <a href="/homeManagement/customerManagement" class="dropdown-item">Customer</a>
                                <a href="/homeManagement/staffManagement" class="dropdown-item">Staff</a>
                                <a href="/homeManagement/voucherManagement" class="dropdown-item">Voucher</a>
                                <a href="/orderManagement" class="dropdown-item">Order</a>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
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
                            <a href="/account/managerProfile?username=${username}" class="dropdown-item">My Profile</a>
                            <a href="/user/logout" class="dropdown-item">Log Out</a>
                        </div>
                    </div>
                </div>
            </nav>
            <!-- Navbar End -->


            <!-- Sale & Revenue Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-bar fa-3x text-primary"></i>
                            <div class="ms-3">
                                <p class="mb-2">Total staff</p>
                                <h6 class="mb-0">${listStaff.size()-1}</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-area fa-3x text-primary"></i>
                            <c:set var="listCustomer" value="${listCustomer}" />
                            <div class="ms-3">
                                <p class="mb-2">Total Customers</p>
                                <h6 class="mb-0">${listCustomer.size()}</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-xl-3">
                        <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                            <i class="fa fa-chart-pie fa-3x text-primary"></i>
                            <c:set var="listPro" value="${listPro}" />
                            <div class="ms-3">
                                <p class="mb-2">Number of products in stock</p>
                                <c:set var="activeProductCount" value="0" />
                                <c:forEach items="${listPro}" var="product">
                                    <c:if test="${product.status}">
                                        <c:set var="activeProductCount" value="${activeProductCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                <h6 class="mb-0">
                                    Total Products: ${listPro.size()} / 
                                    Available Products: ${activeProductCount}
                                </h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Content End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>

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

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>