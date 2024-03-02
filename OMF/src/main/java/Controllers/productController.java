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
        } else {
            listProducts(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        addProduct(request, response);
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
            response.sendRedirect("success.jsp");
        } else {
            // Redirect to an error page or display an error message
            response.sendRedirect("error.jsp");
        }
    }
}
