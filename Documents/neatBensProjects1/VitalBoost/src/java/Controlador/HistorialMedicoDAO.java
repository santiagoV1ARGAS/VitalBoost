package Controlador;

import Conexion.Conexion;
import Modelo.HistorialMedico;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HistorialMedicoDAO {

    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;
    private Conexion cn = new Conexion();

    // =========================
    // INSERTAR
    // =========================
    public int agregar(HistorialMedico h) {

        String sql = "INSERT INTO historial_medico "
                + "(id_usuario, enfermedad, descripcion, fecha_registro) "
                + "VALUES (?,?,?,?)";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, h.getId_usuario());
            ps.setString(2, h.getEnfermedad());
            ps.setString(3, h.getDescripcion());

            // ⚠️ si en BD es TIMESTAMP, esto es correcto:
            ps.setString(4, h.getFecha_registro());

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error agregar historial medico: " + e.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // =========================
    // LISTAR
    // =========================
    public List<HistorialMedico> listar() {

        List<HistorialMedico> lista = new ArrayList<>();

        String sql = "SELECT * FROM historial_medico";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {

                HistorialMedico h = new HistorialMedico();

                h.setId_historial(rs.getInt("id_historial"));
                h.setId_usuario(rs.getInt("id_usuario"));
                h.setEnfermedad(rs.getString("enfermedad"));
                h.setDescripcion(rs.getString("descripcion"));
                h.setFecha_registro(rs.getString("fecha_registro"));

                lista.add(h);
            }

        } catch (Exception e) {
            System.out.println("Error listar historial medico: " + e.getMessage());
        } finally {
            cerrar();
        }

        return lista;
    }

    // =========================
    // ACTUALIZAR
    // =========================
    public int actualizar(HistorialMedico h) {

        String sql = "UPDATE historial_medico SET "
                + "id_usuario=?, enfermedad=?, descripcion=?, fecha_registro=? "
                + "WHERE id_historial=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, h.getId_usuario());
            ps.setString(2, h.getEnfermedad());
            ps.setString(3, h.getDescripcion());
            ps.setString(4, h.getFecha_registro());
            ps.setInt(5, h.getId_historial());

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error actualizar historial medico: " + e.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // =========================
    // ELIMINAR (CORREGIDO)
    // =========================
    public void eliminar(int id) {

        String sql = "DELETE FROM historial_medico WHERE id_historial=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error eliminar historial medico: " + e.getMessage());
        } finally {
            cerrar();
        }
    }

    // =========================
    // CIERRE DE RECURSOS
    // =========================
    private void cerrar() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            System.out.println("Error cerrando recursos: " + e.getMessage());
        }
    }
    public HistorialMedico obtenerPorId(int id) {

    HistorialMedico h = null;

    String sql = "SELECT * FROM historial_medico WHERE id_historial=?";

    try {

        con = cn.getConnection();
        ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        rs = ps.executeQuery();

        if (rs.next()) {

            h = new HistorialMedico();

            h.setId_historial(rs.getInt("id_historial"));
            h.setId_usuario(rs.getInt("id_usuario"));
            h.setEnfermedad(rs.getString("enfermedad"));
            h.setDescripcion(rs.getString("descripcion"));
            h.setFecha_registro(rs.getString("fecha_registro"));
        }

    } catch (Exception e) {
        System.out.println("Error obtener historial: " + e.getMessage());
    } finally {
        cerrar();
    }

    return h;
}
}