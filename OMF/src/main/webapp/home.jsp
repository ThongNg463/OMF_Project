<%@page import="DAOs.ProductDAO"%>
<%@page import="Models.account"%>
<%@page import="DAOs.accountDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <title>OMF</title>
        <meta content="" name="description">
        <meta content="" name="keywords">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <!-- Custom styles for this template -->
        <link href="/UI/css/sb-admin-2.min.css" rel="stylesheet">

        <!-- Custom styles for this page -->
        <link href="/UI/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

        <!-- Favicons -->
        <link href="./assets/img/favicon.png" rel="icon">
        <link href="./assets/img/apple-touch-icon.png" rel="apple-touch-icon">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Playfair+Display:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

        <!-- Vendor CSS Files -->
        <link href="./assets/vendor/animate.css/animate.min.css" rel="stylesheet">
        <link href="./assets/vendor/aos/aos.css" rel="stylesheet">
        <link href="./assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="./assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="./assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
        <link href="/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
        <link href="./assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.1/css/boxicons.min.css" integrity="sha512-1G4xgZ6x60t7U0LyT0xMl0Zn8DVLb5Qgj5LbLh0zzzFJQaCRW8ZZT3wHjVdYKdY5mreMZc4E6xFVKA+joz9/gQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <!-- Template Main CSS File -->
        <link href="assets/css/home.css" rel="stylesheet">

    </head>

    <body>
        <%
            accountDAO AccDAO = new accountDAO();
            account userAcc = new account();

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

            boolean isLogin = false;

            if (username != null && !username.isEmpty()) {
                isLogin = true;
                userAcc = AccDAO.getAccount(username);
            }
        %>
        <!-- ======= Top Bar ======= -->
        <div id="topbar" class="d-flex align-items-center fixed-top">
            <div class="container d-flex justify-content-center justify-content-md-between">
                <div class="contact-info d-flex align-items-center">
                    <div>Contact: +84 123456789 |</div> <br>
                    <div>Opening: Mon-Sat: 7AM - 22PM</div>
                </div>
            </div>


        </div>

        <!-- ======= Header ======= -->
        <header id="header" class="fixed-top d-flex align-items-cente">
            <div class="container-fluid container-xl d-flex align-items-center justify-content-lg-between">

                <h1 class="logo me-auto me-lg-0"><a href="/Home">OMF</a></h1>
                <!-- Uncomment below if you prefer to use an image logo -->
                <!-- <a href="index.html" class="logo me-auto me-lg-0"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->

                <nav id="navbar" class="navbar order-last order-lg-0">
                    <ul>
                        <li><a class="nav-link scrollto active" href="#hero">Home</a></li>
                        <li><a class="nav-link scrollto" href="#about">About</a></li>
                        <li><a class="nav-link scrollto" href="#menu">Menu</a></li>
                        <li><a class="nav-link scrollto" href="#specials">Specials</a></li>
                        <li><a class="nav-link scrollto" href="#events">Events</a></li>
                        <li><a class="nav-link scrollto" href="#gallery">Gallery</a></li>
                        <li><a class="nav-link scrollto" href="#chefs">Members</a></li>
                        <li><a class="nav-link scrollto" href="#contact">Contact</a></li>
                            <%  if (isLogin && userAcc.getRole().equals("Admin")) { %>
                        <li class="dropdown"><a href="#"><span>Admin</span></a>
                            <ul>
                                <li><a href="/prlist/ds">Products List</a></li>
                                <li><a href="/olist/ds">Orders List</a></li>
                            </ul>
                        </li>       
                        <% }%>
                    </ul>
                    <i class="bi bi-list mobile-nav-toggle"></i>
                </nav><!-- .navbar -->
                <a href="#book-a-table" class="book-a-table-btn scrollto d-none d-lg-flex">Order food</a>

                <%
                    if (isLogin) {
                %>
                <nav id="navbar" class="navbar order-last order-lg-0">
                    <ul>
                        <div class="vr" style="max-height: 100%;"></div>
                        <li class="dropdown">
                            <a href="#">
                                    <span style="font-family: sans-serif; font-size: 25px" ><%= username%><img class="img-profile rounded-circle" style="margin-left:10px;height: 30px; width: 30px" src="<%= userAcc.getAccpic()%>"></span>
                            </a>
                            <ul>
                                <li><a href="userProfile"><span><i class="fas fa-user" style="margin-right: 10px"></i>Profile</span></a></li>
                                <li><a href="#"><span><i class="fas fa-cogs" style="margin-right: 10px"></i>Settings</span></a></li>
                                <li><hr class="hr hr-blurry" style="color: grey" /></li>
                                <li><a href="/logout"><span><i class="fas fa-sign-out-alt" style="margin-right: 10px"></i>Log out</span></a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
                <%
                } else {
                    // Người dùng chưa đăng nhập, hiển thị các tùy chọn đăng nhập/đăng ký
                %>
                <div class="languages d-none d-md-flex align-items-center">
                    <h4><a href="/Login">Login</a> | <a href="/signup.jsp">Sign Up</a></h4>
                </div>
                <%
                    }
                %>

            </div>
        </header><!-- End Header -->

        <!-- ======= Hero Section ======= -->
        <section id="hero" class="d-flex align-items-center">
            <div class="container position-relative text-center text-lg-start" data-aos="zoom-in" data-aos-delay="100">
                <div class="row">
                    <div class="col-lg-8">
                        <h1>Welcome to <span>OMF</span></h1>
                        <h2>Delivering great foods!</h2>

                        <div class="btns">
                            <a href="#menu" class="btn-menu animated fadeInUp scrollto">Our Menu</a>
                            <a href="#book-a-table" class="btn-book animated fadeInUp scrollto">Order food</a>
                        </div>
                    </div>
                    <div class="col-lg-4 d-flex align-items-center justify-content-center position-relative" data-aos="zoom-in" data-aos-delay="200">
                        <a href="https://www.youtube.com/watch?v=u6BOC7CDUTQ" class="glightbox play-btn"></a>
                    </div>

                </div>
            </div>
        </section><!-- End Hero -->

        <main id="main">

            <!-- ======= About Section ======= -->
            <section id="about" class="about">
                <div class="container" data-aos="fade-up">

                    <div class="row">
                        <div class="col-lg-6 order-1 order-lg-2" data-aos="zoom-in" data-aos-delay="100">
                            <div class="about-img">
                                <img src="assets/img/about.jpg" alt="">
                            </div>
                        </div>
                        <div class="col-lg-6 pt-4 pt-lg-0 order-2 order-lg-1 content">
                            <h3>Overview of the restaurant space</h3>
                            <p class="fst-italic">
                                Some features of the restaurant.
                            </p>
                            <ul>
                                <li><i class="bi bi-check-circle"></i>Design and Layout are beautiful.</li>
                                <li><i class="bi bi-check-circle"></i>Cool and quiet space.</li>
                                <li><i class="bi bi-check-circle"></i>Have melodious musics while enjoying the food.</li>
                            </ul>
                            <p>
                                Immersed in the restaurant's artfully crafted design, one finds solace in its cool, quiet corners. It's a sanctuary where the outside world's hustle fades into a distant murmur, replaced by the gentle caress of melodious music. As each dish is presented, the harmonious tunes elevate the act of dining into a multisensory ballet, leaving the palate and soul equally nourished..
                            </p>
                        </div>
                    </div>

                </div>
            </section><!-- End About Section -->

            <!-- ======= Why Us Section ======= -->
            <section id="why-us" class="why-us">
                <div class="container" data-aos="fade-up">

                    <div class="section-title">
                        <h2>Why Us</h2>
                        <p>Why Choose Our Restaurant</p>
                    </div>

                    <div class="row">

                        <div class="col-lg-4">
                            <div class="box" data-aos="zoom-in" data-aos-delay="100">
                                <span>01</span>
                                <h4>Price</h4>
                                <p>Commensurate with the price, reflecting the outstanding impeccable service provided.</p>
                            </div>
                        </div>

                        <div class="col-lg-4 mt-4 mt-lg-0">
                            <div class="box" data-aos="zoom-in" data-aos-delay="200">
                                <span>02</span>
                                <h4>Quality</h4>
                                <p>The cuisine meets international standards, ensuring hygiene and safety.</p>
                            </div>
                        </div>

                        <div class="col-lg-4 mt-4 mt-lg-0">
                            <div class="box" data-aos="zoom-in" data-aos-delay="300">
                                <span>03</span>
                                <h4> Service</h4>
                                <p>Exceptional and attentive, enhancing the dining experience.</p>
                            </div>
                        </div>

                    </div>

                </div>
            </section><!-- End Why Us Section -->

            <!-- ======= Menu Section ======= -->
            <section id="menu" class="menu section-bg">
                <div class="container" data-aos="fade-up">

                    <div class="section-title">
                        <h2>Menu</h2>
                        <p>Check Our Tasty Menu</p>
                    </div>
                    <div class="row" data-aos="fade-up" data-aos-delay="100">
                        <div class="col-lg-12 d-flex justify-content-center">
                            <ul id="menu-flters">
                                <li data-filter="*" class="filter-active">All</li>
                                <li data-filter=".filter-starters">Starters</li>
                                <li data-filter=".filter-salads">Salads</li>
                                <li data-filter=".filter-specialty">Specialty</li>
                            </ul>
                        </div>
                    </div>
                    <div class="row menu-container" data-aos="fade-up" data-aos-delay="200">

                        <%
                            ProductDAO proDAO = new ProductDAO();
                            ResultSet rs = proDAO.getAll();
                            while (rs.next()) {

                        %>
                        <div class="col-lg-6 menu-item filter-<%=rs.getString("ProType")%>">
                            <img src="<%=rs.getString("ProPic")%>" class="menu-img" alt="Menu Picture">
                            <div class="menu-content">
                                <a href="#book-a-table"><%=rs.getString("ProName")%></a><span>$<%=rs.getString("ProPrice")%></span>
                            </div>
                            <div class="menu-ingredients">
                                <%= rs.getString("ProDes")%>
                            </div>
                        </div>
                        <% }
                        %>
                    </div>

                </div>
            </section><!-- End Menu Section -->

            <!-- ======= Specials Section ======= -->
            <section id="specials" class="specials">
                <div class="container" data-aos="fade-up">

                    <div class="section-title">
                        <h2>Specials</h2>
                        <p>Check Our Specials</p>
                    </div>

                    <div class="row" data-aos="fade-up" data-aos-delay="100">
                        <div class="col-lg-3">
                            <ul class="nav nav-tabs flex-column">
                                <li class="nav-item">
                                    <a class="nav-link active show" data-bs-toggle="tab" href="#tab-1">Crab Cake</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-bs-toggle="tab" href="#tab-2">Greek Salad</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-bs-toggle="tab" href="#tab-3">Tuscan Grilled</a>
                                </li>
                            </ul>
                        </div>
                        <div class="col-lg-9 mt-4 mt-lg-0">
                            <div class="tab-content">
                                <div class="tab-pane active show" id="tab-1">
                                    <div class="row">
                                        <div class="col-lg-8 details order-2 order-lg-1">
                                            <h3>CRAB CRAB CRAB</h3>
                                            <p class="fst-italic">Upon first glance, the cake commands attention with its exquisite presentation</p>
                                            <p>The layering technique displayed hints at a rich textural experience, suggesting a meticulous balance of moist sponge and decadent filling. The color palette is thoughtfully selected, evoking both elegance and festivity, while the garnishing — possibly edible flowers or artisanal sugar work — showcases a commitment to fine detail.</p>
                                        </div>
                                        <div class="col-lg-4 text-center order-1 order-lg-2">
                                            <img src="https://i.imgur.com/VkZat6d.jpg" alt="" class="img-fluid">
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tab-2">
                                    <div class="row">
                                        <div class="col-lg-8 details order-2 order-lg-1">
                                            <h3>Salad so clean</h3>
                                            <p class="fst-italic">The Greek salad exemplifies the vibrant heart of Mediterranean cuisine.</p>
                                            <p>The salad is adorned with a generous sprinkling of feta cheese, adding a creamy yet crumbly texture that contrasts beautifully with the crunch of fresh vegetables. Kalamata olives provide a burst of briny flavor, a perfect complement to the salad's drizzle of olive oil and oregano.</p>
                                        </div>
                                        <div class="col-lg-4 text-center order-1 order-lg-2">
                                            <img src="https://i.imgur.com/7E357qW.jpg" alt="" class="img-fluid">
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tab-3">
                                    <div class="row">
                                        <div class="col-lg-8 details order-2 order-lg-1">
                                            <h3>Tuscan Grilled</h3>
                                            <p class="fst-italic">This Tuscan grilled dish is a splendid showcase of rustic Italian cooking.</p>
                                            <p>The grill marks on the protein suggest a perfect sear, promising a succulent interior with a smoky, charred flavor that can only be achieved through mastery of the flame. Accompanied by a medley of grilled vegetables, their edges caramelized and sweet, the dish balances heartiness with health.</p>
                                        </div>
                                        <div class="col-lg-4 text-center order-1 order-lg-2">
                                            <img src="assets/img/menu/tuscan-grilled.jpg" alt="" class="img-fluid">
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>
            </section><!-- End Specials Section -->

            <!-- ======= Events Section ======= -->
            <section id="events" class="events">
                <div class="container" data-aos="fade-up">

                    <div class="section-title">
                        <h2>Events</h2>
                        <p>Organize Your Events in our Restaurant</p>
                    </div>

                    <div class="events-slider swiper" data-aos="fade-up" data-aos-delay="100">
                        <div class="swiper-wrapper">

                            <div class="swiper-slide">
                                <div class="row event-item">
                                    <div class="col-lg-6">
                                        <img src="assets/img/event-birthday.jpg" class="img-fluid" alt="">
                                    </div>
                                    <div class="col-lg-6 pt-4 pt-lg-0 content">
                                        <h3>Birthday Parties</h3>
                                        <div class="price">
                                            <p><span>$189</span></p>
                                        </div>
                                        <p class="fst-italic">
                                            Mark another year or a significant achievement with our 'Event Birthday' package. Let the celebratory spirit come alive with vibrant cakes and a feast that pays homage to the milestones.
                                        </p>
                                        <p>
                                            Celebrate life's milestones with our 'Event Birthday' package, where joy and flavor collide. From colorful cakes to sumptuous spreads, our festive menus are designed to delight. We take pride in creating birthday experiences that are as unique as the honoree, with every dish crafted to be a tribute to the occasion.
                                        </p>
                                    </div>
                                </div>
                            </div><!-- End testimonial item -->

                            <div class="swiper-slide">
                                <div class="row event-item">
                                    <div class="col-lg-6">
                                        <img src="assets/img/event-private.jpg" class="img-fluid" alt="">
                                    </div>
                                    <div class="col-lg-6 pt-4 pt-lg-0 content">
                                        <h3>Private Parties</h3>
                                        <div class="price">
                                            <p><span>$290</span></p>
                                        </div>
                                        <p class="fst-italic">
                                            We specialize in creating events that reflect your personal theme, transforming our space to match your dream.
                                        </p>
                                        <p>
                                            Our 'Event Private' experience offers an exclusive escape into culinary excellence. Perfect for private parties or confidential corporate meetings, we provide a serene setting where grilled masterpieces and artfully composed salads become the conversation pieces. Relish in the privacy and indulge in a gastronomic journey that's as intimate as it is impressive.
                                        </p>
                                    </div>
                                </div>
                            </div><!-- End testimonial item -->

                            <div class="swiper-slide">
                                <div class="row event-item">
                                    <div class="col-lg-6">
                                        <img src="assets/img/event-custom.jpg" class="img-fluid" alt="">
                                    </div>
                                    <div class="col-lg-6 pt-4 pt-lg-0 content">
                                        <h3>Custom Parties</h3>
                                        <div class="price">
                                            <p><span>$99</span></p>
                                        </div>
                                        <p class="fst-italic">
                                            Craft an event as unique as your imagination with our 'Event Custom' service.
                                        </p>

                                        <p>
                                            Let our bespoke event services transform your vision into a memorable reality. Whether it’s a corporate gala with sophisticated Greek salads, a farm-to-table Tuscan dinner, or a vibrant, thematic soiree, we tailor every aspect to your preference. Our 'Event Custom' option ensures that your unique style shines through in every detail, from the menu to the ambiance.
                                        </p>
                                    </div>
                                </div>
                            </div><!-- End testimonial item -->

                        </div>
                        <div class="swiper-pagination"></div>
                    </div>

                </div>
            </section><!-- End Events Section -->

            <!-- ======= Order food Section ======= -->
            <section id="book-a-table" class="book-a-table">
                <div class="container" data-aos="fade-up">

                    <div class="section-title">
                        <h2>Reservation</h2>
                        <p>Order food</p>
                    </div>

                    <%
                        if (!isLogin) {
                    %>
                    <h3>If you want to order food, please log in first or register if you don't have an account!</h3>
                    <div class="languages d-none d-md-flex align-items-center">
                        <br>
                        <h4><a href="/Login">Login</a> | <a href="/signup.jsp">Sign Up</a></h4>
                    </div>
                    <%
                    } else {
                    %>

                    <form method="post"  data-aos="fade-up" data-aos-delay="100">
                        <div class="row">
                            <input type="hidden" name="Username" value="<%=username%>">

                            <%
                                rs = proDAO.getAll();
                                int i = 0;
                                while (rs.next()) {
                            %>
                            <div class="col-lg-6 col-md-6 form-group mt-3 mt-md-0">
                                <div style="text-align: right">                                  
                                    <h4 style="display: inline;"><%=rs.getString("ProName")%></h4>
                                    <img src="<%=rs.getString("ProPic")%>" alt="Product Picture" style="max-height: 50px; border-radius: 50%; display: inline;"/>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 form-group mt-3 mt-md-0">
                                <input type="number" name="Quality_<%=++i%>" style="max-width: 50%" class="form-control" id="Quality" placeholder="Quality" value="0" required>
                            </div>
                            <% } %>

                        </div>
                        <br>
                        <div class="text-center"><button onclick="return confirm('Are you sure?')" style="font-size: 150%; border-radius: 12px" type="submit" name="btnAddNew" value="AddNew">Order food</button></div>
                    </form>

                    <% }%>
                </div>
            </section><!-- End Book A Table Section -->


            <!-- ======= Gallery Section ======= -->
            <section id="gallery" class="gallery">

                <div class="container" data-aos="fade-up">
                    <div class="section-title">
                        <h2>Gallery</h2>
                        <p>Some photos from Our Restaurant</p>
                    </div>
                </div>

                <div class="container-fluid" data-aos="fade-up" data-aos-delay="100">

                    <div class="row g-0">

                        <div class="col-lg-3 col-md-4">
                            <div class="gallery-item">
                                <a href="assets/img/gallery/gallery-1.jpg" class="gallery-lightbox" data-gall="gallery-item">
                                    <img src="assets/img/gallery/gallery-1.jpg" alt="" class="img-fluid">
                                </a>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-4">
                            <div class="gallery-item">
                                <a href="assets/img/gallery/gallery-2.jpg" class="gallery-lightbox" data-gall="gallery-item">
                                    <img src="assets/img/gallery/gallery-2.jpg" alt="" class="img-fluid">
                                </a>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-4">
                            <div class="gallery-item">
                                <a href="assets/img/gallery/gallery-3.jpg" class="gallery-lightbox" data-gall="gallery-item">
                                    <img src="assets/img/gallery/gallery-3.jpg" alt="" class="img-fluid">
                                </a>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-4">
                            <div class="gallery-item">
                                <a href="assets/img/gallery/gallery-4.jpg" class="gallery-lightbox" data-gall="gallery-item">
                                    <img src="assets/img/gallery/gallery-4.jpg" alt="" class="img-fluid">
                                </a>
                            </div>
                        </div>
                    </div>

                </div>
            </section><!-- End Gallery Section -->

            <!--             ======= Chefs Section ======= 
                        <section id="chefs" class="chefs">
                            <div class="container" data-aos="fade-up">
            
                                <div class="section-title">
                                    <h2>Group 1</h2>
                                    <p>Our Members</p>
                                </div>
            
                                <div class="row">
            
                                    <div class="col-lg-3 col-md-6">
                                        <div class="member" data-aos="zoom-in" data-aos-delay="100">
                                            <img src="assets/img/chefs/Toan.jpg" class="img-fluid" alt="">
                                            <div class="member-info">
                                                <div class="member-info-content">
                                                    <h4>Thanh Toan</h4>
                                                    <span>Leader 1</span>
                                                </div>
                                                <div class="social">
                                                    <a href=""><i class="bi bi-twitter"></i></a>
                                                    <a href=""><i class="bi bi-facebook"></i></a>
                                                    <a href=""><i class="bi bi-instagram"></i></a>
                                                    <a href=""><i class="bi bi-linkedin"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
            
                                    <div class="col-lg-3 col-md-6">
                                        <div class="member" data-aos="zoom-in" data-aos-delay="200">
                                            <img src="assets/img/chefs/Hoa.jpg" class="img-fluid" alt="">
                                            <div class="member-info">
                                                <div class="member-info-content">
                                                    <h4>Gia Hoa</h4>
                                                    <span>Leader 3</span>
                                                </div>
                                                <div class="social">
                                                    <a href=""><i class="bi bi-twitter"></i></a>
                                                    <a href=""><i class="bi bi-facebook"></i></a>
                                                    <a href=""><i class="bi bi-instagram"></i></a>
                                                    <a href=""><i class="bi bi-linkedin"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="member" data-aos="zoom-in" data-aos-delay="300">
                                            <img src="assets/img/chefs/Tan.jpg" class="img-fluid" alt="">
                                            <div class="member-info">
                                                <div class="member-info-content">
                                                    <h4>Trong Tan</h4>
                                                    <span>Leader 4</span>
                                                </div>
                                                <div class="social">
                                                    <a href=""><i class="bi bi-twitter"></i></a>
                                                    <a href=""><i class="bi bi-facebook"></i></a>
                                                    <a href=""><i class="bi bi-instagram"></i></a>
                                                    <a href=""><i class="bi bi-linkedin"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-lg-3 col-md-6">
                                        <div class="member" data-aos="zoom-in" data-aos-delay="100">
                                            <img src="assets/img/chefs/Thong.jpg" class="img-fluid" alt="">
                                            <div class="member-info">
                                                <div class="member-info-content">
                                                    <h4>Minh Thong</h4>
                                                    <span>Leader 2</span>
                                                </div>
                                                <div class="social">
                                                    <a href=""><i class="bi bi-twitter"></i></a>
                                                    <a href=""><i class="bi bi-facebook"></i></a>
                                                    <a href=""><i class="bi bi-instagram"></i></a>
                                                    <a href=""><i class="bi bi-linkedin"></i></a>
                                                </div>
                                            </div> 
                                        </div>
                                         <div class="member" data-aos="zoom-in" data-aos-delay="300">
                                            <img src="assets/img/chefs/Hao.jpg" class="img-fluid" alt="">
                                            <div class="member-info">
                                                <div class="member-info-content">
                                                    <h4>Nhut Hao</h4>
                                                    <span>Member</span>
                                                </div>
                                                <div class="social">
                                                    <a href=""><i class="bi bi-twitter"></i></a>
                                                    <a href=""><i class="bi bi-facebook"></i></a>
                                                    <a href=""><i class="bi bi-instagram"></i></a>
                                                    <a href=""><i class="bi bi-linkedin"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
            
                            </div>
                        </section> End Chefs Section -->

            <!-- ======= Contact Section ======= -->
            <section id="contact" class="contact">
                <div class="container" data-aos="fade-up">

                    <div class="section-title">
                        <h2>Contact</h2>
                        <p>Contact Us</p>
                    </div>
                </div>

                <div data-aos="fade-up">
                    <iframe style="border:0; width: 100%; height: 350px;" src=https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3928.81426206091!2d105.7298567!3d10.0124518!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0882139720a77%3A0x3916a227d0b95a64!2sTr%C6%B0%E1%BB%9Dng+%C4%90%E1%BA%A1i+h%E1%BB%8Dc+FPT+C%E1%BA%A7n+Th%C6%A1!5e0!3m2!1sen!2s!4v1633028456789" frameborder="0" allowfullscreen></iframe>
                </div>

                <div class="container" data-aos="fade-up">

                    <div class="row mt-5">

                        <div class="col-lg-4">
                            <div class="info">
                                <div class="address">
                                    <i class="bi bi-geo-alt"></i>
                                    <h4>Location:</h4>
                                    <p>NVC District, FPT University, Can Tho</p>
                                </div>

                                <div class="open-hours">
                                    <i class="bi bi-clock"></i>
                                    <h4>Open Hours:</h4>
                                    <p>
                                        Monday-Saturday:<br>
                                        7:00 AM - 22:00 PM
                                    </p>
                                </div>

                                <div class="email">
                                    <i class="bi bi-envelope"></i>
                                    <h4>Email:</h4>
                                    <p>nhom5.fpt@hotmail.com</p>
                                </div>

                                <div class="phone">
                                    <i class="bi bi-telephone"></i>
                                    <h4>Call:</h4>
                                    <p>+84 123456789</p>
                                </div>

                            </div>

                        </div>

                        <div class="col-lg-8 mt-5 mt-lg-0">

                            <form action="forms/contact.php" method="post" role="form" class="php-email-form">
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <input type="text" name="name" class="form-control" id="name" placeholder="Your Name" required>
                                    </div>
                                    <div class="col-md-6 form-group mt-3 mt-md-0">
                                        <input type="email" class="form-control" name="email" id="email" placeholder="Your Email" required>
                                    </div>
                                </div>
                                <div class="form-group mt-3">
                                    <input type="text" class="form-control" name="subject" id="subject" placeholder="Subject" required>
                                </div>
                                <div class="form-group mt-3">
                                    <textarea class="form-control" name="message" rows="8" placeholder="Message" required></textarea>
                                </div>
                                <div class="my-3">
                                    <div class="loading">Loading</div>
                                    <div class="error-message"></div>
                                    <div class="sent-message">Your message has been sent. Thank you!</div>
                                </div>
                                <div class="text-center"><button type="submit">Send Message</button></div>
                            </form>

                        </div>

                    </div>

                </div>
            </section><!-- End Contact Section -->

        </main><!-- End #main -->

        <!-- ======= Footer ======= -->
        <footer id="footer">
            <div class="footer-top">
                <div class="container">
                    <div class="row">

                        <div class="col-lg-3 col-md-6">
                            <div class="footer-info">
                                <h3>Restaurantly</h3>
                                <p>
                                    NVC District <br>
                                    FPT University, Can Tho<br><br>
                                    <strong>Phone:</strong> +84 123456789<br>
                                    <strong>Email:</strong> nhom5.fpt@hotmail.com<br>
                                </p>
                                <div class="social-links mt-3">
                                    <a href="#" class="twitter"><i class="bx bxl-twitter"></i></a>
                                    <a href="#" class="facebook"><i class="bx bxl-facebook"></i></a>
                                    <a href="#" class="instagram"><i class="bx bxl-instagram"></i></a>
                                    <a href="#" class="google-plus"><i class="bx bxl-skype"></i></a>
                                    <a href="#" class="linkedin"><i class="bx bxl-linkedin"></i></a>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-2 col-md-6 footer-links">
                            <h4>Useful Links</h4>
                            <ul>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Home</a></li>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">About us</a></li>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Services</a></li>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Terms of service</a></li>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Privacy policy</a></li>
                            </ul>
                        </div>

                        <div class="col-lg-3 col-md-6 footer-links">
                            <h4>Our Services</h4>
                            <ul>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Web Design</a></li>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Web Development</a></li>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Product Management</a></li>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Marketing</a></li>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Graphic Design</a></li>
                            </ul>
                        </div>

                        <div class="col-lg-4 col-md-6 footer-newsletter">
                            <h4>Our Newsletter</h4>
                            <p>Please follow and subscribe to receive new information about us</p>
                            <form action="" method="post">
                                <input type="email" name="email"><input type="submit" value="Subscribe">
                            </form>

                        </div>

                    </div>
                </div>
            </div>

            <div class="container">
                <div class="copyright">
                    &copy; Copyright <strong><span>Nhom 5</span></strong>. All Rights Reserved
                </div>
                <div class="credits"> 
                    Designed by <a href="#">Nhom 5 Mai Dinh</a>
                </div>
            </div>
        </footer><!-- End Footer -->

        <div id="preloader"></div>
        <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

        <!-- Vendor JS Files -->
        <script src="assets/vendor/aos/aos.js"></script>
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
        <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
        <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
        <script src="assets/vendor/php-email-form/validate.js"></script>

        <!-- Template Main JS File -->
        <script src="assets/js/main.js"></script>
    </body>

</html>