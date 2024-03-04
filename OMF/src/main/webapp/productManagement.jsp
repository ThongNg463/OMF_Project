<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Models.Products" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Product Management</title>
        <!-- Include your CSS and JavaScript files here -->
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
              integrity="sha384-KyZXEAg3QhqLMpG8r+eq6f4zffFz6l5r5w2oZKfObw5urpE4Ehnmz5b5BXzgf8Ud" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <link href="/img/favicon.ico" rel="icon">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
        <link href="/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
        <link href="/OMF/css/bootstrap.min.css" rel="stylesheet">
        <link href="/OMF/css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.3/dist/jquery.validate.min.js"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="img/favicon.ico" rel="icon">

        <script>
            $(document).ready(function () {
                $('#example').DataTable();
            });
        </script>
        <style>
            .bg-light {
                background: #daecff;
            }

            .product-button-word:hover {
                color: white;
            }

            #brand-button {
                margin-bottom: 15px;
                transition: all 0.3s;
            }

            #brand-button:hover {
                background-color: #5eb5ff;
                transform: scale(0.95);
            }

            .dropdown-item {
                color: black;
                background: white;
            }

            .dropdown-item:hover {
                color: white;
                background: #5eb5ff;
            }

            /* Additional styling from the old JSP */
            .in-brand-management {
                background-color: white;
                padding: 15px;
                border-radius: 20px;
            }
        </style>
    </head>



    <body>
        <!-- Sidebar Start -->
        <div class="sidebar bg-light pe-4 pb-3">
            <nav class="navbar bg-light navbar-light">
                <a href="/homeManagement" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary">HOME</h3>
                </a>
                <div class="d-flex align-items-center ms-4 mb-4">
                    <div class="position-relative">
                        <i style="color: black;" class="fas fa-user-tie fa-lg"></i>
                        <div
                            class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1">
                        </div>
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
                        <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"><i
                                class="fa fa-laptop me-2"></i>Manager</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="/OMF/productManagement" class="dropdown-item active">Product</a>
                            <a href="/homeManagement/brandManagement" class="dropdown-item">Brand</a>
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
                        <div class="dropdown-menu dropdown-menu-end bg-white rounded-0 rounded-bottom m-0">
                            <a href="/account/managerProfile" class="dropdown-item">My Profile</a>
                            <a href="/user/logout" class="dropdown-item">Log Out</a>
                        </div>
                    </div>
                </div>
            </nav>
            <!-- Navbar End -->

            <!-- Table Start -->

            <div class="row justify-content-center">
                <div class="col-lg-30">
                    <div class="bg-light rounded p-4 text-center">
                        <div class="in-brand-management">
                            <h6 class="mb-4">PRODUCT MANAGEMENT</h6>
                            <div class="d-flex justify-content-end">
                                <button class="product-button float-end" id="brand-button">
                                    <a href="/OMF/addProduct" class="product-button-word">Add new product</a>
                                </button>
                                <p>${msg}</p>
                            </div>
                            <div class="table-responsive">
                                <table id="example" class="display" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th>Product ID</th>
                                            <th>Name</th>
                                            <th>Stock</th>
                                            <th>Price</th>
                                            <th>Description</th>
                                            <th>Product Image</th>
                                            <th>Product Type</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${products}" var="product">
                                            <tr>
                                                <td>${product.proID}</td>
                                                <td>${product.proName}</td>
                                                <td>${product.proStock}</td>
                                                <td>${product.proPrice}</td>
                                                <td>${product.proDes}</td>
                                                <td>${product.proPic}</td>
                                                <td>${product.proType}</td>
                                                <td>
                                                    <a href="/OMF/updateProduct?productId=${product.proID}" class="btn btn-primary">Update</a>
                                                    <!-- Delete form -->
                                                    <form id="delete-form-${product.proID}" method="post" action="ProductController?action=deleteProduct">
                                                        <input type="hidden" name="productId" value="${product.proID}">
                                                        <button type="submit" class="btn btn-danger">Delete</button>
                                                    </form>

                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
        <!-- Table End -->

        <!-- Footer and other elements go here -->
    </div>
    <!-- Content End -->

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

    <!-- Template Javascript -->
    <script src="/js/main.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
</body>

</html>
