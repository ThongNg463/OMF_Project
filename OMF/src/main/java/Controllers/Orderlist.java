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
import Models.account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class Orderlist extends HttpServlet {

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
            out.println("<title>Servlet Orderlist</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Orderlist at " + request.getContextPath() + "</h1>");
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
            boolean isLogin = false;
            accountDAO adao = new accountDAO();
            account UserAcc = new account();
            String Username = null;
            Cookie[] cookies = request.getCookies();

            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("User")) {
                        isLogin = true;
                        UserAcc = adao.getAccount(cookie.getValue());
                        Username = UserAcc.getUsername();
                    }
                }
            }

            if (!isLogin) {
                response.sendRedirect("/Login");
            } else {
                if (url.endsWith("/olist/ds")) {
                    request.getRequestDispatcher("/listOrder.jsp").forward(request, response);
                } else if (url.startsWith("/olist/delete")) {
                    String[] datas = url.split("/");
                    String id = datas[datas.length - 1];
                    OrdersDAO odao = new OrdersDAO();
                    Detail_OrderDAO doDAO = new Detail_OrderDAO();
                    doDAO.delete(id);
                    odao.delete(id);
                    response.sendRedirect("/olist/ds");
                } else if (url.startsWith("/olist/updateU")) {
                    String[] datas = url.split("/");
                    String id = datas[datas.length - 1];
                    OrdersDAO odao = new OrdersDAO();
                    Orders o = odao.getOrder(id);

                    if (o == null) {
                        response.sendRedirect("/olist/ds");
                    } else {
                        String Status = o.getStatus();
                        if (Status.equals("Confirming")) {
                            o.setStatus("Confirmed");
                        } else if (Status.equals("Confirmed")) {
                            o.setStatus("Delivering");
                        } else if (Status.equals("Delivering")) {
                            o.setStatus("Delivered");
                        }
                        odao.update(o);
                        response.sendRedirect("/olist/ds");
                    }
                } else if (url.startsWith("/olist/updateD")) {
                    String[] datas = url.split("/");
                    String id = datas[datas.length - 1];
                    OrdersDAO odao = new OrdersDAO();
                    Orders o = odao.getOrder(id);

                    if (o == null) {
                        response.sendRedirect("/olist/ds");
                    } else {
                        String Status = o.getStatus();
                        if (Status.equals("Confirmed")) {
                            o.setStatus("Confirming");
                        } else if (Status.equals("Delivering")) {
                            o.setStatus("Confirmed");
                        } else if (Status.equals("Delivered")) {
                            o.setStatus("Delivering");
                        }
                        odao.update(o);
                        response.sendRedirect("/olist/ds");
                    }
                }

            }
        } catch (Exception ex) {
            Logger.getLogger(Orderlist.class.getName()).log(Level.SEVERE, null, ex);
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
                OrdersDAO ordersDAO = new OrdersDAO();
                int i = 1;
                String OrderID = "Order_" + (ordersDAO.getTotalOrderCount() + i);
                while (ordersDAO.getOrder(OrderID) != null) {
                    OrderID = "Order_" + (ordersDAO.getTotalOrderCount() + ++i);
                }
                String UserID = request.getParameter("Username");
                String Status = "Confirming";
                float TotalPrice = 0;
                
                ordersDAO.add(new Orders(OrderID, UserID, "", Status, TotalPrice, "", Timestamp.valueOf(LocalDateTime.now())));

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

                ordersDAO.update(new Orders(OrderID, UserID, "", Status, TotalPrice, "", Timestamp.valueOf(LocalDateTime.now())));

                response.sendRedirect("/olist/ds");
            } catch (Exception ex) {
                Logger.getLogger(Orderlist.class.getName()).log(Level.SEVERE, null, ex);
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
