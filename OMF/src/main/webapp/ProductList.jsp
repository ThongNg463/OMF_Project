<!DOCTYPE html>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="Models.Account"%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>SB Admin 2 - Tables</title>

        <!-- Custom fonts for this template -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>


        <title>Dashboard</title>

        <!-- Custom fonts for this template -->
        <link href="/UI/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="/UI/css/sb-admin-2.min.css" rel="stylesheet">

        <!-- Custom styles for this page -->
        <link href="/UI/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <script>
            $(document).ready(function () {
                $('#example').DataTable();
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>   
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
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

    <body id="page-top">
        <%
            AccountDAO AccDAO = new AccountDAO();
            Account UserAcc = new Account();
            String Username = null;
            String Role = null;
            boolean isLogin = false;

            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("User")) {
                        isLogin = true;
                        UserAcc = AccDAO.getAccount(cookie.getValue());
                        Username = UserAcc.getUsername();
                        Role = UserAcc.getRole();
                        break;
                    }
                }
            }

            if (!isLogin) {
                response.sendRedirect("/Login");
} else if (!Role.equals("Admin")) {
                request.getRequestDispatcher("/accessDenied.jsp").forward(request, response);
            }
        %>

        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
            <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

                <!-- Sidebar - Brand -->
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/Home">
                    <div class="sidebar-brand-icon rotate-n-15">
                        <i class="fas fa-laugh-wink"></i>
                    </div>
                    <div class="sidebar-brand-text mx-3">OMF <sup></sup></div>
                </a>

                <!-- Divider -->
                <hr class="sidebar-divider my-0">

                <!-- Nav Item - Dashboard -->
                <li class="nav-item">
                    <a class="nav-link" href="/HomeManagement.jsp">
                        <i class="fas fa-fw fa-tachometer-alt"></i>
                        <span>Dashboard</span></a>
                </li>

                <!-- Divider -->
                <hr class="sidebar-divider">

                <!-- Heading -->
                <div class="sidebar-heading">
                    Interface
                </div>

                <!-- Nav Item - Pages Collapse Menu -->
                <li class="nav-item">
                    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                       aria-expanded="true" aria-controls="collapseTwo">
                        <i class="fas fa-fw fa-cog"></i>
                        <span>Components</span>
                    </a>
                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <h6 class="collapse-header">Custom Components:</h6>
                            <a class="collapse-item" href="buttons.html">Buttons</a>
                            <a class="collapse-item" href="cards.html">Cards</a>
                        </div>
                    </div>
                </li>

                <!-- Nav Item - Utilities Collapse Menu -->
                <li class="nav-item">
                    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
                       aria-expanded="true" aria-controls="collapseUtilities">
                        <i class="fas fa-fw fa-wrench"></i>
                        <span>Utilities</span>
                    </a>
                    <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
                         data-parent="#accordionSidebar">
                        <div class="bg-white py-2 collapse-inner rounded">
<h6 class="collapse-header">Custom Utilities:</h6>
                            <a class="collapse-item" href="utilities-color.html">Colors</a>
                            <a class="collapse-item" href="utilities-border.html">Borders</a>
                            <a class="collapse-item" href="utilities-animation.html">Animations</a>
                            <a class="collapse-item" href="utilities-other.html">Other</a>
                        </div>
                    </div>
                </li>

                <!-- Divider -->
                <hr class="sidebar-divider">

                <!-- Heading -->
                <div class="sidebar-heading">
                    Addons
                </div>

                <!-- Nav Item - Pages Collapse Menu -->
                <li class="nav-item">
                    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
                       aria-expanded="true" aria-controls="collapsePages">
                        <i class="fas fa-fw fa-folder"></i>
                        <span>Pages</span>
                    </a>
                    <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <h6 class="collapse-header">Management:</h6>
                            <a class="collapse-item" href="/ProductList/Ds">Product Management</a>
                            <a class="collapse-item" href="/OrderList/Ds">Order Management</a>
                            <a class="collapse-item" href="/UserManagement/Ds">User Management</a>
                            <a class="collapse-item" href="/StaffManagement/Ds">Staff Management</a>
                            <a class="collapse-item" href="/VoucherManagement/Ds">Voucher Management</a>
                            <!--                            <a class="collapse-item" href="forgot-password.html">Forgot Password</a>-->
                            <div class="collapse-divider"></div>
                            <!--                            <h6 class="collapse-header">Other Pages:</h6>
                                                        <a class="collapse-item" href="404.html">404 Page</a>
                                                        <a class="collapse-item" href="blank.html">Blank Page</a>-->
                        </div>
                    </div>
                </li>

                <!-- Nav Item - Charts -->
                <li class="nav-item">
                    <a class="nav-link" href="charts.html">
                        <i class="fas fa-fw fa-chart-area"></i>
                        <span>Charts</span></a>
                </li>

                <!-- Nav Item - Tables -->
                <li class="nav-item active">
                    <a class="nav-link" href="tables.html">
                        <i class="fas fa-fw fa-table"></i>
