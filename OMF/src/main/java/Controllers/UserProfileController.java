
package Controllers;

import DAOs.Detail_OrderDAO;
import DAOs.OrdersDAO;
import DAOs.ProductDAO;
import DAOs.AccountDAO;
import DAOs.UserAccountDAO;
import Models.Detail_Order;
import Models.Products;
import Models.Account;
import Models.UserAccount;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserProfileController extends HttpServlet {

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
            out.println("<title>Servlet VegetableList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VegetableList at " + request.getContextPath() + "</h1>");
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
        String url = request.getRequestURI();
        HttpSession session = request.getSession();

        try {
            AccountDAO adao = new AccountDAO();
            UserAccountDAO uadao = new UserAccountDAO();
            Cookie[] cookies = request.getCookies();
            boolean isLogin = false;
            String username = "";
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("User")) {
                    isLogin = true;
                    username = cookie.getValue();
                    break;
                }
            }
            if (!isLogin) {
                response.sendRedirect("/login");
            } else {
                if (url.endsWith("/UserProfile")) {
                    request.getRequestDispatcher("/UserProfile.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, e);
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
        if (request.getParameter("btnUpdate") != null && request.getParameter("btnUpdate").equals("Update")) {
            
            Cookie[] cookies = request.getCookies();
            String Username = null;
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("User".equals(cookie.getName())) {
                        Username = cookie.getValue();
                        break;
                    }
                }
            }
            if (Username == null) {
                response.sendRedirect("/Login");
                return;
            }
            try {
                Username = request.getParameter("Username");
                String AccPic = request.getParameter("AccPic");
                String Password = request.getParameter("Password");
                String Role = request.getParameter("Role");
                if (Username == null || Username.isEmpty()) {
                    throw new IllegalArgumentException("Username is null or empty");
                }
                AccountDAO apDAO = new AccountDAO();
                apDAO.update(new Account(Username, Password, Role, AccPic));
                System.out.println("Test1");
                response.sendRedirect("/UserProfile");
                
            } catch (Exception ex) {
                Logger.getLogger(UserProfileController.class.getName()).log(Level.SEVERE, null, ex);
                ex.printStackTrace();
            }
        }
                
        else if (request.getParameter("btnUpdates") != null && request.getParameter("btnUpdates").equals("Updates")) {
            try {
                System.out.println("Test2");
                int result = 0;
                String UserID = request.getParameter("UserID");
                String Fullname = request.getParameter("Fullname");
                String Mail = request.getParameter("Mail");
                String Address = request.getParameter("Address");
                String City = request.getParameter("City");
                String Phone = request.getParameter("Phone");
                Float Wallet = Float.parseFloat(request.getParameter("Wallet"));
                
                UserAccountDAO aDAO = new UserAccountDAO();
                result = aDAO.update(new UserAccount(UserID, Fullname, Mail, Address, City, Phone, Wallet));
                System.out.println("Update method called.");
                System.out.println("Number of rows updated: " + result);
                response.sendRedirect("/UserProfile");
            } catch (Exception ex) {
                Logger.getLogger(UserProfileController.class.getName()).log(Level.SEVERE, null, ex);
                ex.printStackTrace();
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
