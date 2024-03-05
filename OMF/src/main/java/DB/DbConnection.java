package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author ACER
 */
public class DbConnection {

    private static Connection conn = null;

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection conn = DriverManager.getConnection("jdbc:sqlserver://DESKTOP-MA7UCJO\\\\SQLEXPRESS:1433;"
                + "databaseName=Group5;user=sa;password=1234;"
                + "encrypt=true;trustServerCertificate=true;");
        return conn;
    }
}
