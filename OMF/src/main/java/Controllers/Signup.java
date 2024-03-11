/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.AccountDAO;
import DAOs.UserAccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class Signup extends HttpServlet {

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
            out.println("<title>Servlet Signup</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Signup at " + request.getContextPath() + "</h1>");
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
        // processRequest(request, response);
        
        String url = request.getRequestURI();
        HttpSession session = request.getSession();
        
        try {
             if (url.equals(request.getContextPath() + "/Signup")) {
        request.getRequestDispatcher("/Signup.jsp").forward(request, response);
    }
        } catch (Exception e) {
            Logger.getLogger(Home.class.getName()).log(Level.SEVERE, null, e);
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
        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("userpass");
        String re_pass = request.getParameter("repass");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        AccountDAO dao;
        UserAccountDAO daos;
        
        try {
            if (!password.equals(re_pass)) {
                request.getRequestDispatcher("/Signup.jsp?error=Password").forward(request, response);
            } else {
                dao = new AccountDAO();
                daos = new UserAccountDAO();
                boolean usernameExists = dao.checkUsernameExists(username);
                if (usernameExists) {
                    request.getRequestDispatcher("/Signup.jsp?error=usernameexists").forward(request, response);
                } else {
                    // Insert into Accounts table
                    boolean rs1 = dao.signup(username, password);

                    // Insert into UserAccount table
                    boolean rs2 = daos.signupUserAccount(username, fullname, email, phone);

                    // Redirect based on result
                    if (rs1 && rs2) {
                        Cookie cookie = new Cookie("User", username);
                        cookie.setMaxAge(3 * 24 * 60 * 60);
                        response.addCookie(cookie);
                        response.sendRedirect("/Login");
                    } else {
                        // Handle the case where insertion failed for one or both tables
                        // Redirect or show an error message to the user
                    }
                }
            }
        } catch (Exception e) {
            Logger.getLogger(AccountLogin.class.getName()).log(Level.SEVERE, null, e);
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
