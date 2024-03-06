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

/* Huy
public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection conn = DriverManager.getConnection("jdbc:sqlserver://DESKTOP-LH33OH3\\\\SQLEXPRESS:1433;"
                + "databaseName=Group5;user=huy;password=tanhuykg001;"
                + "encrypt=true;trustServerCertificate=true;");
        return conn;
    }
 */

 /* Phung
public class DbConnection {

    private static Connection conn = null;

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection conn = DriverManager.getConnection("jdbc:sqlserver://TVMP\\\\SQLEXPRESS:1433;"
                + "databaseName=Group5;user=sa;password=1234;"
                + "encrypt=true;trustServerCertificate=true;");
        return conn;
    }
}
 */

/* Khoi
public class DbConnection {

    private static final String JDBC_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String DB_URL = "jdbc:sqlserver://KBOOK\\SQLEXPRESS;databaseName=Group5;encrypt=true;trustServerCertificate=true;";
    private static final String USER = "admin";
    private static final String PASS = "123456";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(JDBC_DRIVER);
            return DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("JDBC Driver not found", e);
        }
    }
}
*/
