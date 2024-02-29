<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.sql.*, java.io.*, DB.DbConnection" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Database Connection Test</title>
    </head>
    <body>
        <h1>Database Connection Test</h1>
        <%
            Connection conn = null;
            try {
                // Get connection from DbConnection class
                conn = DbConnection.getConnection();

                // Display success message
                out.println("<p>Database connection established successfully!</p>");
            } catch (Exception e) {
                // Display error message
                out.println("<p>Error connecting to the database: " + e.getMessage() + "</p>");
            } finally {
                // Close the connection
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        out.println("<p>Error closing the database connection: " + e.getMessage() + "</p>");
                    }
                }
            }
        %>
    </body>
</html>