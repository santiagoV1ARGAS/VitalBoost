package Controlador;

import Conexion.Conexion;
import Modelo.Tipo_Documento;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Tipo_DocumentoDAO {

    Conexion cn = new Conexion();

    // =========================
    // LISTAR TODOS
    // =========================
    public List<Tipo_Documento> listar() {
        List<Tipo_Documento> lista = new ArrayList<>();
        String sql = "SELECT * FROM Tipo_documento";

        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Tipo_Documento td = new Tipo_Documento();
                td.setId_tipo_documento(rs.getInt("id_tipo_documento"));
                td.setDescripcion_tipo_documento(rs.getString("descripcion_tipo_documento"));
                lista.add(td);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    // =========================
    // INSERTAR
    // =========================
    public int insertar(Tipo_Documento td) {
        String sql = "INSERT INTO Tipo_documento(descripcion_tipo_documento) VALUES(?)";
        int r = 0;

        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, td.getDescripcion_tipo_documento());
            r = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return r;
    }

    // =========================
    // BUSCAR POR ID
    // =========================
    public Tipo_Documento buscarPorId(int id) {
        Tipo_Documento td = null;
        String sql = "SELECT * FROM Tipo_documento WHERE id_tipo_documento = ?";

        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    td = new Tipo_Documento();
                    td.setId_tipo_documento(rs.getInt("id_tipo_documento"));
                    td.setDescripcion_tipo_documento(rs.getString("descripcion_tipo_documento"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return td;
    }

    // =========================
    // ACTUALIZAR
    // =========================
    public boolean actualizar(Tipo_Documento td) {
        String sql = "UPDATE Tipo_documento SET descripcion_tipo_documento = ? WHERE id_tipo_documento = ?";

        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, td.getDescripcion_tipo_documento());
            ps.setInt(2, td.getId_tipo_documento());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // =========================
    // ELIMINAR
    // =========================
    public boolean eliminar(int id) {
        String sql = "DELETE FROM Tipo_documento WHERE id_tipo_documento = ?";

        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}