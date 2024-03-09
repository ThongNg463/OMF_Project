/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.Detail_OrderDAO;
import DAOs.OrdersDAO;
import DAOs.ProductDAO;
import DAOs.accountDAO;
import Models.Detail_Order;
import Models.Orders;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
public class Home extends HttpServlet {

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
            out.println("<title>Servlet Home</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Home at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);

        String url = request.getRequestURI();
        HttpSession session = request.getSession();

        try {
             if (url.equals(request.getContextPath() + "/Home")) {
        request.getRequestDispatcher("/Home.jsp").forward(request, response);
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
        if (request.getParameter("btnAddNew") != null && request.getParameter("btnAddNew").equals("AddNew")) {
            try {
                String UserID = request.getParameter("Username");
                OrdersDAO ordersDAO = new OrdersDAO();
                int i = 1;
                String OrderID = "Order_" + (ordersDAO.getTotalOrderCount() + i);
                while (ordersDAO.getOrder(OrderID) != null) {
                    OrderID = "Order_" + (ordersDAO.getTotalOrderCount() + ++i);
                }
                String Status = "Confirming";
                float TotalPrice = 0;
                ordersDAO.add(new Orders(OrderID, UserID, UserID, Status, TotalPrice, "None", Timestamp.valueOf(LocalDateTime.now())));
                ProductDAO proDAO = new ProductDAO();
                ResultSet rsPro = proDAO.getAll();

                Detail_OrderDAO doDAO = new Detail_OrderDAO();

                i = 0;
                while (rsPro.next()) {
                    int Quality = Integer.parseInt(request.getParameter("Quality_" + ++i));
                    if (Quality > 0) {
                        doDAO.add(new Detail_Order(OrderID, rsPro.getString("ProID"), Quality));
                        float tempTotal = Quality * Float.parseFloat(rsPro.getString("ProPrice"));
                        TotalPrice += tempTotal;
                    }
                }

                if (TotalPrice == 0) {
                    ordersDAO.delete(OrderID);
                } else {
                    ordersDAO.update(new Orders(OrderID, UserID, UserID, Status, TotalPrice, "None", Timestamp.valueOf(LocalDateTime.now())));
                }

                response.sendRedirect("/Home");
            } catch (Exception ex) {
                Logger.getLogger(Home.class.getName()).log(Level.SEVERE, null, ex);
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