<span>Tables</span></a>
                </li>

                <!-- Divider -->
                <hr class="sidebar-divider d-none d-md-block">

                <!-- Sidebar Toggler (Sidebar) -->
                <div class="text-center d-none d-md-inline">
                    <button class="rounded-circle border-0" id="sidebarToggle"></button>
                </div>

            </ul>
            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
                <div id="content">

                    <!-- Topbar -->
                    <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                        <!-- Sidebar Toggle (Topbar) -->
                        <form class="form-inline">
                            <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                                <i class="fa fa-bars"></i>
                            </button>
                        </form>

                        <!-- Topbar Search -->
                        <form
                            class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                            <div class="input-group">
                                <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                                       aria-label="Search" aria-describedby="basic-addon2">
                                <div class="input-group-append">
                                    <button class="btn btn-primary" type="button">
                                        <i class="fas fa-search fa-sm"></i>
                                    </button>
                                </div>
                            </div>
                        </form>

                        <!-- Topbar Navbar -->
                        <ul class="navbar-nav ml-auto">

                            <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                            <li class="nav-item dropdown no-arrow d-sm-none">
                                <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fas fa-search fa-fw"></i>
                                </a>
                                <!-- Dropdown - Messages -->
                                <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                     aria-labelledby="searchDropdown">
                                    <form class="form-inline mr-auto w-100 navbar-search">
                                        <div class="input-group">
<input type="text" class="form-control bg-light border-0 small"
                                                   placeholder="Search for..." aria-label="Search"
                                                   aria-describedby="basic-addon2">
                                            <div class="input-group-append">
                                                <button class="btn btn-primary" type="button">
                                                    <i class="fas fa-search fa-sm"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </li>

                            <!-- Nav Item - Alerts -->
                            <li class="nav-item dropdown no-arrow mx-1">
                                <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
                                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fas fa-bell fa-fw"></i>
                                    <!-- Counter - Alerts -->
                                    <span class="badge badge-danger badge-counter">3+</span>
                                </a>
                                <!-- Dropdown - Alerts -->
                                <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                     aria-labelledby="alertsDropdown">
                                    <h6 class="dropdown-header">
                                        Alerts Center
                                    </h6>
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <div class="mr-3">
                                            <div class="icon-circle bg-primary">
                                                <i class="fas fa-file-alt text-white"></i>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="small text-gray-500">December 12, 2019</div>
                                            <span class="font-weight-bold">A new monthly report is ready to download!</span>
                                        </div>
                                    </a>
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <div class="mr-3">
                                            <div class="icon-circle bg-success">
                                                <i class="fas fa-donate text-white"></i>
                                            </div>
</div>
                                        <div>
                                            <div class="small text-gray-500">December 7, 2019</div>
                                            $290.29 has been deposited into your account!
                                        </div>
                                    </a>
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <div class="mr-3">
                                            <div class="icon-circle bg-warning">
                                                <i class="fas fa-exclamation-triangle text-white"></i>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="small text-gray-500">December 2, 2019</div>
                                            Spending Alert: We've noticed unusually high spending for your account.
                                        </div>
                                    </a>
                                    <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                                </div>
                            </li>

                            <!-- Nav Item - Messages -->
                            <li class="nav-item dropdown no-arrow mx-1">
                                <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button"
                                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fas fa-envelope fa-fw"></i>
                                    <!-- Counter - Messages -->
                                    <span class="badge badge-danger badge-counter">7</span>
                                </a>
                                <!-- Dropdown - Messages -->
                                <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                     aria-labelledby="messagesDropdown">
                                    <h6 class="dropdown-header">
                                        Message Center
                                    </h6>
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <div class="dropdown-list-image mr-3">
                                            <img class="rounded-circle" src="img/undraw_profile_1.svg"
                                                 alt="...">
                                            <div class="status-indicator bg-success"></div>
                                        </div>
                                        <div class="font-weight-bold">
