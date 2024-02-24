/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author mthon
 */
public class Voucher {
    private String VoucherID;
    private int VoucherStock;
    private int VoucherPercent;

    public Voucher(String VoucherID, int VoucherStock, int VoucherPercent) {
        this.VoucherID = VoucherID;
        this.VoucherStock = VoucherStock;
        this.VoucherPercent = VoucherPercent;
    }

    public String getVoucherID() {
        return VoucherID;
    }

    public void setVoucherID(String VoucherID) {
        this.VoucherID = VoucherID;
    }

    public int getVoucherStock() {
        return VoucherStock;
    }

    public void setVoucherStock(int VoucherStock) {
        this.VoucherStock = VoucherStock;
    }

    public int getVoucherPercent() {
        return VoucherPercent;
    }

    public void setVoucherPercent(int VoucherPercent) {
        this.VoucherPercent = VoucherPercent;
    }
    
    
}
