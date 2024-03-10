/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Products;
import Models.UserAccount;
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
public class UserAccountDAO {

    private Connection conn = null;

    public UserAccountDAO() throws SQLException, ClassNotFoundException {
        conn = DB.DbConnection.getConnection();
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        String sql = "select * from UserAccount";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    public UserAccount getUserAccount(String id) {
        UserAccount ua = null;
        String sql = "SELECT * FROM UserAccount WHERE UserID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ua = new UserAccount(rs.getString("UserID"), rs.getString("Fullname"), rs.getString("Mail"), rs.getString("Phone"), rs.getFloat("Wallet"), rs.getString("VoucherID"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ua; 
    }
    
    public int delete(String id) {
        int result = 0;
        String sql = "DELETE FROM UserAccount WHERE UserID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }
    
    public int update(UserAccount ua) {
        int result = 0;
        String sql = "UPDATE UserAccount SET Fullname=?, Mail=?, Phone=?, Wallet=?, VouncherID=?  WHERE UserID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, ua.getFullname());           
            ps.setString(2, ua.getMail());
            ps.setString(3, ua.getPhone());
            ps.setFloat(4, ua.getWallet());
            ps.setString(5, ua.getVouncherID());
            ps.setString(6, ua.getUserID());
            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }
    
    public int add(UserAccount ua) {
        int result = 0;
        String sql = "INSERT INTO UserAccount VALUES(?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, ua.getUserID());
            ps.setString(2, ua.getFullname());           
            ps.setString(3, ua.getMail());
            ps.setString(4, ua.getPhone());
            ps.setFloat(5, ua.getWallet());
            ps.setString(6, ua.getVouncherID());
            
            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }
}
