package Controlador;

import Conexion.Conexion;
import Modelo.RegistroTomaMedicamentos;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RegistroTomaMedicamentosDAO {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    // =========================
    // LISTAR
    // =========================
    public List<RegistroTomaMedicamentos> listar() {

        List<RegistroTomaMedicamentos> lista = new ArrayList<>();

        String sql = "SELECT * FROM Registro_toma_medicamentos";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {

                RegistroTomaMedicamentos rtm = new RegistroTomaMedicamentos();

                rtm.setId_registro(rs.getInt("id_registro"));
                rtm.setId_usuario(rs.getInt("id_usuario"));
                rtm.setId_medicamento(rs.getInt("id_medicamento"));
                rtm.setNombre_sustancia_manual(rs.getString("nombre_sustancia_manual"));
                rtm.setDosis_tomada(rs.getString("dosis_tomada"));
                rtm.setHora_toma(rs.getString("hora_toma"));

                lista.add(rtm);
            }

        } catch (Exception e) {
            System.out.println("Error listar registro toma: " + e.getMessage());
        } finally {
            cerrar();
        }

        return lista;
    }

    // =========================
    // AGREGAR
    // =========================
    public int agregar(RegistroTomaMedicamentos rtm) {

        String sql = "INSERT INTO Registro_toma_medicamentos "
                + "(id_usuario, id_medicamento, nombre_sustancia_manual, dosis_tomada) "
                + "VALUES (?,?,?,?)";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, rtm.getId_usuario());
            ps.setInt(2, rtm.getId_medicamento());
            ps.setString(3, rtm.getNombre_sustancia_manual());
            ps.setString(4, rtm.getDosis_tomada());

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error agregar registro toma: " + e.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // =========================
    // ACTUALIZAR
    // =========================
    public int actualizar(RegistroTomaMedicamentos rtm) {

        String sql = "UPDATE Registro_toma_medicamentos SET "
                + "id_usuario=?, id_medicamento=?, nombre_sustancia_manual=?, dosis_tomada=? "
                + "WHERE id_registro=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, rtm.getId_usuario());
            ps.setInt(2, rtm.getId_medicamento());
            ps.setString(3, rtm.getNombre_sustancia_manual());
            ps.setString(4, rtm.getDosis_tomada());
            ps.setInt(5, rtm.getId_registro());

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error actualizar registro toma: " + e.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // =========================
    // ELIMINAR
    // =========================
    public int eliminar(int id) {

        String sql = "DELETE FROM Registro_toma_medicamentos WHERE id_registro=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error eliminar registro toma: " + e.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // =========================
    // CIERRE
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
   public RegistroTomaMedicamentos buscarPorId(int id) {

    String sql = "SELECT * FROM Registro_toma_medicamentos WHERE id_registro=?";

    try {
        con = cn.getConnection();
        ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        rs = ps.executeQuery();

        if (rs.next()) {

            RegistroTomaMedicamentos r = new RegistroTomaMedicamentos();

            r.setId_registro(rs.getInt("id_registro"));
            r.setId_usuario(rs.getInt("id_usuario"));
            r.setId_medicamento(rs.getInt("id_medicamento"));
            r.setNombre_sustancia_manual(rs.getString("nombre_sustancia_manual"));
            r.setDosis_tomada(rs.getString("dosis_tomada"));
            r.setHora_toma(rs.getString("hora_toma"));

            return r;
        }

    } catch (Exception e) {
        System.out.println("Error buscar: " + e.getMessage());
    } finally {
        cerrar();
    }

    return null;
}
}