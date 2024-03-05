/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author ACER
 */
public class Products {

    private String ProID;
    private String ProName;
    private String ProPic;
    private String ProDes;
    private float ProPrice;
    private String ProType;

    public Products() {
    }

    public Products(String ProID, String ProName, String ProPic, String ProDes, float ProPrice, String ProType) {
        this.ProID = ProID;
        this.ProName = ProName;
        this.ProPic = ProPic;
        this.ProDes = ProDes;
        this.ProPrice = ProPrice;
        this.ProType = ProType;
    }

    public String getProID() {
        return ProID;
    }

    public void setProID(String ProID) {
        this.ProID = ProID;
    }

    public String getProName() {
        return ProName;
    }

    public void setProName(String ProName) {
        this.ProName = ProName;
    }

    public String getProPic() {
        return ProPic;
    }

    public void setProPic(String ProPic) {
        this.ProPic = ProPic;
    }

    public String getProDes() {
        return ProDes;
    }

    public void setProDes(String ProDes) {
        this.ProDes = ProDes;
    }

    public float getProPrice() {
        return ProPrice;
    }

    public void setProPrice(float ProPrice) {
        this.ProPrice = ProPrice;
    }

    public String getProType() {
        return ProType;
    }

    public void setProType(String ProType) {
        this.ProType = ProType;
    }

  
}