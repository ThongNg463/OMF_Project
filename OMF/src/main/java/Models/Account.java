/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Mac
 */
public class Account {

    private String Username;
    private String Password;
    private String Role;
    private String AccPic;

    public Account() {
    }

    public Account(String Username, String Password, String Role, String AccPic) {
        this.Username = Username;
        this.Password = Password;
        this.Role = Role;
        this.AccPic = AccPic;
    }

    public Account(String Username, String Password) {
        this.Username = Username;
        this.Password = Password;
    }
    
    public String getUsername() {
        return Username;
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public String getRole() {
        return Role;
    }

    public void setRole(String Role) {
        this.Role = Role;
    }

    public String getAccPic() {
        return AccPic;
    }

    public void setAccPic(String AccPic) {
        this.AccPic = AccPic;
    }

    

    

}
