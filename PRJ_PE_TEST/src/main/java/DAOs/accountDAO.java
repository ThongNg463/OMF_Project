/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.account;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
public class accountDAO {

    private Connection conn = null;

    public accountDAO() throws SQLException, ClassNotFoundException {
        conn = DB.DbConnection.getConnection();
    }

    public account getAccount(String username) {
        account a = null;
        String sql = "SELECT * FROM Accounts WHERE Username=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                a = new account(rs.getString("username"), rs.getString("password"), rs.getString("role"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(accountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return a;
    }

    public boolean login(account tk) throws SQLException {
        String sql = "Select * from Accounts where Username=? and Password=?";
        ResultSet rs = null;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, tk.getUsername());
            ps.setString(2, getMd5(tk.getPassword()));
            //ps.setString(3, tk.getRole());
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(accountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs.next();
    }

    private String getMd5(String password) {

        try {
            // Static getInstance method is called with hashing MD5
            MessageDigest md = MessageDigest.getInstance("MD5");
            // input string converted to byte value array
            byte[] messageDigest = md.digest(password.getBytes());
            // Convert byte array into signum representation
            BigInteger no = new BigInteger(1, messageDigest);
            // Convert message digest into hex value
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean signup(String username, String password) {
        String sql = "INSERT INTO Accounts (Username, Password, Role) VALUES (?, ?, ?)";
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
            ps.setString(3, "User");
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            Logger.getLogger(accountDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } catch (NoSuchAlgorithmException e) {
            // Handle the error in case MD5 algorithm is not available
            Logger.getLogger(accountDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
    }

    public boolean checkUserRole(account tk) throws SQLException {
        String sql = "Select * from Accounts where Username=? and Password=? and Role=?";
        ResultSet rs = null;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, tk.getUsername());
            ps.setString(2, getMd5(tk.getPassword()));
            ps.setString(3, tk.getRole());
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(accountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs.next();
    }

    public boolean checkUsernameExists(String username) throws SQLException {
        String sql = "Select * from Accounts where Username=?";
        ResultSet rs = null;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(accountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs.next();
    }

}
