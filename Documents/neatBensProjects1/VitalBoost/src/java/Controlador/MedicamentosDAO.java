package Controlador;

import Conexion.Conexion;
import Modelo.Medicamentos;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MedicamentosDAO {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    // =========================
    // LISTAR
    // =========================
    public List<Medicamentos> listar() {

        List<Medicamentos> lista = new ArrayList<>();

        String sql = "SELECT * FROM Medicamentos";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {

                Medicamentos m = new Medicamentos();

                m.setId_medicamento(rs.getInt("id_medicamento"));
                m.setNombre_comun(rs.getString("nombre_comun"));
                m.setUso_para(rs.getString("uso_para"));
                m.setIndicaciones(rs.getString("indicaciones"));
                m.setContraindicaciones(rs.getString("contraindicaciones"));
                m.setAdvertencia_critica(rs.getString("advertencia_critica"));

                lista.add(m);
            }

        } catch (Exception e) {
            System.out.println("Error al listar medicamentos: " + e.getMessage());
        } finally {
            cerrar();
        }

        return lista;
    }

    // =========================
    // AGREGAR
    // =========================
    public int agregar(Medicamentos m) {

        String sql = "INSERT INTO Medicamentos "
                + "(nombre_comun, uso_para, indicaciones, contraindicaciones, advertencia_critica) "
                + "VALUES (?,?,?,?,?)";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, m.getNombre_comun());
            ps.setString(2, m.getUso_para());
            ps.setString(3, m.getIndicaciones());
            ps.setString(4, m.getContraindicaciones());
            ps.setString(5, m.getAdvertencia_critica());

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error al agregar medicamento: " + e.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // =========================
    // ACTUALIZAR
    // =========================
    public int actualizar(Medicamentos m) {

        String sql = "UPDATE Medicamentos SET "
                + "nombre_comun=?, uso_para=?, indicaciones=?, contraindicaciones=?, advertencia_critica=? "
                + "WHERE id_medicamento=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, m.getNombre_comun());
            ps.setString(2, m.getUso_para());
            ps.setString(3, m.getIndicaciones());
            ps.setString(4, m.getContraindicaciones());
            ps.setString(5, m.getAdvertencia_critica());
            ps.setInt(6, m.getId_medicamento());

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error al actualizar medicamento: " + e.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // =========================
    // ELIMINAR
    // =========================
    public int eliminar(int id) {

        String sql = "DELETE FROM Medicamentos WHERE id_medicamento=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error al eliminar medicamento: " + e.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // =========================
    // CERRAR RECURSOS
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
    public Medicamentos obtenerPorId(int id) {

    Medicamentos m = null;

    String sql = "SELECT * FROM Medicamentos WHERE id_medicamento=?";

    try {

        con = cn.getConnection();
        ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        rs = ps.executeQuery();

        if (rs.next()) {

            m = new Medicamentos();

            m.setId_medicamento(rs.getInt("id_medicamento"));
            m.setNombre_comun(rs.getString("nombre_comun"));
            m.setUso_para(rs.getString("uso_para"));
            m.setIndicaciones(rs.getString("indicaciones"));
            m.setContraindicaciones(rs.getString("contraindicaciones"));
            m.setAdvertencia_critica(rs.getString("advertencia_critica"));
        }

    } catch (Exception e) {
        System.out.println("Error obtener medicamento: " + e.getMessage());
    } finally {
        cerrar();
    }

    return m;
}
}