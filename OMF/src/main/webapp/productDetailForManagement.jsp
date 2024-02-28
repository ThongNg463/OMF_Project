<%-- 
    Document   : productManagement
    Created on : Feb 23, 2024, 10:31:00 AM
    Author     : Huy
${listProduct.images[0]}
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Product Management</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha384-KyZXEAg3QhqLMpG8r+eq6f4zffFz6l5r5w2oZKfObw5urpE4Ehnmz5b5BXzgf8Ud" crossorigin="anonymous">
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
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="img/favicon.ico" rel="icon">

        <script>
            $(document).ready(function () {
                $('#example').DataTable();
            });
        </script>
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
        .img-display {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 400px; /* Điều chỉnh kích thước khung hình nếu cần */
        }
        .product-button-word:hover{
            background: #5eb5ff;
        }
        #product-img {
            max-width: 100%;
            max-height: 100%;
        }
        
        .button-footer {
            display: flex;
            justify-content: space-between;
        }
        
        .button-footer button {
            flex-grow: 1;
            margin: 0 5px;
        }
        .product-imgs {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .large-img {
            width: 100%; /* Điều chỉnh kích thước hình ảnh lớn */
            max-height: 400px; /* Điều chỉnh kích thước hình ảnh lớn */
        }

        .thumbnail-images {
            display: flex;
            justify-content: center;
            gap: 10px; /* Điều chỉnh khoảng cách giữa các hình ảnh nhỏ */
            overflow: auto;
        }

        .thumbnail {
            width: 60px; /* Điều chỉnh kích thước hình ảnh nhỏ */
            cursor: pointer;
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
                                <h6 class="mb-4">PRODUCT DETAIL MANAGEMENT</h6>
                                <!-- Card Left Start -->
                                <div class="product-imgs">
                                    <div class="product-name">${listProduct.product_name}</div>
                                    <div class="img-display">
                                        <img id="product-img" src="/images/${listProduct.images[0]}" class="large-img">
                                    </div>
                                    <div class="thumbnail-images">
                                        <c:forEach items="${listProduct.images}" var="image">
                                            <img src="/images/${image}" class="thumbnail">
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- Cart Left End -->

                                <!-- Card right start -->
                                <div class = "product-content" style="margin: 30px 60px;">
                                    <c:set var="discountPrice" value="${listProduct.product_price-((listProduct.discount/100) * listProduct.product_price)}"/>
                                    <fmt:formatNumber value="${discountPrice}" type="number" pattern="0.00" var="formattedPrice" />
                                    <h2 class="product-title" style="font-weight: bold;">${listProduct.product_name}</h2>
                                    <div class="product-price">
                                        Price: $${listProduct.product_price}
                                        <br>
                                        Price after sale ${listProduct.discount}%: $${formattedPrice}
                                    </div>

                                    <div class="product-detail">
                                        <h2><p>Detail</p></h2>
                                        <ul>
                                            <li>Available: <span> "${listProduct.product_quantity}" products remaining </span></li>
                                            <li>Category: <span> "${listCate.category_name}" </span></li>
                                         
                                        </ul>
                                    </div>
                                    <div style="margin-right: 90%">
                                        <button class="product-button float-end product-button-word" name="btnDeleteProduct" style="color: white">
                                            <a href="editProduct.jsp?productId=${listProduct.product_id}" class="product-button-word">Edit product</a>
                                        </button>                                        
                                    </div>
                                </div>
                                <!-- Cart right end -->
                                <!-- Footer start-->
                                <div class="footer" style="margin-top: 200px">
                                    <div class="button-footer" style="display: flex; align-items: center;">
                                        <button class="product-button float-end product-button-word" id="button1">Description</button>
                                    </div>

                                    <div class="content" id="description-content">
                                        <h2 style="margin-top: 20px">Description</h2>
                                        <p contentEditable="false">${listProduct.product_description}</p>
                                    </div>
                                </div>
                                <!-- Footer end-->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Table End -->
        </div>
        <div class="container-fluid pt-4 px-4" style="background-color: white;"></div>

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>


    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script>
            var descriptionContent = document.getElementById("description-content");
            var manufacturerContent = document.getElementById("manufacturer-content");
            var button1 = document.getElementById("button1");
            var button2 = document.getElementById("button2");


            descriptionContent.style.display = "none";
            manufacturerContent.style.display = "none";

            button1.addEventListener("click", function () {
                if (descriptionContent.style.display === "none" || descriptionContent.style.display === "") {
                    descriptionContent.style.display = "block";
                    manufacturerContent.style.display = "none";
                } else {
                    descriptionContent.style.display = "none";
                }
            });

            button2.addEventListener("click", function () {
                if (manufacturerContent.style.display === "none" || manufacturerContent.style.display === "") {
                    manufacturerContent.style.display = "block";
                    descriptionContent.style.display = "none";
                } else {
                    manufacturerContent.style.display = "none";
                }
            });

            let currentIndex = 0;
            const images = document.querySelectorAll('.thumbnail');
            const largeImage = document.querySelector('.large-img');

            function showImage(index) {
                if (index < 0) {
                    currentIndex = images.length - 1;
                } else if (index >= images.length) {
                    currentIndex = 0;
                }

                largeImage.src = images[currentIndex].src;
            }

            function nextImage() {
                currentIndex++;
                showImage(currentIndex);
            }

            function prevImage() {
                currentIndex--;
                showImage(currentIndex);
            }

            setInterval(nextImage, 3000); // Tự động chuyển hình mỗi 5 giây

            images.forEach((image, index) => {
                image.addEventListener('click', () => {
                    currentIndex = index;
                    showImage(currentIndex);
                });
            });
    </script>

    <!-- JavaScript Libraries -->

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