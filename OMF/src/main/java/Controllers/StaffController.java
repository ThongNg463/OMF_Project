package Controllers;

import DAOs.StaffDAO;

import DAOs.AccountDAO;
import Models.StaffAccount;
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


public class StaffController extends HttpServlet {

    private StaffDAO StaffDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            StaffDAO = new StaffDAO();
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
                if (url.endsWith("/StaffManagement/Ds")) {
                    request.getRequestDispatcher("/StaffManagement.jsp").forward(request, response);
                } 
                else if (url.startsWith("/StaffManagement/delete")) {
                    String[] datas = url.split(("/"));
                    String staffId = datas[datas.length - 1];

                    StaffDAO staffDAO = new StaffDAO();
                    AccountDAO accountDAO = new AccountDAO();

                    // Delete from StaffAccount table
                    staffDAO.delete(staffId);
                    // Delete from Accounts table
                    accountDAO.delete(staffId);
                    // Redirect to the staff list page
                    response.sendRedirect("/StaffManagement/Ds");
                }
            }
        } catch (Exception e) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, e);
        }

    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      if (request.getParameter("btnAddNew") != null && request.getParameter("btnAddNew").equals("AddNew")) {
        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("userpass");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        StaffDAO dao;
        try {
            
                dao = new StaffDAO();
                boolean usernameExists = dao.checkUsernameExists(username);
                if (usernameExists) {
                    request.getRequestDispatcher("/StaffManagement.jsp?error=usernameexists").forward(request, response);
                } else {
                    // Insert into Accounts table
                    boolean rs1 = dao.AddAccount(username, password);

                    // Insert into UserAccount table
                    boolean rs2 = dao.AddStaffAccount(username, fullname, email, phone);

                    response.sendRedirect("/StaffManagement/Ds");
                }
            
        } catch (Exception e) {
            Logger.getLogger(AccountLogin.class.getName()).log(Level.SEVERE, null, e);
        }
    }
    }
}