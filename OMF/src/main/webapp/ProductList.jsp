<%-- 
    Document   : listProduct
    Created on : Jun 27, 2023, 12:37:40 AM
    Author     : ACER
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="Models.account"%>
<%@page import="DAOs.accountDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product List</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@500&display=swap" rel="stylesheet">
        <style>
            * {
                font-family: 'Nunito', sans-serif;
            }
        </style>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>   
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#example').DataTable();
            });
        </script>
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
    <body>
        <%
            accountDAO AccDAO = new accountDAO();
            account UserAcc = new account();
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

        <div class="container-fluid">            
            <div class="row" style="background-color: #333333">
                <h3 style="color: white"><a href='/Home'style="text-decoration: none; color: inherit;">Back to Home Page <i class="fa-solid fa-house"></i></a></h3>
                <div class="text-end mt-3 mb-2">
                    <div class="text-warning h2">
                        <i class="fa-solid fa-circle-user text-light"></i> Hello, <%=Username%>!
                        <a class="h4" href="/logout" style="text-decoration: none;">(Sign out <i class="fa-solid fa-right-from-bracket"></i>)</a>
                        <%
                            ProductDAO proDAO = new ProductDAO();
                            int totalCount = proDAO.getTotalProductsCount();
                        %>
                    </div>
                </div>
            </div>
            <div class="row">
                <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
                    <div class="container-fluid">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link active" href="/prlist/ds">Product List</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link"  href="/olist/ds">Order List<a/>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div> 
            <div class="row text-info bg-secondary mb-3" ><h1 style="margin-top: 7.5px">Product List (Total: <%= totalCount%>)</h1></div>
            <table id="example">
                <thead >
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
                        <td><a onclick="return confirm('Delete this product?')" href="/prlist/delete/<%= rs.getString("ProID")%>"><i class="fa-solid fa-trash-can" style="color: #000000; font-size: 200%;"></i></a></td>                      
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>


            <div class="btn btn-warning text-light mb-3 shadow-lg p-3 mb-5 rounded modal-button" data-modal="myModalAddNew"><i class="fa-solid fa-circle-plus"></i> Add new Product</div>
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
