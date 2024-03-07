/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Mac
 */
public class account {

    private String username;
    private String password;
    private String role;
    private String accpic;

    public account() {
    }

    public account(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public account(String username, String password, String role, String accpic) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.accpic = accpic;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getAccpic() {
        return accpic;
    }

    public void setAccpic(String accpic) {
        this.accpic = accpic;
    }

}
