package Controlador;

import Conexion.Conexion;
import Modelo.Roles;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RolesDAO {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    // =========================
    // LISTAR
    // =========================
    public List<Roles> listar() {

        List<Roles> lista = new ArrayList<>();

        String sql = "SELECT * FROM Roles";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {

                Roles r = new Roles();

                r.setId_rol(rs.getInt("id_rol"));
                r.setNombre_rol(rs.getString("nombre_rol"));
                r.setDescripcion(rs.getString("descripcion"));

                lista.add(r);
            }

        } catch (Exception e) {
            System.out.println("Error listar roles: " + e.getMessage());
        } finally {
            cerrar();
        }

        return lista;
    }

    // =========================
    // AGREGAR
    // =========================
    public int agregar(Roles r) {

        String sql = "INSERT INTO Roles(nombre_rol, descripcion) VALUES(?,?)";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, r.getNombre_rol());
            ps.setString(2, r.getDescripcion());

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error agregar rol: " + e.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // =========================
    // ACTUALIZAR
    // =========================
    public int actualizar(Roles r) {

        String sql = "UPDATE Roles SET nombre_rol=?, descripcion=? WHERE id_rol=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, r.getNombre_rol());
            ps.setString(2, r.getDescripcion());
            ps.setInt(3, r.getId_rol());

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error actualizar rol: " + e.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // =========================
    // ELIMINAR
    // =========================
    public int eliminar(int id) {

        String sql = "DELETE FROM Roles WHERE id_rol=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error eliminar rol: " + e.getMessage());
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
    public Roles obtenerPorId(int id) {

    Roles r = null;

    String sql = "SELECT * FROM Roles WHERE id_rol=?";

    try {

        con = cn.getConnection();
        ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        rs = ps.executeQuery();

        if (rs.next()) {

            r = new Roles();

            r.setId_rol(rs.getInt("id_rol"));
            r.setNombre_rol(rs.getString("nombre_rol"));
            r.setDescripcion(rs.getString("descripcion"));
        }

    } catch (Exception e) {
        System.out.println("Error obtener rol: " + e.getMessage());
    } finally {
        cerrar();
    }

    return r;
}
}