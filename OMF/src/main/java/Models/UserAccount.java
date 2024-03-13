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
    private String Address;
    private String City;
    private String Phone;
    private Float Wallet;

    public UserAccount() {
    }

    public UserAccount(String UserID, String Fullname, String Mail, String Address, String City, String Phone, Float Wallet) {
        this.UserID = UserID;
        this.Fullname = Fullname;
        this.Mail = Mail;
        this.Address = Address;
        this.City = City;
        this.Phone = Phone;
        this.Wallet = Wallet;
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

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public String getCity() {
        return City;
    }

    public void setCity(String City) {
        this.City = City;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    public Float getWallet() {
        return Wallet;
    }

    public void setWallet(Float Wallet) {
        this.Wallet = Wallet;
    }

   

    
    
}
