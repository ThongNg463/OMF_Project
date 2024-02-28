<%-- 
    Document   : Login
    Created on : Feb 23, 2024, 8:13:07 PM
    Author     : Huy
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                            <a href="productManagement.jsp" class="dropdown-item active">Product</a>
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

            <!-- Table Start -->
            <div class="container-fluid pt-4 px-4">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                            <div class="in-brand-management" style="background-color: white; padding: 15px; border-radius: 20px;">
                                <h6 class="mb-4">ADD NEW PRODUCT</h6>
                                <form id="add-form" method="post" action="manager">

                                    <label style="color: black; width: 90px;" >Food ID</label>
                                    <input style="width: 70%;" name="product_id" type="text" class="form-control validate" required value=""/>

                                    <label style="color: black;" for="name">Name Of Food</label>
                                    <input style="width: 70%;" id="name" name="product_name" type="text" class="form-control validate" required value=""/>

                                    <label style="color: black;" for="quantity">Quantity</label>
                                    <input style="width: 70%;" id="quantity" name="product_quantity" type="number" class="form-control validate" required value="" />

                                    <label style="color: black;" for="id">Price</label>
                                    <input style="width: 70%;" id="price" name="product_price" type="text" class="form-control validate" required value="" />

                                    <label style="color: black;" for="id">Discount</label>
                                    <input style="width: 70%;" id="discount" name="discount" type="number" class="form-control validate" required value="" />

                                    <label style="color: black;" for="description">Description</label>
                                    <textarea style="width: 70%;" class="form-control validate" name="product_description" rows="3" required></textarea>

                                    <label style="color: black;" for="id">Brand</label><br><br>

                                    <label style="color: black;" for="id">Category</label><br>
                                    <select name="category_id" style="width: 70%; font-size: 15px; border-color: #c4c4c4;">
                                        <c:forEach var="category" items="${listCategory}">
                                            <option value="${category.category_id}">${category.category_name}</option>
                                        </c:forEach>
                                    </select><br>

                                    <label style="color: black;" for="id">Status</label><br>
                                    <select name="status" style="width: 70%; font-size: 15px; border-color: #c4c4c4;">
                                        <option value="true" >True</option>
                                        <option value="false">False</option>
                                    </select><br>

                                    <div class="custom-file mt-3 mb-3">
                                        <input id="fileInput" type="file" name="images" multiple onchange="displayFileName()" style="display: none;" />
                                        <input type="button" class="btn btn-primary btn-block mx-auto" value="UPLOAD PRODUCT IMAGE" multiple onclick="document.getElementById('fileInput').click();" />
                                        <span id="fileName" style="display: none;"></span>
                                    </div>

                                    <div id="error-messages" class="text-danger"></div>
                                    <c:if test="${not empty requestScope.errorMessage}">
                                        <p class="Not-same">${requestScope.errorMessage}</p>
                                    </c:if>
                                    <c:if test="${not empty requestScope.successMessage}">
                                        <p class="Success">${requestScope.successMessage}</p>
                                    </c:if>

                                    <div class="col-12" style="margin-top: 10px;">
                                        <button type="submit" name="btnAddProduct" class="btn btn-primary btn-block text-uppercase">Done</button>
                                    </div>
                                </form> 
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
        <!-- Content End -->

        <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
        <script>
                                            $(document).ready(function () {
                                                // Function to check if a value is a valid integer
                                                function isValidInteger(value) {
                                                    return /^\d+$/.test(value);
                                                }

                                                // Function to check if a value is a valid positive number
                                                function isValidPositiveNumber(value) {
                                                    return /^\d*\.?\d+$/.test(value);
                                                }

                                                // Function to validate the form on submission
                                                $("form#add-form").submit(function (event) {
                                                    let valid = true;
                                                    // Reset error messages and styles
                                                    $(".error-message").remove();
                                                    $(".error-field").removeClass("error-field");

                                                    // Product Name validation
                                                    const productName = $("input[name='product_name']").val().trim();
                                                    if (productName === "") {
                                                        valid = false;
                                                        $("input[name='product_name']").after("<p class='error-message'>Product name is required</p>").addClass("error-field");
                                                    }

                                                    // Quantity validation
                                                    const quantity = $("input[name='product_quantity']").val().trim();
                                                    if (quantity === "" || !isValidInteger(quantity) || parseInt(quantity) < 0) {
                                                        valid = false;
                                                        $("input[name='product_quantity']").after("<p class='error-message'>Invalid quantity</p>").addClass("error-field");
                                                    }

                                                    // Price validation
                                                    const price = $("input[name='product_price']").val().trim();
                                                    if (price === "" || !isValidPositiveNumber(price) || parseFloat(price) < 0) {
                                                        valid = false;
                                                        $("input[name='product_price']").after("<p class='error-message'>Invalid price</p>").addClass("error-field");
                                                    }

                                                    // Discount validation
                                                    const discount = $("input[name='discount']").val().trim();
                                                    if (discount === "" || !isValidInteger(discount) || parseInt(discount) < 0 || parseInt(discount) < 1 || parseInt(discount) > 70) {
                                                        valid = false;
                                                        $("input[name='discount']").after("<p class='error-message'>Invalid discount</p>").addClass("error-field");
                                                    }

                                                    // Description validation
                                                    const description = $("textarea[name='product_description']").val().trim();
                                                    if (description === "") {
                                                        valid = false;
                                                        $("textarea[name='product_description']").after("<p class='error-message'>Description is required</p>").addClass("error-field");
                                                    }

                                                    // Image validation (file extension)
                                                    const imageInput = $("input[name='images']");
                                                    const imageFileName = imageInput.val();
                                                    if (imageFileName !== "") {
                                                        const fileExtension = imageFileName.split('.').pop().toLowerCase();
                                                        if (fileExtension !== "jpg" && fileExtension !== "png") {
                                                            valid = false;
                                                            imageInput.after("<p class='error-message'>Invalid file format. Supported formats: jpg, png</p>").addClass("error-field");
                                                        }
                                                    }

                                                    if (!valid) {
                                                        event.preventDefault(); // Prevent form submission if there are validation errors
                                                    }
                                                });

                                                // Function to display the selected file name
                                                function displayFileName() {
                                                    const imageInput = $("input[name='images']");
                                                    const fileName = imageInput.val().split('\\').pop();
                                                    $("#fileName").text("Selected file: " + fileName).show();
                                                }

                                                // Attach the file input change event
                                                $("input[name='images']").change(displayFileName);
                                            });
        </script>


        <!-- JavaScript Libraries -->

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