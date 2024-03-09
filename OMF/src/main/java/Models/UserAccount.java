/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author mthon
 */
public class UserAccount {
    private String UserID;
    private String Fullname;
    private String Mail;
    private String Phone;
    private float Wallet;
    private String VoucherID;

    public UserAccount(String UserID, String Fullname, String Mail, String Phone, float Wallet, String VoucherID) {
        this.UserID = UserID;
        this.Fullname = Fullname;
        this.Mail = Mail;
        this.Phone = Phone;
        this.Wallet = Wallet;
        this.VoucherID = VoucherID;
    }

    public String getUserID() {
        return UserID;
    }

    public void setUserID(String UserID) {
        this.UserID = UserID;
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

    public float getWallet() {
        return Wallet;
    }

    public void setWallet(float Wallet) {
        this.Wallet = Wallet;
    }

    public String getVoucherID() {
        return VoucherID;
    }

    public void setVoucherID(String VoucherID) {
        this.VoucherID = VoucherID;
    }
    
    
}
