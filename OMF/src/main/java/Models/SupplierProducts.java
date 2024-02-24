/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author mthon
 */
public class SupplierProducts {
    private String SupID;
    private String ProID;
    private int Quanlity;

    public SupplierProducts(String SupID, String ProID, int Quanlity) {
        this.SupID = SupID;
        this.ProID = ProID;
        this.Quanlity = Quanlity;
    }

    public String getSupID() {
        return SupID;
    }

    public void setSupID(String SupID) {
        this.SupID = SupID;
    }

    public String getProID() {
        return ProID;
    }

    public void setProID(String ProID) {
        this.ProID = ProID;
    }

    public int getQuanlity() {
        return Quanlity;
    }

    public void setQuanlity(int Quanlity) {
        this.Quanlity = Quanlity;
    }
    
    
}
