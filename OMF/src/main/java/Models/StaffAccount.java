/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Kara
 */
public class StaffAccount {
    private String StaffID;
    private String Fullname;
    private String Mail;
    private String Phone;
    
    
    public StaffAccount(String UserID, String Fullname, String Mail, String Phone ) {
        this.StaffID = UserID;
        this.Fullname = Fullname;
        this.Mail = Mail;
        this.Phone = Phone;

    }

    public StaffAccount() {
    }

    public String getStaffID() {
        return StaffID;
    }

    public void setStaffID(String UserID) {
        this.StaffID = UserID;
    }

    public String getFullname() {
        return Fullname;
    }

    public void setFullname(String Fullname) {
        this.Fullname = Fullname;
    }

    public String getMail() {
        return Mail;
    }

    public void setMail(String Mail) {
        this.Mail = Mail;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }
    
    
}
