package main.java;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private Connection connection = null;

    public Connection getConnection() {
        try {

            String driver = "org.postgresql.Driver";
            String url = "jdbc:postgresql://localhost:5432/Mining";
            String user = "postgres";
            String password = "root";
            Class.forName(driver);
            connection = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }
}

