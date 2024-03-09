/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Timestamp;

/**
 *
 * @author Admin
 */
public class Orders {
    private String OrderID;
    private String UserID;
    private String StaffID;
    private String Status;
    private float TotalPrice;
    private String VoucherID;
    private Timestamp OrderDate;

    public Orders() {
    }

    public Orders(String OrderID, String UserID, String StaffID, String Status, float TotalPrice, String VoucherID, Timestamp OrderDate) {
        this.OrderID = OrderID;
        this.UserID = UserID;
        this.StaffID = StaffID;
        this.Status = Status;
        this.TotalPrice = TotalPrice;
        this.VoucherID = VoucherID;
        this.OrderDate = OrderDate;
    }

    public String getOrderID() {
        return OrderID;
    }

    public void setOrderID(String OrderID) {
        this.OrderID = OrderID;
    }

    public String getUserID() {
        return UserID;
    }

    public void setUserID(String UserID) {
        this.UserID = UserID;
    }

    public String getStaffID() {
        return StaffID;
    }

    public void setStaffID(String StaffID) {
        this.StaffID = StaffID;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public float getTotalPrice() {
        return TotalPrice;
    }

    public void setTotalPrice(float TotalPrice) {
        this.TotalPrice = TotalPrice;
    }

    public String getVoucherID() {
        return VoucherID;
    }

    public void setVoucherID(String VoucherID) {
        this.VoucherID = VoucherID;
    }

    public Timestamp getOrderDate() {
        return OrderDate;
    }

    public void setOrderDate(Timestamp OrderDate) {
        this.OrderDate = OrderDate;
    }


}
