package Controllers;

import DAOs.UserAccountDAO;

import DAOs.VoucherDAO;
import Models.Voucher;
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


public class VoucherController extends HttpServlet {

    private VoucherDAO VoucherDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            VoucherDAO = new VoucherDAO();
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
            VoucherDAO vdao = new VoucherDAO();
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
                if (url.endsWith("/VoucherManagement/Ds")) {
                    request.getRequestDispatcher("/VoucherManagement.jsp").forward(request, response);
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