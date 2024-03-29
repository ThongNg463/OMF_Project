/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Orders;
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
public class OrdersDAO {

    private Connection conn = null;

    public OrdersDAO() throws SQLException, ClassNotFoundException {
        conn = DB.DbConnection.getConnection();
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        String sql = "SELECT * FROM Orders";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }

    public ResultSet getAllFromUserID(String userID) {
        ResultSet rs = null;
        String sql = "SELECT * FROM Orders WHERE UserID=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userID);

            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }

    public Orders getOrder(String id) {
        Orders o = null;
        String sql = "SELECT * FROM Orders WHERE OrderID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                o = new Orders(id, rs.getString("UserID"), rs.getString("StaffID"), rs.getString("Status"), rs.getFloat("TotalPrice"), rs.getString("VoucherID"),rs.getInt("VoucherPercent") ,rs.getTimestamp("OrderDate"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return o;
    }
    
    public int add(Orders o) {
        int result = 0;
        String sql = "INSERT INTO Orders VALUES(?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, o.getOrderID());
            ps.setString(2, o.getUserID());
            ps.setString(3, o.getStaffID());
            ps.setString(4, o.getStatus());
            ps.setFloat(5, o.getTotalPrice());
            ps.setString(6, o.getVoucherID());
            ps.setInt(7, o.getVoucherPercent());
            ps.setTimestamp(8, o.getOrderDate());

            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public int delete(String id) {
        int result = 0;
        String sql = "DELETE FROM Orders WHERE OrderID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);

            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public int update(Orders o) {
        int result = 0;
        String sql = "UPDATE Orders SET UserID=?, StaffID=?, Status=?, TotalPrice=?, VoucherID=?, VoucherPercent=?, OrderDate=? WHERE OrderID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);   
            ps.setString(1, o.getUserID());
            ps.setString(2, o.getStaffID());
            ps.setString(3, o.getStatus());
            ps.setFloat(4, o.getTotalPrice());
            ps.setString(5, o.getVoucherID());
            ps.setInt(6, o.getVoucherPercent());
            ps.setTimestamp(7, o.getOrderDate());
            ps.setString(8, o.getOrderID());

            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }
    
    public int getTotalOrderCount() {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("SELECT COUNT(*) FROM Orders");
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
