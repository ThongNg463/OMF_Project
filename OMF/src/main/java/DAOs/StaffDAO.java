/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.StaffAccount;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class StaffDAO {

    private Connection conn = null;

    public StaffDAO() throws SQLException, ClassNotFoundException {
        conn = DB.DbConnection.getConnection();
    }

    public ResultSet getAllStaff() {
        ResultSet rs = null;
        String sql = "select * from StaffAccount";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    public StaffAccount getStaffs(String id) {
        StaffAccount s = null;
        String sql = "SELECT * FROM StaffAccount WHERE StaffID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                s = new StaffAccount(rs.getString("StaffID"), rs.getString("Fullname"), rs.getString("Mail"), rs.getString("Phone"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return s;
    }
    
    public boolean AddAccount(String username, String password) {
        String sql = "INSERT INTO Accounts (Username, Password, Role, AccPic) VALUES (?, ?, ?, ?)";
        try {
            // Create MD5 Hash
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(password.getBytes());
            byte[] bytes = md.digest();
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < bytes.length; i++) {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            String passwordHash = sb.toString();

            // Insert the user with the MD5 hash of the password
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, passwordHash);
            ps.setString(3, "Admin");
            ps.setString(4, "https://i.imgur.com/mCHMpLT.png");
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } catch (NoSuchAlgorithmException e) {
            // Handle the error in case MD5 algorithm is not available
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
    }
    
    public boolean AddStaffAccount(String username, String fullname, String email, String phone) {
        String sql = "INSERT INTO StaffAccount (StaffID, Fullname, mail, phone) VALUES (?, ?, ?, ?)";

        try {

            // Prepare the SQL statement
            PreparedStatement stmt = conn.prepareStatement(sql);

            // Set parameters
            stmt.setString(1, username); // UserID
            stmt.setString(2, fullname);
            stmt.setString(3, email);
            stmt.setString(4, phone);

            // Execute the SQL statement
            int rowsInserted = stmt.executeUpdate();

            // Close resources
            stmt.close();
            conn.close();

            // Return true if insertion was successful
            return rowsInserted > 0;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    public int delete(String id) {
        int result = 0;
        String sql = "DELETE FROM StaffAccount WHERE StaffID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }
    
    public boolean checkUsernameExists(String username) throws SQLException {
        String sql = "Select * from Accounts where Username=?";
        ResultSet rs = null;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs.next();
    }
    
}