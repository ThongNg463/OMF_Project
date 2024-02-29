/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Products;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author namti
 */
public class productDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public productDAO() {
        try {
            conn = DB.DbConnection.getConnection();
        } catch (ClassNotFoundException | SQLException e) {
            // Handle the exception or log it accordingly
            e.printStackTrace();
        }
    }

    public List<Products> getAllProducts() {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT * FROM Products";

        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Products product = new Products(
                        rs.getString("ProID"),
                        rs.getInt("ProStock"),
                        rs.getString("ProName"),
                        rs.getString("ProPic"), // Assuming the image URL is stored in the ProPic column
                        rs.getString("ProDes"),
                        String.valueOf(rs.getDouble("ProPrice")),
                        null // Adjust as needed for product type
                );

                list.add(product);
            }
        } catch (SQLException e) {
            // Handle the SQL exception or log it accordingly
            e.printStackTrace();
        }

        return list;
    }

    public List<Products> getProductByType(String productType) {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE ProType = ?";

        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, productType);
            rs = ps.executeQuery();

            while (rs.next()) {
                Products product = new Products(
                        rs.getString("ProID"),
                        rs.getInt("ProStock"),
                        rs.getString("ProName"),
                        rs.getString("ProPic"), // Assuming the image URL is stored in the ProPic column
                        rs.getString("ProDes"),
                        String.valueOf(rs.getDouble("ProPrice")),
                        rs.getString("ProType")
                );

                list.add(product);
            }
        } catch (SQLException e) {
            // Handle the SQL exception or log it accordingly
            e.printStackTrace();
        }

        return list;
    }

    public List<Products> getProductByPrice(int minPrice, int maxPrice) {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE ProPrice >= ? AND ProPrice <= ?";

        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, minPrice);
            ps.setInt(2, maxPrice);
            rs = ps.executeQuery();

            while (rs.next()) {
                Products product = new Products(
                        rs.getString("ProID"),
                        rs.getInt("ProStock"),
                        rs.getString("ProName"),
                        rs.getString("ProPic"), // Assuming the image URL is stored in the ProPic column
                        rs.getString("ProDes"),
                        String.valueOf(rs.getDouble("ProPrice")),
                        null // Adjust as needed for product type
                );

                list.add(product);
            }
        } catch (SQLException e) {
            // Handle the SQL exception or log it accordingly
            e.printStackTrace();
        }

        return list;
    }

    public List<Products> getProductByPriceAfterSale(int minPrice, int maxPrice) {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE (ProPrice - (ProPrice * discount / 100)) >= ? AND (ProPrice - (ProPrice * discount / 100)) <= ?";

        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, minPrice);
            ps.setInt(2, maxPrice);
            rs = ps.executeQuery();

            while (rs.next()) {
                Products product = new Products(
                        rs.getString("ProID"),
                        rs.getInt("ProStock"),
                        rs.getString("ProName"),
                        rs.getString("ProPic"),
                        rs.getString("ProDes"),
                        String.valueOf(rs.getDouble("ProPrice")),
                        rs.getString("ProType")
                );
                list.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Phương thức thêm sản phẩm mới
    public boolean addNewProduct(Products newProduct) {
        String insertProductSql = "INSERT INTO Products (ProID, ProName, ProStock, ProPrice, ProDes, ProPic, ProType) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            conn.setAutoCommit(false);

            PreparedStatement psProduct = conn.prepareStatement(insertProductSql);
            psProduct.setString(1, newProduct.getProID());
            psProduct.setString(2, newProduct.getProName());
            psProduct.setInt(3, newProduct.getProStock());
            psProduct.setDouble(4, Double.parseDouble(newProduct.getProPrice()));
            psProduct.setString(5, newProduct.getProDes());
            psProduct.setString(6, newProduct.getProPic());
            psProduct.setString(7, newProduct.getProType());
            psProduct.executeUpdate();
            psProduct.close();

            conn.commit();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            try {
                conn.rollback();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return false;
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    //code delete ở đây chuyền id của sản phẩm từ cái sản phẩm m click vào đó
    public boolean deleteProduct(String productId) {
        String updateStatusSql = "UPDATE Products SET status = ? WHERE ProID = ?";

        try {
            PreparedStatement psUpdateStatus = conn.prepareStatement(updateStatusSql);
            psUpdateStatus.setBoolean(1, false);
            psUpdateStatus.setString(2, productId);
            int rowsAffected = psUpdateStatus.executeUpdate();
            psUpdateStatus.close();

            if (rowsAffected > 0) {
                return true; // Product has been successfully deleted
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return false; // Deleting product unsuccessful
    }
    //sửa sản phẩm 

    public boolean updateProduct(Products updatedProduct) {
        String updateProductSql = "UPDATE Products SET ProName = ?, ProStock = ?, ProPrice = ?, ProDes = ?, ProPic = ?, ProType = ? WHERE ProID = ?";

        try {
            conn.setAutoCommit(false);

            // Update product
            PreparedStatement psUpdateProduct = conn.prepareStatement(updateProductSql);
            psUpdateProduct.setString(1, updatedProduct.getProName());
            psUpdateProduct.setInt(2, updatedProduct.getProStock());
            psUpdateProduct.setDouble(3, Double.parseDouble(updatedProduct.getProPrice()));
            psUpdateProduct.setString(4, updatedProduct.getProDes());
            psUpdateProduct.setString(5, updatedProduct.getProPic());
            psUpdateProduct.setString(6, updatedProduct.getProType());
            psUpdateProduct.setString(7, updatedProduct.getProID());
            psUpdateProduct.executeUpdate();
            psUpdateProduct.close();

            conn.commit(); // Confirm and save changes to the database
            return true;
        } catch (SQLException ex) {
            // Handle the SQL exception or log it accordingly
            ex.printStackTrace();
            try {
                conn.rollback(); // Rollback changes if an exception occurs
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return false;
        } finally {
            try {
                conn.setAutoCommit(true); // Restore auto-commit mode
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public Products getProductDetail(String productId) {
        String selectProductSql = "SELECT * FROM Products WHERE ProID = ?";

        try {
            // Retrieve product information
            PreparedStatement psProduct = conn.prepareStatement(selectProductSql);
            psProduct.setString(1, productId);
            ResultSet productResult = psProduct.executeQuery();

            if (productResult.next()) {
                Products product = new Products(
                        productResult.getString("ProID"),
                        productResult.getInt("ProStock"),
                        productResult.getString("ProName"),
                        productResult.getString("ProPic"),
                        productResult.getString("ProDes"),
                        String.valueOf(productResult.getDouble("ProPrice")),
                        productResult.getString("ProType")
                );
                return product;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return null; // Product not found
    }

    public List<Products> getProductByName(String search) {
        List<Products> list = new ArrayList<>();

        ResultSet rs = null;
        String sql = "SELECT * FROM Products WHERE ProName LIKE '%" + search + "%'";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Products product = new Products(
                        rs.getString("ProID"),
                        rs.getInt("ProStock"),
                        rs.getString("ProName"),
                        "", // Initialize with an empty string
                        rs.getString("ProDes"),
                        String.valueOf(rs.getDouble("ProPrice")),
                        rs.getString("ProType")
                );

                list.add(product);
            }
        } catch (SQLException ex) {
            Logger.getLogger(productDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            // Close ResultSet and PreparedStatement here
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public boolean updateProductQuantity(String[] productIds, int[] proStocks) {
        try {
            String updateProductQuery = "UPDATE Products SET ProStock = ? WHERE ProID = ?";
            PreparedStatement updateProductStatement = conn.prepareStatement(updateProductQuery);

            for (int i = 0; i < productIds.length; i++) {
                String productId = productIds[i];
                int proStock = proStocks[i];

                // Update product quantity
                updateProductStatement.setInt(1, proStock);
                updateProductStatement.setString(2, productId);
                updateProductStatement.addBatch();
            }

            // Execute batch update
            int[] rowsAffected = updateProductStatement.executeBatch();

            // Close PreparedStatement
            updateProductStatement.close();

            // Check if any row was affected
            for (int row : rowsAffected) {
                if (row == PreparedStatement.EXECUTE_FAILED) {
                    return false; // If any row failed to update, return false
                }
            }

            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
        // Create a DAO object
        productDAO dao = new productDAO();

        String[] productIds = {"nhuy2222", "P123456"};
        int[] proStocks = {10, 10}; // Assuming proStocks represents the quantities

        // Call the updateProductQuantity method and check the return value
        boolean updateResults = dao.updateProductQuantity(productIds, proStocks);

        if (updateResults) {
            System.out.println("Successfully updated product quantities.");
        } else {
            System.out.println("Failed to update product quantities.");
        }
    }
}
