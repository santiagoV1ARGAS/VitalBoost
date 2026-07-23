package Controlador;

import Conexion.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Modelo.EvidenciasMedicas;

public class EvidenciasMedicasDAO {

    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;
    private final Conexion cn = new Conexion();

    // =========================
    // 1. INSERTAR
    // =========================
    public int agregar(EvidenciasMedicas e) {

        String sql = "INSERT INTO Evidencias_medicas "
                + "(id_usuario, url_archivo, descripcion_archivo, tipo_archivo) "
                + "VALUES (?,?,?,?)";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, e.getId_usuario());
            ps.setString(2, e.getUrl_archivo());
            ps.setString(3, e.getDescripcion_archivo());
            ps.setString(4, e.getTipo_archivo());

            return ps.executeUpdate();

        } catch (Exception ex) {
            System.out.println("Error al insertar evidencia: " + ex.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // =========================
    // 2. LISTAR
    // =========================
    public List<EvidenciasMedicas> listar() {

        List<EvidenciasMedicas> lista = new ArrayList<>();

        String sql = "SELECT * FROM Evidencias_medicas";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {

                EvidenciasMedicas e = new EvidenciasMedicas();

                e.setId_evidencia(rs.getInt("id_evidencia"));
                e.setId_usuario(rs.getInt("id_usuario"));
                e.setUrl_archivo(rs.getString("url_archivo"));
                e.setDescripcion_archivo(rs.getString("descripcion_archivo"));
                e.setTipo_archivo(rs.getString("tipo_archivo"));

                // 🔥 CORRECCIÓN IMPORTANTE
                e.setFecha_subida(rs.getTimestamp("fecha_subida"));

                lista.add(e);
            }

        } catch (Exception ex) {
            System.out.println("Error al listar evidencias: " + ex.getMessage());
        } finally {
            cerrar();
        }

        return lista;
    }

    // =========================
    // 3. ACTUALIZAR
    // =========================
    public int actualizar(EvidenciasMedicas e) {

        String sql = "UPDATE Evidencias_medicas SET "
                + "id_usuario=?, url_archivo=?, descripcion_archivo=?, tipo_archivo=? "
                + "WHERE id_evidencia=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, e.getId_usuario());
            ps.setString(2, e.getUrl_archivo());
            ps.setString(3, e.getDescripcion_archivo());
            ps.setString(4, e.getTipo_archivo());
            ps.setInt(5, e.getId_evidencia());

            return ps.executeUpdate();

        } catch (Exception ex) {
            System.out.println("Error al actualizar evidencia: " + ex.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // =========================
    // 4. ELIMINAR
    // =========================
    public int eliminar(int id) {

        String sql = "DELETE FROM Evidencias_medicas WHERE id_evidencia=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            return ps.executeUpdate();

        } catch (Exception ex) {
            System.out.println("Error al eliminar evidencia: " + ex.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // =========================
    // 5. CERRAR RECURSOS
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
    public EvidenciasMedicas obtenerPorId(int id) {

    EvidenciasMedicas e = null;

    String sql = "SELECT * FROM Evidencias_medicas WHERE id_evidencia=?";

    try {

        con = cn.getConnection();
        ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        rs = ps.executeQuery();

        if (rs.next()) {

            e = new EvidenciasMedicas();

            e.setId_evidencia(rs.getInt("id_evidencia"));
            e.setId_usuario(rs.getInt("id_usuario"));
            e.setUrl_archivo(rs.getString("url_archivo"));
            e.setDescripcion_archivo(rs.getString("descripcion_archivo"));
            e.setTipo_archivo(rs.getString("tipo_archivo"));
            e.setFecha_subida(rs.getTimestamp("fecha_subida"));
        }

    } catch (Exception ex) {
        System.out.println("Error obtener evidencia: " + ex.getMessage());
    } finally {
        cerrar();
    }

    return e;
}
}