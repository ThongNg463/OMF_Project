/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.StaffAccount;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tvmph
 */
public class staffDAO {

    private Connection conn = null;

    public staffDAO() throws SQLException, ClassNotFoundException {
        conn = DB.DbConnection.getConnection();
    }

    public StaffAccount getStaff(String staffID) {
        StaffAccount staff = null;
        String sql = "SELECT * FROM StaffAccount WHERE StaffID=?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, staffID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                staff = new StaffAccount(rs.getString("StaffID"), rs.getString("Fullname"), rs.getString("Mail"), rs.getInt("Phone"), rs.getString("Description"));
            }

        } catch (SQLException ex) {
            Logger.getLogger(staffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return staff;
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM StaffAccount");
        } catch (SQLException ex) {
            Logger.getLogger(staffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public void delete(String staff) {

        try {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM StaffAccount Where StaffID =?");
            ps.setString(1, staff);
            ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(staffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public StaffAccount add(StaffAccount account) {
        int count = 0;
        try {

            PreparedStatement ps = conn.prepareStatement("INSERT INTO StaffAccount VALUES (?,?,?,?,?)");
            ps.setString(1, account.getStaffID());
            ps.setString(2, account.getFullname());
            ps.setString(3, account.getMail());
            ps.setInt(4, account.getPhone());
            ps.setString(5, account.getDescription());
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(staffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count == 0 ? null : account;

    }

    public StaffAccount updateStaff(StaffAccount account) {
        int count = 0;
        try {

            PreparedStatement ps = conn.prepareStatement("update StaffAccount set Fullname=?, Mail=?, Phone=?,[Description]=? where StaffID=?");
            ps.setString(1, account.getFullname());
            ps.setString(2, account.getMail());
            ps.setInt(3, account.getPhone());
            ps.setString(4, account.getDescription());
            ps.setString(5, account.getStaffID());
            count = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(staffDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count == 0 ? null : account;

    }

    public boolean addStaff(StaffAccount staff) {
        String sql = "INSERT INTO StaffAccount (StaffID, Fullname, Mail, Phone) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, staff.getStaffID());
            ps.setString(2, staff.getFullname());
            ps.setString(3, staff.getMail());
            ps.setInt(4, staff.getPhone());
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException ex) {
            Logger.getLogger(staffDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

//    public boolean deleteStaff(String staffID) {
//        String sql = "DELETE FROM StaffAccount WHERE StaffID=?";
//        try {
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ps.setString(1, staffID);
//            int result = ps.executeUpdate();
//            return result > 0;
//        } catch (SQLException ex) {
//            Logger.getLogger(staffDAO.class.getName()).log(Level.SEVERE, null, ex);
//            return false;
//        }
//    }
}
