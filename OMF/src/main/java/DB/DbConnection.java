/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author mthon
 */
public class DbConnection {

    private static Connection conn = null;

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection conn = DriverManager.getConnection("jdbc:sqlserver:DESKTOP-MA7UCJO\\SQLEXPRESS:1433;"
                + "databaseName=Gr5_Project;user=sa;password=1234;"
                + "encrypt=true;trustServerCertificate=true;");
        return conn;
    }
}
