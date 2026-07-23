package Prueba;

import java.sql.Connection;
import java.sql.DriverManager;
import Conexion.Conexion;

public class PruebaConexion {

    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3307/VitalBoost";
        String user = "root";
        String pass = "";

        try {
            Connection con = DriverManager.getConnection(url, user, pass);
            System.out.println("Conexion exitosa a la base de datos");
            con.close();
        } catch (Exception e) {
            System.out.println("Error en la conexion ❌");
            e.printStackTrace();
        }
    }
}