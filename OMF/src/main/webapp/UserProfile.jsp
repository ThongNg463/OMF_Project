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
                            <img class="img-account-profile rounded-circle mb-2" src="<%= UserAcc.getAccpic()%>" alt="" style="height: 110px; width: 110px">
                            <!-- Profile picture help block-->
                            <div class="small font-italic text-muted mb-4">JPG or PNG no larger than 5 MB</div>
                            <!-- Profile picture upload button-->
                            <h4><%=userAcc.getUserID()%></h4>
                            <p class="text-secondary mb-1">Full Stack Developer</p>
                            <p class="text-muted font-size-sm">Nguyen Van Cu, Ninh Kieu</p>
                            <button class="btn btn-primary" type="button">Upload new image</button>
                        </div>
                    </div>
                </div>
                <div class="col-xl-8">
                    <!-- Account details card-->
                    <div class="card mb-4">
                        <div class="card-header">Account Details</div>
                        <div class="card-body">
                            <form>
                                <!-- Form Group (username)-->
                                <div class="mb-3">
                                    <label class="small mb-1" for="inputUsername">Full Name</label>
                                    <input class="form-control" id="inputUsername" type="text" placeholder="Enter your full name" value="<%=userAcc.getFullname()%>">
                                </div>
                                <!-- Form Row-->
                                <div class="row gx-3 mb-3">
                                    <!-- Form Group (first name)-->
                                    <div class="col-md-6">
                                        <label class="small mb-1" for="inputFirstName">UserID</label>
                                        <input class="form-control" id="inputFirstName" type="text" placeholder="Enter your UserID" value="<%=userAcc.getUserID()%>">
                                    </div>
                                    <!-- Form Group (last name)-->
                                    <div class="col-md-6">
                                        <label class="small mb-1" for="inputLastName">Wallet</label>
                                        <input class="form-control" id="inputLastName" type="text" placeholder="Total Money" value="<%=userAcc.getWallet()%>">
                                    </div>
                                </div>
                                <!-- Form Row        -->
                                <div class="row gx-3 mb-3">
                                    <!-- Form Group (organization name)-->
                                    <div class="col-md-6">
                                        <label class="small mb-1" for="inputOrgName">Address</label>
                                        <input class="form-control" id="inputOrgName" type="text" placeholder="Enter your address" value="Nguyen Van Cu, Ninh Kieu">
                                    </div>
                                    <!-- Form Group (location)-->
                                    <div class="col-md-6">
                                        <label class="small mb-1" for="inputLocation">City</label>
                                        <input class="form-control" id="inputLocation" type="text" placeholder="Enter your city" value="Can Tho">
                                    </div>
                                </div>
                                <!-- Form Group (email address)-->
                                <div class="mb-3">
                                    <label class="small mb-1" for="inputEmailAddress">Email address</label>
                                    <input class="form-control" id="inputEmailAddress" type="email" placeholder="Enter your email address" value="<%=userAcc.getMail()%>">
                                </div>
                                <!-- Form Row-->
                                <div class="row gx-3 mb-3">
                                    <!-- Form Group (phone number)-->
                                    <div class="col-md-6">
                                        <label class="small mb-1" for="inputPhone">Phone number</label>
                                        <input class="form-control" id="inputPhone" type="tel" placeholder="Enter your phone number" value="<%=userAcc.getPhone()%>">
                                    </div>
                                    <!-- Form Group (birthday)-->
                                    <div class="col-md-6">
                                        <label class="small mb-1" for="inputBirthday">Total orders</label>
                                        <input class="form-control" id="inputBirthday" type="text" name="birthday" placeholder="Total orders" value="Orders count">
                                    </div>
                                </div>
                                <!-- Save changes button-->
                                <button class="btn btn-primary" type="button">Save changes</button>
                            </form>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </body>
</html>
