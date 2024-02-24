/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author mthon
 */
public class Orders {
    private String OrderID;
    private int UserID;
    private int StaffID;
    private String Status;
    private int TotalPrice;
    private String VoucherID;
    private String OrderDate;

    public Orders(String OrderID, int UserID, int StaffID, String Status, int TotalPrice, String VoucherID, String OrderDate) {
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

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
    }

    public int getStaffID() {
        return StaffID;
    }

    public void setStaffID(int StaffID) {
        this.StaffID = StaffID;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public int getTotalPrice() {
        return TotalPrice;
    }

    public void setTotalPrice(int TotalPrice) {
        this.TotalPrice = TotalPrice;
    }

    public String getVoucherID() {
        return VoucherID;
    }

    public void setVoucherID(String VoucherID) {
        this.VoucherID = VoucherID;
    }

    public String getOrderDate() {
        return OrderDate;
    }

    public void setOrderDate(String OrderDate) {
        this.OrderDate = OrderDate;
    }
    
    
}
