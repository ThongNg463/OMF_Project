
<!DOCTYPE html>
<html>
    <head>
        <title>SignUp Form</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <link href="./assets/css/signup.css" rel="stylesheet" type="text/css" media="all">
        <link href="//fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,700,700i" rel="stylesheet">

    </head>
    <body>
        <div class="main-w3layouts wrapper">
            <h1>SignUp Form</h1>
            <div class="main-agileinfo">
                <div class="agileits-top">
                    <form action="signup" method="POST">
                        <%
                            String error = request.getParameter("error");
                            if ("usernameexists".equals(error)) {
                        %>
                        <h2 style="color: #ff0000; text-align: center" class="error-msg">Account already exist! Please try again!</h2>
                        <%
                            } else if ("Password".equals(error)) {
                        %>
                        <h2 style="color: #ff0000; text-align: center" class="error-msg">Passwords do not match! Please try again!</h2>
                        <%
                            }
                        %>
                        <input class="text" type="text" id="user-name" name="username" placeholder="Username" required="">    <br>                   
                        <input class="text" type="password" id="user-pass" name="userpass" placeholder="Password" required="">
                        <input class="text w3lpass" type="password" id="user-repass" name="repass" placeholder="Confirm Password" required="">
                        <div class="wthree-text">
                            <label class="anim">
                                <input type="checkbox" class="checkbox" required="">
                                <span>I Agree To The Terms & Conditions</span>
                            </label>
                            <div class="clear"> </div>
                        </div>
                        <input type="submit" id="signup" value="SIGNUP">
                    </form>
                    <p>Have an Account? <a href="/Login"> Login Now!</a></p>
                </div>
            </div>
        </div>
    </body>
</html>