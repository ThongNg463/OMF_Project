<%@page import="Models.Voucher"%>
<%@page import="DAOs.VoucherDAO"%>
<%@page import="Models.Products"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="Models.Account"%>
<%@page import="DAOs.AccountDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Models.Cart"%>
<%@page import="DAOs.CartDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart</title>
        <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@4.1.1/dist/css/bootstrap.min.css'>
        <script src='https://cdn.jsdelivr.net/npm/bootstrap@4.1.1/dist/js/bootstrap.bundle.min.js'></script>
        <link href="/UI/css/sb-admin-2.min.css" rel="stylesheet">
    </head>
    <body class="bg-gradient-primary">
        <%
            AccountDAO AccDAO = new AccountDAO();
            Account userAcc = new Account();

            String Username = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("User".equals(cookie.getName())) {
                        Username = cookie.getValue();
                        break;
                    }
                }
            }
        %>

        <div class="container-xl px-4 mt-4">
            <nav class="nav nav-borders">
                <a class="nav-link active ms-0" href="#">Profile</a>
                <a class="nav-link" href="/Home">Back to Home page</a>
            </nav>
            <div class="container px-3 my-5 clearfix">
                <!-- Shopping cart table -->
                <div class="card">
                    <div class="card-header">
                        <h2>Shopping Cart</h2>
                    </div>

                    <div class="card-body">
                        <%
                            CartDAO cartDAO = new CartDAO();
                            int TotalCart = 0;
                            float TotalPrice = 0;
                            ResultSet rs = cartDAO.getCartByUsername(Username);
                            while (rs.next()) {
                                TotalCart++;
                            }
                            rs.close();
                            if (TotalCart > 0) {
                        %>
                        <div class="table-responsive">
                            <table class="table table-bordered m-0">
                                <thead>
                                    <tr>
                                        <!-- Set columns width -->
                                        <th class="text-center py-3 px-4" style="min-width: 400px;">Product Name &amp; Details</th>
                                        <th class="text-right py-3 px-4" style="width: 100px;">Price</th>
                                        <th class="text-center py-3 px-4" style="width: 120px;">Quantity</th>
                                        <th class="text-right py-3 px-4" style="width: 100px;">Total</th>
                                        <th class="text-center align-middle py-3 px-0" style="width: 40px;"><a href="#" class="shop-tooltip float-none text-light" title="" data-original-title="Clear cart"><i class="ino ion-md-trash"></i></a></th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                        ProductDAO proDAO = new ProductDAO();
                                        Products pro = new Products();
                                        rs = cartDAO.getCartByUsername(Username);
                                        while (rs.next()) {
                                            pro = proDAO.getProducts(rs.getString("ProID"));
                                            TotalPrice += pro.getProPrice() * rs.getInt("Quality");
                                    %>
                                    <tr>
                                        <td class="p-4">
                                            <div class="media align-items-center">
                                                <img src="<%=pro.getProPic()%>" class="d-block ui-w-40 ui-bordered mr-4" alt="">
                                                <div class="media-body">
                                                    <a href="#" class="d-block text-dark"><%=pro.getProName()%></a>
                                                    <small>
                                                        <span class="text-muted">Color:</span>
                                                        <span class="ui-product-color ui-product-color-sm align-text-bottom" style="background:#e81e2c;"></span> &nbsp;
                                                        <span class="text-muted">Size: </span> EU 37 &nbsp;
                                                        <span class="text-muted">Ships from: </span> China
                                                    </small>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="text-right font-weight-semibold align-middle p-4">$<%=pro.getProPrice()%></td>
                                        <td class="align-middle p-4">
                                            <span>
                                                <form method='post'>
                                                    <input type='hidden' name='Username' value='<%=Username%>'>
                                                    <input type='hidden' name='CartID' value='<%=rs.getString("CartID")%>'>                                                  
                                                    <input type='hidden' name='ProID' value='<%=rs.getString("ProID")%>'>                                                    
                                                    <button type='submit' name='Increase' value='Increase' class="shop-tooltip close float-none text-danger" title="" data-original-title="Remove">+</button>
                                                </form>
                                            </span>                                          
                                            <span><%=rs.getInt("Quality")%></span>
                                            <span>
                                                <form method='post'>
                                                    <input type='hidden' name='Username' value='<%=Username%>'>
                                                    <input type='hidden' name='CartID' value='<%=rs.getString("CartID")%>'>                                                  
                                                    <input type='hidden' name='ProID' value='<%=rs.getString("ProID")%>'>        
                                                    <button
                                                        <% if (rs.getInt("Quality") == 1) { %>
                                                        onclick="return confirm('Delete this product?')" <% }%>

                                                        type='submit' name='Decrease' value='Decrease' class="shop-tooltip close float-none text-danger" title="" data-original-title="Remove">-</button>
                                                </form>
                                            </span>
                                        </td>
                                        <td class="text-right font-weight-semibold align-middle p-4">$<%=String.format("%.2f", pro.getProPrice() * rs.getInt("Quality"))%></td>
                                        <td class="text-center align-middle px-0">
                                            <form method='post'>
                                                <input type='hidden' name='CartID' value='<%=rs.getString("CartID")%>'>
                                                <button onclick="return confirm('Delete this product?')" type='submit' name='Delete' value='Delete' class="shop-tooltip close float-none text-danger" title="" data-original-title="Remove">×</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <% }%>

                                </tbody>
                            </table>
                        </div>
                        <!-- / Shopping cart table -->
                        <% } else { %>                                    
                        <h3 class='text-center'> Ban chua co cart nao! </h3>
                        <% }%>

                        <div class="d-flex flex-wrap justify-content-between align-items-center pb-4">
                            <div class="mt-4">
                                <form method='post'>
                                    <label class="text-muted font-weight-normal">Voucher: </label>
                                    <%
                                        VoucherDAO vouDAO = new VoucherDAO();
                                        Voucher vou = new Voucher();
                                        int TotalVoucher = vouDAO.getTotalVoucherByUsername(Username);

                                        if (TotalVoucher > 0) {
                                    %>
                                    <select id='Voucher' name='Voucher'>
                                        <option value="None">Khong chon voucher!</option>
                                        <%
                                            ResultSet rsVou = vouDAO.getVoucherByUsername(Username);
                                            while (rsVou.next()) {
                                        %>
                                        <option value="<%=rsVou.getString("VoucherID")%>"><%=rsVou.getString("VoucherID")%> - <%=rsVou.getString("VoucherPercent")%>% - <%=rsVou.getString("VoucherStock")%> left!</option>
                                        <% }%>
                                    </select>
                                    <button type='submit'>Choose</button>                               
                                </form>
                                    <%
                                        String ValueVoucher = request.getParameter("Voucher");
                                         ValueVoucher = ValueVoucher == null ? "None" : ValueVoucher;
                                    %>
                                Ban dang chon Voucher: <%=ValueVoucher%>
                                <%
                                    //if (!ValueVoucher.equals("None")) {
                                        vou = vouDAO.getVoucherByID(ValueVoucher);
                                        if (vou == null)  vou = new Voucher("", 100, 0, "");
                                    //}
                                } else {
                                    vou = new Voucher("", 100, 0, "");
                                %>
                                Ban khong co voucher nao!
                                <% }%>


                            </div>
                            <div class="d-flex">
                                <%
                                    float discount = TotalPrice * vou.getVoucherPercent() / 100;
                                    float finalprice = TotalPrice - discount;
                                    %>
                                <div class="text-right mt-4 mr-5">
                                    <label class="text-muted font-weight-normal m-0">Discount</label>
                                    <div class="text-large"><strong>$<%=String.format("%.2f", discount)%></strong></div>
                                </div>
                                <div class="text-right mt-4">
                                    <label class="text-muted font-weight-normal m-0">Total price</label>
                                    <div class="text-large"><strong>$<%=String.format("%.2f", finalprice)%></strong></div>
                                </div>
                            </div>
                        </div>

                        <div class="float-right">
                            <button type="button" class="btn btn-lg btn-default md-btn-flat mt-2 mr-3">Back to shopping</button>
                            <button type="button" class="btn btn-lg btn-primary mt-2">Checkout</button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
