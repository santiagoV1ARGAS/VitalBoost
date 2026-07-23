package Conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    public Connection getConnection() {
        Connection con = null;

        // Lee variables de entorno (Railway las inyecta automáticamente)
        String host = System.getenv("MYSQLHOST") != null ? System.getenv("MYSQLHOST") : "localhost";
        String port = System.getenv("MYSQLPORT") != null ? System.getenv("MYSQLPORT") : "3306";
        String db   = System.getenv("MYSQLDATABASE") != null ? System.getenv("MYSQLDATABASE") : "vitalboost"; // nombre de tu BD local
        String user = System.getenv("MYSQLUSER") != null ? System.getenv("MYSQLUSER") : "root";
        String pass = System.getenv("MYSQLPASSWORD") != null ? System.getenv("MYSQLPASSWORD") : ""; // tu clave local

        String url = "jdbc:mysql://" + host + ":" + port + "/" + db + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Error en la conexión DB: " + e.getMessage());
            e.printStackTrace();
        }
        return con;
    }
}