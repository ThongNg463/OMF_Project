/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.UserAccountDAO;
import Models.UserAccount;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author namti
 */
public class LoginController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet loginController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet loginController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getRequestURI();

        
         if (path.endsWith("/OtpConfirm")) {
            request.getRequestDispatcher("/OtpConfirm.jsp").forward(request, response);
        } else if (path.endsWith("/ChangePassword")) {
            request.getRequestDispatcher("/ChangePassword.jsp").forward(request, response);
        } else if (path.endsWith("/ForgotPassword")) {
            request.getRequestDispatcher("/ForgotPassword.jsp").forward(request, response);
        } 
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            

        //--Xử lý Confirm Email---
        if (request.getParameter("btnConfirmOTP") != null) {
            String characters1 = request.getParameter("characters1");
            String characters2 = request.getParameter("characters2");
            String characters3 = request.getParameter("characters3");
            String characters4 = request.getParameter("characters4");
            String characters5 = request.getParameter("characters5");
            String characters6 = request.getParameter("characters6");
            String sendMailotp = request.getParameter("sentOTP");
            String email = request.getParameter("email");

            // Lưu email vào phiên
            String OTP = characters1 + characters2 + characters3 + characters4 + characters5 + characters6;
            if (sendMailotp.equals(OTP)) {
                // Chuyển hướng đến trang đổi mật khẩu
                response.sendRedirect("/ChangePassword");
                // Chuyển hướng đến trang "changePassword.jsp"
            } else {
                // Chuyển hướng đến trang nhập OTP và hiển thị thông báo lỗi
                response.sendRedirect("/OtpConfirm?error=1");
            }
        }

        //--Xử lý Confirm OTP
        if (request.getParameter("btnSendEmail") != null) {
            UserAccountDAO dao = null;
            try {
                dao = new UserAccountDAO();
            } catch (SQLException ex) {
                Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
            }
            String email = request.getParameter("Mail");
            if (email == null || email.trim().isEmpty()) {
                request.setAttribute("mess", "Email cannot be empty");
                request.getRequestDispatcher("/ForgotPassword.jsp").forward(request, response);
                return;
            }

            UserAccount a = null;
            try {
                a = dao.getCustomerByEmail(email);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (a != null) {
                request.getSession().setAttribute("email", email);
                String OTP = dao.generateOTP();
                String to = email;
                String fullname = null;
                try {
                    fullname = dao.getFullnameByEmail(email);
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
                }
                // Lưu mã OTP vào session
                request.getSession().setAttribute("otp", OTP);

                String subject = "OMF's message";
                String body = "<html><head>"
                        + "<style>"
                        + "body {"
                        + "    font-family: Arial, sans-serif;"
                        + "    background-color: #f2f2f2;"
                        + "    padding: 20px;"
                        + "}"
                        + "p {"
                        + "    color: #333333;"
                        + "}"
                        + "a {"
                        + "    color: #0066cc;"
                        + "    text-decoration: none;"
                        + "}"
                        + ".otp {"
                        + "    font-weight: bold;"
                        + "    font-size: 18px;"
                        + "}"
                        + ".rubicon {"
                        + "    font-size: 14px;" // Thay đổi kích thước font-size
                        + "    color: #669966;;" // Thay đổi màu chữ
                        + "    font-weight: normal;" // Thay đổi font-weight
                        + "}"
                        + "</style>"
                        + "</head>"
                        + "<body>"
                        + "<p>Dear customer " + fullname + ",</p>"
                        + "<p>Your OTP is:   <span class=\"otp\">" + OTP + "</span></p>"
                        + "<p>Please do not share your OTP to anyone else</p>"
                        + "   <p>Best regards </p>"
                        + "</body></html>";
                boolean result = sendEmail(to, subject, body);

                if (result) {
                    request.getSession().setAttribute("email", email);
                    response.sendRedirect("/OtpConfirm");
                } else {
                    response.sendRedirect("/User/ForgotPassword");
                }
            } else {
                request.setAttribute("mess", "Wrong email");
                request.getRequestDispatcher("/ForgotPassword.jsp").forward(request, response);
            }
        }

        //---Xử lý Forgot password---
        if (request.getParameter("btnReset") != null) {
            String email = request.getParameter("email");
            String pass = request.getParameter("newPassword");
            String rePass = request.getParameter("confirmPassword");
            UserAccountDAO dao = null;
            try {
                dao = new UserAccountDAO();
            } catch (SQLException ex) {
                Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
            }
            boolean success = dao.changePasswordByEmail(email, pass);
            if (success == true) {
                response.sendRedirect("/Login");
            } else {
                response.sendRedirect("/ChangePassword");
            }
        }
        //---Kết thúc xử lý Forgot password---
    }

    private boolean sendEmail(String to, String subject, String body) throws UnsupportedEncodingException {
        // Cấu hình các thông tin cần thiết để gửi email
        String host = "smtp.gmail.com";
        String port = "587";

        final String username = "khoinmce171346@fpt.edu.vn";
        final String password = "trjs arun qaeu wwgh";
        String displayName = "OMF";
        // Thiết lập các thuộc tính cho kết nối SMTP
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        // Tạo đối tượng Authenticator để xác thực người dùng
        Authenticator authenticator = new Authenticator() {

            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        };

        // Tạo phiên gửi email
        Session session = Session.getInstance(properties, authenticator);

        try {
            // Tạo đối tượng MimeMessage
            MimeMessage message = new MimeMessage(session);

            // Đặt thông tin người gửi và người nhận
            message.setFrom(new InternetAddress(username, displayName));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));

            // Đặt tiêu đề và nội dung email
            message.setSubject(subject, "UTF-8");
            message.setContent(body, "text/html; charset=UTF-8");

            // Gửi email
            Transport.send(message);

            return true;
        } catch (MessagingException ex) {
            return false;
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
