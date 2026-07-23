package Controlador;

import Modelo.Tipo_Documento;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Tipo_DocumentoDAO {

    // Cambia los métodos según la conexión que tengas en tu proyecto
    
    public List<Tipo_Documento> listar() {
        List<Tipo_Documento> lista = new ArrayList<>();
        String sql = "SELECT * FROM tipo_documento";
        // Lógica JDBC para consultar y llenar la lista...
        return lista;
    }

    public int insertar(Tipo_Documento td) {
        String sql = "INSERT INTO tipo_documento(descripcion_tipo_documento) VALUES(?)";
        // Lógica JDBC para ejecutar el INSERT...
        return 1;
    }

    public Tipo_Documento buscarPorId(int id) {
        String sql = "SELECT * FROM tipo_documento WHERE id_tipo_documento = ?";
        // Lógica JDBC para traer el registro único...
        return null;
    }

    public boolean actualizar(Tipo_Documento td) {
        String sql = "UPDATE tipo_documento SET descripcion_tipo_documento = ? WHERE id_tipo_documento = ?";
        // Lógica JDBC para el UPDATE...
        return true;
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM tipo_documento WHERE id_tipo_documento = ?";
        // Lógica JDBC para el DELETE...
        return true;
    }
}