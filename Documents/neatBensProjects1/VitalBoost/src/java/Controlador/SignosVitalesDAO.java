package Controlador;

import Conexion.Conexion;
import Modelo.SignosVitales;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SignosVitalesDAO {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    // =========================
    // LISTAR
    // =========================
    public List<SignosVitales> listar() {

        List<SignosVitales> lista = new ArrayList<>();

        String sql = "SELECT * FROM Signos_vitales";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {

                SignosVitales sv = new SignosVitales();

                sv.setId_signo(rs.getInt("id_signo"));
                sv.setId_usuario(rs.getInt("id_usuario"));
                sv.setFrecuencia_cardiaca(rs.getInt("frecuencia_cardiaca"));
                sv.setPresion_arterial(rs.getString("presion_arterial"));
                sv.setSaturacion_oxigeno(rs.getInt("saturacion_oxigeno"));
                sv.setTemperatura(rs.getDouble("temperatura"));
                sv.setFecha_registro(rs.getString("fecha_registro"));

                lista.add(sv);
            }

        } catch (Exception e) {
            System.out.println("Error listar signos vitales: " + e.getMessage());
        } finally {
            cerrar();
        }

        return lista;
    }

    // =========================
    // AGREGAR
    // =========================
    public int agregar(SignosVitales sv) {

        String sql = "INSERT INTO Signos_vitales "
                + "(id_usuario, frecuencia_cardiaca, presion_arterial, saturacion_oxigeno, temperatura) "
                + "VALUES (?,?,?,?,?)";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, sv.getId_usuario());
            ps.setInt(2, sv.getFrecuencia_cardiaca());
            ps.setString(3, sv.getPresion_arterial());
            ps.setInt(4, sv.getSaturacion_oxigeno());
            ps.setDouble(5, sv.getTemperatura());

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error agregar signos vitales: " + e.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // =========================
    // ACTUALIZAR
    // =========================
    public int actualizar(SignosVitales sv) {

        String sql = "UPDATE Signos_vitales SET "
                + "frecuencia_cardiaca=?, presion_arterial=?, saturacion_oxigeno=?, temperatura=? "
                + "WHERE id_signo=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, sv.getFrecuencia_cardiaca());
            ps.setString(2, sv.getPresion_arterial());
            ps.setInt(3, sv.getSaturacion_oxigeno());
            ps.setDouble(4, sv.getTemperatura());
            ps.setInt(5, sv.getId_signo());

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error actualizar signos vitales: " + e.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // =========================
    // ELIMINAR
    // =========================
    public int eliminar(int id) {

        String sql = "DELETE FROM Signos_vitales WHERE id_signo=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error eliminar signos vitales: " + e.getMessage());
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
    public SignosVitales buscarPorId(int id) {

    String sql = "SELECT * FROM Signos_vitales WHERE id_signo=?";

    try {
        con = cn.getConnection();
        ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        rs = ps.executeQuery();

        if (rs.next()) {

            SignosVitales sv = new SignosVitales();

            sv.setId_signo(rs.getInt("id_signo"));
            sv.setId_usuario(rs.getInt("id_usuario"));
            sv.setFrecuencia_cardiaca(rs.getInt("frecuencia_cardiaca"));
            sv.setPresion_arterial(rs.getString("presion_arterial"));
            sv.setSaturacion_oxigeno(rs.getInt("saturacion_oxigeno"));
            sv.setTemperatura(rs.getDouble("temperatura"));
            sv.setFecha_registro(rs.getString("fecha_registro"));

            return sv;
        }

    } catch (Exception e) {
        System.out.println("Error buscar: " + e.getMessage());
    } finally {
        cerrar();
    }

    return null;
}
}