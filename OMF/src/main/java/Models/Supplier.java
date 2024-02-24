/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author mthon
 */
public class Supplier {
    private String SupID;
    private String SupName;
    private String SupAddress;
    private int SupPhone;
    private String SupTaxID;
    private String SupCountry;
    private String SupContractStatus;
    private String SupNotes;
    private String SupPrice;
    private String SupType;

    public Supplier(String SupID, String SupName, String SupAddress, int SupPhone, String SupTaxID, String SupCountry, String SupContractStatus, String SupNotes, String SupPrice, String SupType) {
        this.SupID = SupID;
        this.SupName = SupName;
        this.SupAddress = SupAddress;
        this.SupPhone = SupPhone;
        this.SupTaxID = SupTaxID;
        this.SupCountry = SupCountry;
        this.SupContractStatus = SupContractStatus;
        this.SupNotes = SupNotes;
        this.SupPrice = SupPrice;
        this.SupType = SupType;
    }

    public String getSupID() {
        return SupID;
    }

    public void setSupID(String SupID) {
        this.SupID = SupID;
    }

    public String getSupName() {
        return SupName;
    }

    public void setSupName(String SupName) {
        this.SupName = SupName;
    }

    public String getSupAddress() {
        return SupAddress;
    }

    public void setSupAddress(String SupAddress) {
        this.SupAddress = SupAddress;
    }

    public int getSupPhone() {
        return SupPhone;
    }

    public void setSupPhone(int SupPhone) {
        this.SupPhone = SupPhone;
    }

    public String getSupTaxID() {
        return SupTaxID;
    }

    public void setSupTaxID(String SupTaxID) {
        this.SupTaxID = SupTaxID;
    }

    public String getSupCountry() {
        return SupCountry;
    }

    public void setSupCountry(String SupCountry) {
        this.SupCountry = SupCountry;
    }

    public String getSupContractStatus() {
        return SupContractStatus;
    }

    public void setSupContractStatus(String SupContractStatus) {
        this.SupContractStatus = SupContractStatus;
    }

    public String getSupNotes() {
        return SupNotes;
    }

    public void setSupNotes(String SupNotes) {
        this.SupNotes = SupNotes;
    }

    public String getSupPrice() {
        return SupPrice;
    }

    public void setSupPrice(String SupPrice) {
        this.SupPrice = SupPrice;
    }

    public String getSupType() {
        return SupType;
    }

    public void setSupType(String SupType) {
        this.SupType = SupType;
    }
    
    
}
