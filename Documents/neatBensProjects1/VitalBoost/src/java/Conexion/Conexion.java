package Conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    Connection con;

    // ==================================================================
    // CONEXIÓN A LA BASE DE DATOS
    //
    // Prioridad: variables de entorno (Railway las inyecta solas en
    // producción) > estos valores por defecto, que apuntan al proxy
    // PÚBLICO de tu base en Railway, para que funcione de una en local
    // sin configurar nada más.
    // ==================================================================
    private static final String DEFAULT_HOST = "sakura.proxy.rlwy.net";
    private static final String DEFAULT_PORT = "18514";
    private static final String DEFAULT_DB = "railway";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASSWORD = "cwPHVTSdCyIkDtRMnVAyILnpnpSMKGPY";

    public Connection getConnection() {

        String host = obtenerVariable("MYSQLHOST", DEFAULT_HOST);
        String port = obtenerVariable("MYSQLPORT", DEFAULT_PORT);
        String db = obtenerVariable("MYSQLDATABASE", DEFAULT_DB);
        String user = obtenerVariable("MYSQLUSER", DEFAULT_USER);
        String pass = obtenerVariable("MYSQLPASSWORD", DEFAULT_PASSWORD);

        String url = "jdbc:mysql://" + host + ":" + port + "/" + db
                + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("--- ERROR CRITICO DE CONEXION A LA BASE DE DATOS ---");
            System.err.println("Host usado: " + host + ":" + port + " / BD: " + db);
            e.printStackTrace();
        }

        return con;
    }

    // ==================================================================
    // Busca primero en las variables de entorno del sistema operativo
    // (así funciona en Railway). Si no existen, usa el valor por
    // defecto (el proxy público de Railway) para que funcione en local
    // sin configuración extra.
    // ==================================================================
    private String obtenerVariable(String nombre, String porDefecto) {
        String valor = System.getenv(nombre);
        return (valor == null || valor.isBlank()) ? porDefecto : valor;
    }
}
