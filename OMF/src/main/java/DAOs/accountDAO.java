/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.UserAccount;
import Models.account;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;
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
                a = new account(rs.getString("username"), rs.getString("password"), rs.getString("role"), rs.getString("accpic"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(accountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return a;
    }
   
    public ResultSet getRoleUser() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from Accounts where Role ='User'");
        } catch (SQLException ex) {
            Logger.getLogger(accountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public account updateRoleUser(String role, String username) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("update Accounts set [Role] =? where Username=?");
            ps.setString(1, role);
            ps.setString(2, username);
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(accountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count == 0 ? null : new account("1", "1", "Staff", "");
    }

    public void delete(String staff) {

        try {
            PreparedStatement ps = conn.prepareStatement("delete from Accounts where Username=?");
            ps.setString(1, staff);
            ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(staffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
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
            ps.setString(3, "User");
            ps.setString(4, "https://i.imgur.com/mCHMpLT.png");
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
            Logger.getLogger(accountDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                String phone = rs.getString("Phone");
                float wallet = rs.getFloat("Wallet");
                String voucherID = rs.getString("VoucherID");

                // Create a UserAccount object with the retrieved data
                userAccount = new UserAccount(userID, fullname, mail, phone, wallet, voucherID);
            }

            // Close resources
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(accountDAO.class.getName()).log(Level.SEVERE, null, ex);
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
                Logger.getLogger(accountDAO.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(accountDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

}
