package Controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import Models.Products;
import DAOs.ProductDAO;

@WebServlet("/ProductController")
public class ProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    public void init() {
        productDAO = new ProductDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();
        if ("/addProduct".equals(action)) {
            // Forward to the AddNewproduct.jsp page
            request.getRequestDispatcher("addProduct.jsp").forward(request, response);

        } else if ("/updateProduct".equals(action)) {
            String productId = request.getParameter("productId");
            Products product = productDAO.getProductById(productId);
            request.setAttribute("product", product);
            request.getRequestDispatcher("updateProduct.jsp").forward(request, response);

        } else {
            listProducts(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action"); // Assuming you pass action as a parameter from the form

        if ("addProduct".equals(action)) {
            addProduct(request, response);
        } else if ("updateProduct".equals(action)) {
            updateProduct(request, response);
        } else if ("deleteProduct".equals(action)) {
            deleteProduct(request, response);
        } else {
            // Handle other actions or provide a default behavior
            response.sendRedirect("erroror.jsp");
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Products> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("productManagement.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get parameters from the form
        String ProID = request.getParameter("ProID");
        String ProName = request.getParameter("ProName");
        int ProStock = Integer.parseInt(request.getParameter("ProStock"));
        String ProPrice = request.getParameter("ProPrice");
        String ProDes = request.getParameter("ProDes");
        String ProType = request.getParameter("ProType");
        String ProPic = request.getParameter("ProPic");

        // Create a new product object
        Products newProduct = new Products(ProID, ProStock, ProName, ProPic, ProDes, ProPrice, ProType);

        // Call the DAO method to add the product
        boolean success = productDAO.addNewProduct(newProduct);

        if (success) {
            // Redirect to a success page or display a success message
            response.sendRedirect("/OMF/productManagement");
        } else {
            // Redirect to an error page or display an error message
            response.sendRedirect("error.jsp");
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get parameters from the form
        String ProID = request.getParameter("ProID");
        String ProName = request.getParameter("ProName");
        String ProStockStr = request.getParameter("ProStock");
        int ProStock = 0; // Default value or you can choose another appropriate default
        if (ProStockStr != null && !ProStockStr.isEmpty()) {
            ProStock = Integer.parseInt(ProStockStr);
        }
        String ProPrice = request.getParameter("ProPrice");
        String ProDes = request.getParameter("ProDes");
        String ProType = request.getParameter("ProType");
        String ProPic = request.getParameter("ProPic");

        // Create a new product object
        Products updatedProduct = new Products(ProID, ProStock, ProName, ProPic, ProDes, ProPrice, ProType);

        // Call the DAO method to update the product
        boolean success = productDAO.updateProduct(updatedProduct);

        if (success) {
            // Redirect to a success page or display a success message
            response.sendRedirect("/OMF/productManagement");
        } else {
            // Redirect to an error page or display an error message
            response.sendRedirect("error.jsp");
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the product ID to delete
        String productId = request.getParameter("productId");

        // Call the DAO method to delete the product
        boolean success = productDAO.deleteProduct(productId);

        if (success) {
            // Redirect to a success page or display a success message
            response.sendRedirect("/OMF/productManagement");
        } else {
            // Redirect to an error page or display an error message
            response.sendRedirect("error.jsp");
        }
    }
}
