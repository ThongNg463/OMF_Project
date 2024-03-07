/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAO;
import Models.account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ACER
 */
public class accountLogin extends HttpServlet {

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
            out.println("<title>Servlet accountLogin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet accountLogin at " + request.getContextPath() + "</h1>");
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
        Cookie[] cookies = request.getCookies();

        boolean isLogin = false;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("User")) {
                    isLogin = true;
                    response.sendRedirect("/Home");
                }
            }
        }
        
        if (!isLogin) {
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }

        //request.getRequestDispatcher("/index.jsp").forward(request, response);
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
        if (request.getParameter("btnSubmit") != null && request.getParameter("btnSubmit").equals("Submit")) {
            String username = request.getParameter("username");
            String password = request.getParameter("userpass");
            account tk = new account(username, password);
            accountDAO dao;
            try {
                dao = new accountDAO();
                boolean ketqua = dao.login(tk);
                if (ketqua) {
                    Cookie cookie = new Cookie("User", username);
                    cookie.setMaxAge(3 * 24 * 60 * 60);
                    response.addCookie(cookie);
                    HttpSession session = request.getSession();
                    session.setAttribute("cookie", cookie);
                    tk = dao.getAccount(username);
                    session.setAttribute("User", tk);                 
                    if (tk.getRole().equals("Admin")) {
                        response.sendRedirect("/prlist/ds");
                    } else {
                        response.sendRedirect("/Home");

                    }
                } else {
                    try {
                        dao = new accountDAO();
                        boolean usernameExists = dao.checkUsernameExists(username);

                        if (usernameExists) {
                            // Username đúng, password sai
                            response.sendRedirect("/Login?error=password");
                        } else {
                            // Cả username và password đều sai
                            response.sendRedirect("/Login?error=invalid");
                        }
                    } catch (SQLException | ClassNotFoundException ex) {
                        Logger.getLogger(accountLogin.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

            } catch (SQLException ex) {
                Logger.getLogger(accountLogin.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(accountLogin.class.getName()).log(Level.SEVERE, null, ex);
            }
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
