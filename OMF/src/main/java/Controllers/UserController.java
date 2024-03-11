package Controllers;

import DAOs.UserAccountDAO;

import DAOs.AccountDAO;
import Models.UserAccount;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;


public class UserController extends HttpServlet {

    private UserAccountDAO UserAccountDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            UserAccountDAO = new UserAccountDAO();
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = request.getRequestURI();
        HttpSession session = request.getSession();

        try {
            AccountDAO adao = new AccountDAO();
            Cookie[] cookies = request.getCookies();
            boolean isLogin = false;
            String Username = "";
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("User")) {
                    isLogin = true;
                    Username = cookie.getValue();
                }
            }
            if (!isLogin) {
                response.sendRedirect("/Login");
            } else {
                if (url.endsWith("/UserManagement/Ds")) {
                    request.getRequestDispatcher("/UserManagement.jsp").forward(request, response);
                } 
                  else if (url.startsWith("/UserManagement/delete")) {
                    String[] datas = url.split(("/"));
                    String UserID = datas[datas.length - 1];

                    UserAccountDAO customerDAO = new UserAccountDAO();
                    AccountDAO accountDAO = new AccountDAO();

                    // Delete from StaffAccount table
                    customerDAO.delete(UserID);
                    // Delete from Accounts table
                    accountDAO.delete(UserID);
                    // Redirect to the staff list page
                    response.sendRedirect("/UserManagement/Ds");
                }
            }
        } catch (Exception e) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, e);
        }

    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle any POST requests here if needed
    }
}