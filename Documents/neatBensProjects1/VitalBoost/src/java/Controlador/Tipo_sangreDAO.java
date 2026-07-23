package Controlador;

import Modelo.Tipo_sangre;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Tipo_sangreDAO {

    public List<Tipo_sangre> listar() {
        List<Tipo_sangre> lista = new ArrayList<>();
        String sql = "SELECT * FROM tipo_sangre";
        // Lógica JDBC para consultar...
        return lista;
    }

    public int insertar(Tipo_sangre t) {
        String sql = "INSERT INTO tipo_sangre(nombre_tipo) VALUES(?)";
        // Lógica JDBC para guardar...
        return 1;
    }

    public Tipo_sangre buscarPorId(int id) {
        Tipo_sangre t = new Tipo_sangre();
        String sql = "SELECT * FROM tipo_sangre WHERE id_tipo_sangre = ?";
        // Lógica JDBC para traer el registro por ID...
        return t;
    }

    public boolean actualizar(Tipo_sangre t) {
        String sql = "UPDATE tipo_sangre SET nombre_tipo = ? WHERE id_tipo_sangre = ?";
        // Lógica JDBC para actualizar...
        return true;
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM tipo_sangre WHERE id_tipo_sangre = ?";
        // Lógica JDBC para eliminar...
        return true;
    }
}