<div class="text-truncate">Hi there! I am wondering if you can help me with a
                                                problem I've been having.</div>
                                            <div class="small text-gray-500">Emily Fowler · 58m</div>
                                        </div>
                                    </a>
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <div class="dropdown-list-image mr-3">
                                            <img class="rounded-circle" src="img/undraw_profile_2.svg"
                                                 alt="...">
                                            <div class="status-indicator"></div>
                                        </div>
                                        <div>
                                            <div class="text-truncate">I have the photos that you ordered last month, how
                                                would you like them sent to you?</div>
                                            <div class="small text-gray-500">Jae Chun · 1d</div>
                                        </div>
                                    </a>
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <div class="dropdown-list-image mr-3">
                                            <img class="rounded-circle" src="img/undraw_profile_3.svg"
                                                 alt="...">
                                            <div class="status-indicator bg-warning"></div>
                                        </div>
                                        <div>
                                            <div class="text-truncate">Last month's report looks great, I am very happy with
                                                the progress so far, keep up the good work!</div>
                                            <div class="small text-gray-500">Morgan Alvarez · 2d</div>
                                        </div>
                                    </a>
                                    <a class="dropdown-item d-flex align-items-center" href="#">
                                        <div class="dropdown-list-image mr-3">
                                            <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60"
                                                 alt="...">
                                            <div class="status-indicator bg-success"></div>
                                        </div>
                                        <div>
                                            <div class="text-truncate">Am I a good boy? The reason I ask is because someone
                                                told me that people say this to all dogs, even if they aren't good...</div>
<div class="small text-gray-500">Chicken the Dog · 2w</div>
                                        </div>
                                    </a>
                                    <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
                                </div>
                            </li>

                            <div class="topbar-divider d-none d-sm-block"></div>

                            <!-- Nav Item - User Information -->
                            <li class="nav-item dropdown no-arrow">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=Username%>
                                        <img class="img-profile rounded-circle" style="margin-left:10px;height: 30px; width: 30px" src="<%= UserAcc.getAccpic()%>"></span>
                                </a>
                                <!-- Dropdown - User Information -->
                                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                     aria-labelledby="userDropdown">
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Profile
                                    </a>
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Settings
                                    </a>
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Activity Log
                                    </a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="/logout" style="text-decoration: none;">

                                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Logout
                                    </a>
                                </div>

                            </li>

                        </ul>

                    </nav>
                    <!-- End of Topbar -->

                    <!-- Begin Page Content -->
                    <div class="container-fluid">
                        <%
                            ProductDAO proDAO = new ProductDAO();
                            int totalCount = proDAO.getTotalProductsCount();
                        %>
