/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author mthon
 */
public class StaffAccount {
    private String StaffID;
    private String Fullname;
    private String Mail;
    private int  Phone;

    public StaffAccount(String StaffID, String Fullname, String Mail, int Phone) {
        this.StaffID = StaffID;
        this.Fullname = Fullname;
        this.Mail = Mail;
        this.Phone = Phone;
    }

    public String getStaffID() {
        return StaffID;
    }

    public void setStaffID(String StaffID) {
        this.StaffID = StaffID;
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

    public int getPhone() {
        return Phone;
    }

    public void setPhone(int Phone) {
        this.Phone = Phone;
    }
    
    
}
