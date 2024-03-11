/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.Detail_OrderDAO;
import DAOs.OrdersDAO;
import DAOs.ProductDAO;
import DAOs.AccountDAO;
import Models.Detail_Order;
import Models.Products;
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

public class ProductList extends HttpServlet {

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
                if (url.endsWith("/ProductList/Ds")) {
                    request.getRequestDispatcher("/ProductList.jsp").forward(request, response);
                } else if (url.startsWith("/ProductList/delete")) {
                    String[] datas = url.split(("/"));
                    String id = datas[datas.length - 1];
                    ProductDAO proDAO = new ProductDAO();
                    OrdersDAO oDAO = new OrdersDAO();
                    Detail_OrderDAO doDAO = new Detail_OrderDAO();
                    
                    ResultSet rs = doDAO.getAllFromProID(id);
                    doDAO.deleteByProID(id);
                    while (rs.next()) { 
                        oDAO.delete(rs.getString("OrderID"));
                    }

                    proDAO.delete(id);
                    response.sendRedirect("/ProductList/Ds");
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
            try {
                String ProID = request.getParameter("ProID");
                int ProStock = Integer.parseInt(request.getParameter("ProStock"));
                String ProName = request.getParameter("ProName");
                String ProPic = request.getParameter("ProPic");
                String ProDes = request.getParameter("ProDes");
                float ProPrice = Float.parseFloat(request.getParameter("ProPrice"));
                String ProType = request.getParameter("ProType");

                ProductDAO proDAO = new ProductDAO();
                proDAO.update(new Products(ProID, ProStock, ProName, ProPic, ProDes, ProPrice, ProType));

                response.sendRedirect("/ProductList/Ds");
            } catch (Exception ex) {
                Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        if (request.getParameter("btnAddNew") != null && request.getParameter("btnAddNew").equals("AddNew")) {
            try {
                ProductDAO proDAO = new ProductDAO();
                int i = 1;
                String ProID = "Pro_" + (proDAO.getTotalProductsCount()+ i);
                while (proDAO.getProducts(ProID) != null) {
                    ProID = "Pro_" + (proDAO.getTotalProductsCount() + ++i);
                }
String ProName = request.getParameter("ProName");
                int ProStock = Integer.parseInt(request.getParameter("ProStock"));
                String ProPic = request.getParameter("ProPic");
                String ProDes = request.getParameter("ProDes");
                float ProPrice = Float.parseFloat(request.getParameter("ProPrice"));
                String ProType = request.getParameter("ProType");

                proDAO.add(new Products(ProID, ProStock, ProName, ProPic, ProDes, ProPrice, ProType));

                response.sendRedirect("/ProductList/Ds");
            } catch (Exception ex) {
                Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
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
