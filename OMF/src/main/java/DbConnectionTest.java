import java.sql.Connection;
import java.sql.SQLException;

import DB.DbConnection;

public class DbConnectionTest {

    public static void main(String[] args) {
        try {
            Connection connection = DbConnection.getConnection();
            if (connection != null) {
                System.out.println("Database connection established successfully!");
                connection.close(); // Remember to close the connection when done
            } else {
                System.out.println("Failed to establish database connection.");
            }
        } catch (SQLException e) {
            System.err.println("Error connecting to the database: " + e.getMessage());
        }
    }
}
