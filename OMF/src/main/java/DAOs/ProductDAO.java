package DAOs;

import Models.Products;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ACER
 */
public class ProductDAO {

    private Connection conn;

    public ProductDAO() throws ClassNotFoundException, SQLException {
        conn = DB.DbConnection.getConnection();
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        String sql = "select * from Products";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public Products getProducts(String id) {
        Products p = null;
        String sql = "SELECT * FROM Products WHERE ProID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                p = new Products(rs.getString("ProID"), rs.getInt("ProStock"), rs.getString("ProName"), rs.getString("ProPic"), rs.getString("ProDes"), rs.getFloat("ProPrice"), rs.getString("ProType"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return p;
    }

    public Products getProductName(String id) {
        Products p = null;
        String sql = "SELECT * FROM Products WHERE ProID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                p = new Products(rs.getString("ProID"), rs.getInt("ProStock"), rs.getString("ProName"), rs.getString("ProPic"), rs.getString("ProDes"), rs.getFloat("ProPrice"), rs.getString("ProType"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return p;
    }

    public int delete(String id) {
        int result = 0;
        String sql = "DELETE FROM Products WHERE ProID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public int update(Products p) {
        int result = 0;
        String sql = "UPDATE Products SET ProStock=?, ProName=?, ProPic=?, ProDes=?, ProPrice=? , ProType=?  WHERE ProID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, p.getProStock());
            ps.setString(2, p.getProName());
            ps.setString(3, p.getProPic());
            ps.setString(4, p.getProDes());
            ps.setFloat(5, p.getProPrice());
            ps.setString(6, p.getProType());
            ps.setString(7, p.getProID());
            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public int add(Products p) {
        int result = 0;
        String sql = "INSERT INTO Products VALUES(?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, p.getProID());
            ps.setInt(2, p.getProStock());
            ps.setString(3, p.getProName());
            ps.setString(4, p.getProPic());
            ps.setString(5, p.getProDes());
            ps.setFloat(6, p.getProPrice());
            ps.setString(7, p.getProType());

            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public int getTotalProductsCount() {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("SELECT COUNT(*) FROM Products");
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}
