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

    public Products getProductById(String ProID) {
        Products product = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select * from Products where ProID=?");
            preparedStatement.setString(1, ProID);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                product = new Products(
                        rs.getString("ProID"),
                        rs.getInt("ProStock"),
                        rs.getString("ProName"),
                        rs.getString("ProPic"),
                        rs.getString("ProDes"),
                        rs.getString("ProPrice"),
                        rs.getString("ProType")
                );
            }
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

    public void updateProduct(Products product) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("update Products set ProStock=?, ProName=?, ProPic=?, ProDes=?, ProPrice=?, ProType=? where ProID=?");
            preparedStatement.setInt(1, product.getProStock());
            preparedStatement.setString(2, product.getProName());
            preparedStatement.setString(3, product.getProPic());
            preparedStatement.setString(4, product.getProDes());
            preparedStatement.setString(5, product.getProPrice());
            preparedStatement.setString(6, product.getProType());
            preparedStatement.setString(7, product.getProID());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(String ProID) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("delete from Products where ProID=?");
            preparedStatement.setString(1, ProID);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
