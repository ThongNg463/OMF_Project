/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.UserAccount;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
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
                ua = new UserAccount(rs.getString("UserID"), rs.getString("Fullname"), rs.getString("Mail"), rs.getString("Address"), rs.getString("City"), rs.getString("Phone"), rs.getFloat("Wallet"));
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
        String sql = "UPDATE UserAccount SET Fullname=?, Mail=?, Address=?, City=?, Phone=?, Wallet=? WHERE UserID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, ua.getFullname());
            ps.setString(2, ua.getMail());
            ps.setString(3, ua.getAddress());
            ps.setString(4, ua.getCity());
            ps.setString(5, ua.getPhone());
            ps.setFloat(6, ua.getWallet());
            ps.setString(7, ua.getUserID());
            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public int add(UserAccount ua) {
        int result = 0;
        String sql = "INSERT INTO UserAccount VALUES(?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, ua.getUserID());
            ps.setString(2, ua.getFullname());
            ps.setString(3, ua.getMail());
            ps.setString(4, ua.getAddress());
            ps.setString(5, ua.getPhone());
            ps.setString(6, ua.getCity());
            ps.setFloat(7, ua.getWallet());
            
            result = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrdersDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    public String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    public String getFullnameByEmail(String email) throws ClassNotFoundException {
        String fullname = null;
        String query = "SELECT fullname FROM UserAccount WHERE Mail = ?";
        try ( Connection conn = DB.DbConnection.getConnection();  PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                fullname = resultSet.getString("fullname");
            }
        } catch (SQLException e) {
        }
        return fullname;
    }

    public UserAccount getCustomerByEmail(String email) throws ClassNotFoundException {
        String sql = "SELECT * FROM UserAccount WHERE Mail = ?";
        UserAccount userAccount = null;

        try {

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Retrieve data from the result set
                String userID = rs.getString("UserID"); // New field
                String fullname = rs.getString("Fullname");
                String mail = rs.getString("Mail");
                String address = rs.getString("Address");
                String city = rs.getString("City");
                String phone = rs.getString("Phone");
                float wallet = rs.getFloat("Wallet");

                // Create a UserAccount object with the retrieved data
                userAccount = new UserAccount(userID, fullname, mail, address, city, phone, wallet);
            }

            // Close resources
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return userAccount;
    }

    public boolean changePasswordByEmail(String email, String pass) {
        String updateAccountsSql = "UPDATE Accounts SET Password = ? WHERE Username IN (SELECT UserID FROM UserAccount WHERE Mail = ?)";

        try {

            MessageDigest md = null;
            try {
                md = MessageDigest.getInstance("MD5");
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
            md.update(pass.getBytes());
            byte[] bytes = md.digest();
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < bytes.length; i++) {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            String passwordHash = sb.toString();

            // Update password in Accounts table
            PreparedStatement updateAccountsStmt = conn.prepareStatement(updateAccountsSql);
            updateAccountsStmt.setString(1, passwordHash);
            updateAccountsStmt.setString(2, email);
            int accountsUpdateResult = updateAccountsStmt.executeUpdate();
            updateAccountsStmt.close();

            // Close connection
            conn.close();

            // Return true if the update was successful
            return accountsUpdateResult > 0;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean signupUserAccount(String username, String fullname, String email, String phone) {
        String sql = "INSERT INTO UserAccount (UserID, Fullname, mail, phone) VALUES (?, ?, ?, ?)";

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
}
