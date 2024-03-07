/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Detail_Order;
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
public class Detail_OrderDAO {

    private Connection conn = null;

    public Detail_OrderDAO() throws SQLException, ClassNotFoundException {
        conn = DB.DbConnection.getConnection();
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        String sql = "SELECT * FROM Detail_Order";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(Detail_OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }

    public ResultSet getAllFromOrderID(String OrderID) {
        ResultSet rs = null;
        String sql = "SELECT * FROM Detail_Order WHERE OrderID=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, OrderID);

            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(Detail_OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }
    
    public ResultSet getAllFromProID(String ProID) {
        ResultSet rs = null;
        String sql = "SELECT * FROM Detail_Order WHERE ProID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, ProID);

            rs = ps.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }
    
    public Detail_Order getOrder(String id) {
        Detail_Order o = null;
        String sql = "SELECT * FROM Detail_Order WHERE OrderID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                o = new Detail_Order(id, rs.getString("ProID"), rs.getInt("Quality"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(Detail_OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return o;
    }
    
    public int add(Detail_Order o) {
        int result = 0;
        String sql = "INSERT INTO Detail_Order VALUES(?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, o.getOrderID());
            ps.setString(2, o.getProID());
            ps.setInt(3, o.getQuality());

            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Detail_OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public int delete(String id) {
        int result = 0;
        String sql = "DELETE FROM Detail_Order WHERE OrderID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);

            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Detail_OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }
    
    public int deleteByProID(String ProID) {
        int result = 0;
        String sql = "DELETE FROM Detail_Order WHERE ProID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, ProID);

            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Detail_OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public int update(Detail_Order o) {
        int result = 0;
        String sql = "UPDATE Detail_Order SET ProID=?, Quality=? WHERE OrderID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, o.getProID());
            ps.setInt(2, o.getQuality());
            ps.setString(3, o.getOrderID());

            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Detail_OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public int getTotalOrderCount(String id) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM Detail_Order WHERE OrderID=?");
            ps.setString(1, id);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Detail_OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }
}
