/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Cart;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author mthon
 */
public class CartDAO {

    private Connection conn = null;

    public CartDAO() throws SQLException, ClassNotFoundException {
        conn = DB.DbConnection.getConnection();
    }

    public ResultSet getCartByUsername(String Username) {
        ResultSet rs = null;
        try {
            String sql = "SELECT * FROM Cart WHERE Username=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, Username);

            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(Detail_OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return rs;
    }

    public int add(Cart c) {
        int result = 0;
        String sql = "INSERT INTO Cart VALUES(?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, c.getCartID());
            ps.setString(2, c.getUsername());
            ps.setString(3, c.getProID());
            ps.setInt(4, c.getQuality());

            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Detail_OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public int increase(Cart c) {
        int result = 0;
        try {
            String sql = "SELECT * FROM Cart WHERE CartID=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, c.getCartID());
            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                add(new Cart(c.getCartID(), c.getUsername(), c.getProID(), c.getQuality()));
            } else {
                int _quality = rs.getInt("Quality") + 1;
                sql = "UPDATE Cart SET Quality=? WHERE Username=? AND ProID=?";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, _quality);
                ps.setString(2, c.getUsername());
                ps.setString(3, c.getProID());

                result = ps.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public int decrease(Cart c) {
        int result = 0;
        try {
            String sql = "SELECT * FROM Cart WHERE CartID=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, c.getCartID());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int _quality = rs.getInt("Quality") - 1;
                if (_quality < 1) {
                    delete(c.getCartID());
                } else {
                    sql = "UPDATE Cart SET Quality=? WHERE Username=? AND ProID=?";
                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, _quality);
                    ps.setString(2, c.getUsername());
                    ps.setString(3, c.getProID());

                    result = ps.executeUpdate();
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public int delete(String id) {
        int result = 0;
        String sql = "DELETE FROM Cart WHERE CartID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);

            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Detail_OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }
    
    public int getTotalCartCount(String Username) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM Cart WHERE Username=?");
            ps.setString(1, Username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    } 

}
