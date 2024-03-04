package DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Models.Products;
import DB.DbConnection;

public class ProductDAO {

    private Connection connection;
    private PreparedStatement ps;
    private ResultSet rs;

    public ProductDAO() {
        connection = DB.DbConnection.getConnection();
    }

    public Products getProductById(String productId) {
        Products product = null;
        String sql = "SELECT * FROM Products WHERE ProID = ?";

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, productId);
            rs = ps.executeQuery();

            if (rs.next()) {
                product = new Products();
                product.setProID(rs.getString("ProID"));
                product.setProStock(rs.getInt("ProStock"));
                product.setProName(rs.getString("ProName"));
                product.setProPic(rs.getString("ProPic"));
                product.setProDes(rs.getString("ProDes"));
                product.setProPrice(rs.getString("ProPrice"));
                product.setProType(rs.getString("ProType"));
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return product;
    }

    public List<Products> getAllProducts() {
        List<Products> products = new ArrayList<>();
        String sql = "SELECT * FROM Products";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Products product = new Products();
                product.setProID(rs.getString("ProID"));
                product.setProStock(rs.getInt("ProStock"));
                product.setProName(rs.getString("ProName"));
                product.setProPic(rs.getString("ProPic"));
                product.setProDes(rs.getString("ProDes"));
                product.setProPrice(rs.getString("ProPrice"));
                product.setProType(rs.getString("ProType"));

                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean addNewProduct(Products newProduct) {
        String insertProductSql = "INSERT INTO Products (ProID, ProName, ProStock, ProPrice, ProDes, ProType, ProPic) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            connection.setAutoCommit(false);

            // Insert product
            PreparedStatement psProduct = connection.prepareStatement(insertProductSql);
            psProduct.setString(1, newProduct.getProID());
            psProduct.setString(2, newProduct.getProName());
            psProduct.setInt(3, newProduct.getProStock());
            psProduct.setString(4, newProduct.getProPrice());
            psProduct.setString(5, newProduct.getProDes());
            psProduct.setString(6, newProduct.getProType());
            psProduct.setString(7, newProduct.getProPic());
            psProduct.executeUpdate();
            psProduct.close();

            connection.commit(); // Confirm and save changes to the database
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }

    public boolean updateProduct(Products updatedProduct) {
        String updateProductSql = "UPDATE Products SET ProName = ?, ProStock = ?, ProPrice = ?, ProDes = ?, ProType = ?, ProPic = ? WHERE ProID = ?";

        try {
            connection.setAutoCommit(false);

            // Update product
            PreparedStatement psUpdateProduct = connection.prepareStatement(updateProductSql);
            psUpdateProduct.setString(1, updatedProduct.getProName());
            psUpdateProduct.setInt(2, updatedProduct.getProStock());
            psUpdateProduct.setString(3, updatedProduct.getProPrice());
            psUpdateProduct.setString(4, updatedProduct.getProDes());
            psUpdateProduct.setString(5, updatedProduct.getProType());
            psUpdateProduct.setString(6, updatedProduct.getProPic());
            psUpdateProduct.setString(7, updatedProduct.getProID());
            psUpdateProduct.executeUpdate();
            psUpdateProduct.close();

            connection.commit(); // Confirm and save changes to the database
            return true;
        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            ex.printStackTrace();
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return false;
    }

    public boolean deleteProduct(String productId) {
        String deleteSql = "DELETE FROM Products WHERE ProID = ?";

        try {
            PreparedStatement psDelete = connection.prepareStatement(deleteSql);
            psDelete.setString(1, productId);
            int rowsAffected = psDelete.executeUpdate();
            psDelete.close();

            if (rowsAffected > 0) {
                return true; // Product was successfully deleted
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return false; // Failed to delete the product
    }
}
