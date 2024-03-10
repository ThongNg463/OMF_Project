/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAO;
import DAOs.staffDAO;
import Models.StaffAccount;
import Models.account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tvmph
 */
public class StaffList extends HttpServlet {

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
            out.println("<title>Servlet StaffList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffList at " + request.getContextPath() + "</h1>");
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
        if (path.endsWith("/StaffList/ds")) {
            request.getRequestDispatcher("/StaffList.jsp").forward(request, response);
        }
        if (path.startsWith("/StaffList/ds/")) {
            try {
                String s[] = path.split("/");  //StaffList/ds/Staff01
                String staID = s[s.length - 1];  //=> staID = Staff01;
                staffDAO aO = new staffDAO();
                accountDAO aO1 = new accountDAO();
                aO1.delete(staID);
                aO.delete(staID);
                response.sendRedirect("/StaffList/ds");
            } catch (SQLException ex) {
                Logger.getLogger(StaffList.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(StaffList.class.getName()).log(Level.SEVERE, null, ex);
            }

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
        // method Create

        if (request.getParameter("btnAddNew") != null) {
            try {
                String staffID = request.getParameter("txtStaffID");
                String fullname = request.getParameter("txtFullname");
                String txtEmail = request.getParameter("txtEmail");
                String txtNumber = request.getParameter("txtNumber");
                String txtdes = request.getParameter("txtdes");

                staffDAO stadao = new staffDAO();
                StaffAccount addSt = stadao.add(new StaffAccount(staffID, fullname, txtEmail, Integer.parseInt(txtNumber), txtdes));
                if (addSt != null) {
                    accountDAO aDao = new accountDAO();
                    account updateRole = aDao.updateRoleUser("Staff", staffID);
                    if (updateRole != null) {
                        response.sendRedirect("/StaffList/ds");
                    }
                } else {

                }
            } catch (SQLException ex) {
                Logger.getLogger(StaffList.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(StaffList.class.getName()).log(Level.SEVERE, null, ex);
            }

        }

        //Edit metthod
        if (request.getParameter("btnUpdate") != null) {
            try {
                String staffID = request.getParameter("txtStaffID");
                String fullname = request.getParameter("txtFullname");
                String txtEmail = request.getParameter("txtEmail");
                String txtNumber = request.getParameter("txtNumber");
                String txtdes = request.getParameter("txtdes");
                staffDAO stadao = new staffDAO();
                StaffAccount addSt = stadao.updateStaff(new StaffAccount(staffID, fullname, txtEmail, Integer.parseInt(txtNumber), txtdes));
                if (addSt != null) {
                    response.sendRedirect("/StaffList/ds");
                } else {
                    response.sendRedirect("/StaffList/ds");
                }
            } catch (SQLException ex) {
                Logger.getLogger(StaffList.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(StaffList.class.getName()).log(Level.SEVERE, null, ex);
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