<!-- Page Heading -->
                        <h1 class="h3 mb-2 text-gray-800">Product Management</h1>


                        <!-- DataTales Example -->
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">Product List</h6>
                                <div style="float: right;">
                                    <button class="btn btn-warning btn-sm text-light shadow-lg rounded modal-button" data-modal="myModalAddNew">
                                        <i class="fa-solid fa-circle-plus"></i> Add New Product
                                    </button>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Name</th>
                                                <th>Picture</th>
                                                <th>Description</th>
                                                <th>Price</th>  
                                                <th>Type</th>  
                                                <th>Update</th>
                                                <th>Delete</th>                    
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <%
                                                ResultSet rs = proDAO.getAll();
                                                while (rs.next()) {
                                            %>
                                            <tr>
                                                <td><%= rs.getString("ProID")%></td>
                                                <td><%= rs.getString("ProName")%></td>
                                                <td><img src="<%= rs.getString("ProPic")%>" style="max-height: 100px" alt="Picture"/></td>
                                                <td><%= rs.getString("ProDes")%></td>
                                                <td>$<%= rs.getFloat("ProPrice")%></td>    
                                                <td><%= rs.getString("ProType")%></td>
                                                <td>
                                                    <div class="modal-button" data-modal="myModal<%=rs.getString("ProID")%>"><i class="fa-solid fa-file-pen" style="color: #000000; font-size: 200%;"></i></div>
<div id="myModal<%=rs.getString("ProID")%>" class="modal">
                                                        <!-- Modal content -->
                                                        <div class="modal-content">
                                                            <H1>Update Product - ProID: <%=rs.getString("ProID")%></H1>
                                                            <span class="close" style="cursor: pointer">&times;</span>
                                                            <br>
                                                            <form method="post">
                                                                <input type="hidden" name="ProID" value="<%=rs.getString("ProID")%>">
                                                                <div class="form-group">
                                                                    <label class="form-label h4">Product Stock:</label>
                                                                    <div><input class="form-control" type="number" name="ProStock" value="<%=rs.getInt("ProStock")%>" required></div> <br/>        
                                                                </div>

                                                                <div class="form-group">
                                                                    <label class="form-label h4">Product Name:</label>
                                                                    <div><input class="form-control" type="text" name="ProName" value="<%=rs.getString("ProName")%>" required></div> <br/>        
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="form-label h4">Product Picture Link:</label>
                                                                    <div><input class="form-control" type="text" name="ProPic" value="<%=rs.getString("ProPic")%>" required></div> <br/>        
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="form-label h4">Product Description:</label> 
                                                                    <div><textarea class="form-control" type="text" name="ProDes" required><%=rs.getString("ProDes")%></textarea></div> <br/>                
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="form-label h4">Product Price:</label>
<div><input class="form-control" type="text" name="ProPrice" value="<%=rs.getString("ProPrice")%>" required></div> <br/>    
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="form-label h4">Product Type:</label>
                                                                    <div>                                                              
                                                                        <select id="ProType" name="ProType">
                                                                            <option value="starters">Starters</option>
                                                                            <option value="salads">Salads</option>
                                                                            <option value="specialty">Specialty</option>
                                                                        </select>

                                                                    </div> <br/>        
                                                                </div>
                                                                <button onclick="return confirm('Update this product?')" class="btn btn-warning text-light mb-3 shadow-lg p-3 mb-5 rounded" type="submit" name="btnUpdate" value="Update">Update Product</button>         
                                                            </form>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td><a onclick="return confirm('Delete this product?')" href="/ProductList/delete/<%= rs.getString("ProID")%>"><i class="fa-solid fa-trash-can" style="color: #000000; font-size: 200%;"></i></a></td>                      
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div id="myModalAddNew" class="modal">
                            <!-- Modal content -->

                            <div class="modal-content">
                                <%
                                    int i = 1;
                                    String ProID = "Pro_" + (proDAO.getTotalProductsCount() + i);
                                    while (proDAO.getProducts(ProID) != null) {
                                        ProID = "Pro_" + (proDAO.getTotalProductsCount() + ++i);
                                    }
%>
                                <H1>Add new Product - ProID: <%=ProID%></H1>
                                <span class="close" style="cursor: pointer">&times;</span>
                                <br>
                                <form method="post">
                                    <input type="hidden" name="ProID">
                                    <div class="form-group">
                                        <label class="form-label h4">Product Stock:</label>
                                        <div><input class="form-control" type="number" name="ProStock" required></div> <br/>        
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label h4">Product Name:</label>
                                        <div><input class="form-control" type="text" name="ProName" required></div> <br/>        
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label h4">Product Picture Link:</label>
                                        <div><input class="form-control" type="text" name="ProPic" required></div> <br/>        
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label h4">Product Description:</label> 
                                        <div><textarea class="form-control" type="text" name="ProDes" required></textarea></div> <br/>                
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label h4">Product Price:</label> 
                                        <div><input class="form-control" type="text" name="ProPrice" required></div> <br/>    
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label h4">Product Type:</label>
                                        <div>                                                              
                                            <select id="ProType" name="ProType">
                                                <option value="starters">Starters</option>
                                                <option value="salads">Salads</option>
                                                <option value="specialty">Specialty</option>
                                            </select>

                                        </div> <br/>        
                                    </div>
                                    <button class="btn btn-warning text-light mb-3 shadow-lg p-3 mb-5 rounded" type="submit" name="btnAddNew" value="AddNew"><i class="fa-solid fa-circle-plus"></i>Add new Product</button>
</form>
                            </div>
                        </div>

                        <!-- /.container-fluid -->

                    </div>
                    <!-- End of Main Content -->

                    <!-- Footer -->
                    <footer class="sticky-footer bg-white">
                        <div class="container my-auto">
                            <div class="copyright text-center my-auto">
                                <span>Copyright &copy; OMF 2024</span>
                            </div>
                        </div>
                    </footer>
                    <!-- End of Footer -->

                </div>
                <!-- End of Content Wrapper -->

            </div>
            <!-- End of Page Wrapper -->

            <!-- Scroll to Top Button-->
            <a class="scroll-to-top rounded" href="#page-top">
                <i class="fas fa-angle-up"></i>
            </a>


            <!-- Bootstrap core JavaScript-->
            <script src="/vendor/jquery/jquery.min.js"></script>
            <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

            <!-- Core plugin JavaScript-->
            <script src="/vendor/jquery-easing/jquery.easing.min.js"></script>

            <!-- Custom scripts for all pages-->
            <script src="/js/sb-admin-2.min.js"></script>

            <!-- Page level plugins -->
            <script src="/vendor/datatables/jquery.dataTables.min.js"></script>
            <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

            <!-- Page level custom scripts -->
            <script src="/js/demo/datatables-demo.js"></script>
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