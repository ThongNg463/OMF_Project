/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.productDAO;
import Models.Products;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class productController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Process request logic here if needed
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getRequestURI();

        if (path.endsWith("/product/productList")) {
            String type = request.getParameter("type");
            int minPrice = Integer.parseInt(request.getParameter("minPrice"));
            int maxPrice = Integer.parseInt(request.getParameter("maxPrice"));
            String searchName = request.getParameter("searchName");

            productDAO dao = new productDAO(); // Adjust DAO initialization based on your DAO class name
            List<Products> productList;

            if (type != null && !type.isEmpty()) {
                productList = dao.getProductByType(type);
            } else if (searchName != null && !searchName.isEmpty()) {
                productList = dao.getProductByName(searchName);
            } else {
                productList = dao.getAllProducts();
            }

            request.setAttribute("productList", productList);
            request.getRequestDispatcher("/shopList.jsp").forward(request, response);
        } else if (path.endsWith("/product/productDetail")) {
            String productId = request.getParameter("productId");

            productDAO dao = new productDAO(); // Adjust DAO initialization based on your DAO class name
            Products product = dao.getProductDetail(productId);

            request.setAttribute("product", product);
            request.getRequestDispatcher("/productDetail.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}