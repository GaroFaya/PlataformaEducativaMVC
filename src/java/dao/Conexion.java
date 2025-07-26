package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    public static Connection conectar() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/plataforma?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8",
            "root",
            ""
        );

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("❌ Error de conexión: " + e.getMessage());
            return null;
        }
    }
}
