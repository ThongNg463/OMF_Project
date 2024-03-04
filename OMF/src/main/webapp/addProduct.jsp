
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add New Product</title>
        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <link href="/img/favicon.ico" rel="icon">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
        <link href="/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
        <link href="/OMF//css/bootstrap.min.css" rel="stylesheet">
        <link href="/OMF//css/style.css" rel="stylesheet">
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
        /* Add your custom styles here */
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
                <a href="homeManagement.jsp" class="navbar-brand mx-4 mb-3">
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

            <!-- Main Content -->
            <div class="container mt-4">
                <div class="row justify-content-center">
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-body">
                                <form id="add-form" method="post" action="addProduct">
                                    <!-- Hidden input field to specify the action -->
                                    <input type="hidden" name="action" value="addProduct">
                                    <!-- Form fields -->
                                    <div class="mb-3">
                                        <label for="ProID" class="form-label">Product ID:</label>
                                        <input type="text" class="form-control" id="ProID" name="ProID" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="ProName" class="form-label">Product Name:</label>
                                        <input type="text" class="form-control" id="ProName" name="ProName" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="ProStock" class="form-label">Stock:</label>
                                        <input type="number" class="form-control" id="ProStock" name="ProStock" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="ProPrice" class="form-label">Price:</label>
                                        <input type="text" class="form-control" id="ProPrice" name="ProPrice" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="ProDes" class="form-label">Description:</label>
                                        <textarea class="form-control" id="ProDes" name="ProDes" required></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="ProType" class="form-label">Type:</label>
                                        <input type="text" class="form-control" id="ProType" name="ProType" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="ProPic" class="form-label">Picture:</label>
                                        <input type="text" class="form-control" id="ProPic" name="ProPic" required>
                                    </div>

                                    <!-- Submit button -->
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary">Add Product</button>
                                    </div>
                                </form>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer Start -->
            <div class="container-fluid pt-4 px-4">
            </div>
            <!-- Footer End -->
        </div>



        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/slib/chart/chart.min.js"></script>
        <script src="/lib/easing/easing.min.js"></script>
        <script src="/lib/waypoints/waypoints.min.js"></script>
        <script src="/lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="/lib/tempusdominus/js/moment.min.js"></script>
        <script src="/lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

        <!-- Template Javascript -->
        <script src="/js/main.js"></script>
    </body>
</html>
