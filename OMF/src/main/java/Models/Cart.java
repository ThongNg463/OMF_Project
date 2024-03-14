/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author mthon
 */
public class Cart {
    private String CartID;
    private String Username;
    private String ProID;
    private int Quality;

    public Cart() {
    }

    public Cart(String CartID, String Username, String ProID, int Quality) {
        this.CartID = CartID;
        this.Username = Username;
        this.ProID = ProID;
        this.Quality = Quality;
    }

    public String getCartID() {
        return CartID;
    }

    public void setCartID(String CartID) {
        this.CartID = CartID;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public String getProID() {
        return ProID;
    }

    public void setProID(String ProID) {
        this.ProID = ProID;
    }

    public int getQuality() {
        return Quality;
    }

    public void setQuality(int Quality) {
        this.Quality = Quality;
    }
    
    
}
