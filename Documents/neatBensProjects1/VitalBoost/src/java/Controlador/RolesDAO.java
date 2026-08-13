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
    // Devuelve:
    //   > 0  -> filas eliminadas (éxito)
    //   0    -> el rol no existía
    //   -1   -> no se pudo eliminar porque hay usuarios usando ese rol
    //           (violación de llave foránea Usuarios.id_rol -> Roles.id_rol)
    //   -2   -> otro error de base de datos
    // =========================
    public int eliminar(int id) {

        String sql = "DELETE FROM Roles WHERE id_rol=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            return ps.executeUpdate();

        } catch (SQLIntegrityConstraintViolationException e) {
            System.out.println("Error eliminar rol: rol en uso por usuarios. " + e.getMessage());
            return -1;
        } catch (Exception e) {
            System.out.println("Error eliminar rol: " + e.getMessage());
            return -2;
        } finally {
            cerrar();
        }
    }

    // =========================
    // OBTENER POR NOMBRE (ignora tildes/mayúsculas)
    //
    // Los roles se crean y editan libremente desde el panel de admin,
    // así que su id_rol puede variar. Este método permite ubicar un
    // rol por su nombre (p. ej. "Paciente" o "Administrador") sin
    // asumir un id fijo.
    // =========================
    public Roles obtenerPorNombre(String nombreBuscado) {

        if (nombreBuscado == null) {
            return null;
        }

        String buscado = normalizar(nombreBuscado);

        for (Roles r : listar()) {
            if (normalizar(r.getNombre_rol()).equals(buscado)) {
                return r;
            }
        }

        return null;
    }

    private String normalizar(String texto) {
        if (texto == null) {
            return "";
        }
        String sinTildes = java.text.Normalizer.normalize(texto.trim(), java.text.Normalizer.Form.NFD)
                .replaceAll("\\p{M}", "");
        return sinTildes.toLowerCase();
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