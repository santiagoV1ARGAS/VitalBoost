package Controlador;

import Conexion.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Modelo.CentrosMedicos;

public class CentrosMedicosDAO {

    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    Conexion cn = new Conexion();

    // 1. INSERTAR
    public int insertar(CentrosMedicos c) {
        String sql = "INSERT INTO Centros_medicos "
                + "(id_usuario_referencia, nombre_centro, direccion, telefono_urgencias, latitud, longitud) "
                + "VALUES (?,?,?,?,?,?)";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, c.getId_usuario_referencia());
            ps.setString(2, c.getNombre_centro());
            ps.setString(3, c.getDireccion());
            ps.setString(4, c.getTelefono_urgencias());
            ps.setDouble(5, c.getLatitud());
            ps.setDouble(6, c.getLongitud());

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error al insertar centro: " + e.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // 2. LISTAR
    public List<CentrosMedicos> listar() {
        List<CentrosMedicos> lista = new ArrayList<>();

        String sql = "SELECT * FROM Centros_medicos";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                CentrosMedicos c = new CentrosMedicos();

                c.setId_centro(rs.getInt("id_centro"));
                c.setId_usuario_referencia(rs.getInt("id_usuario_referencia"));
                c.setNombre_centro(rs.getString("nombre_centro"));
                c.setDireccion(rs.getString("direccion"));
                c.setTelefono_urgencias(rs.getString("telefono_urgencias"));
                c.setLatitud(rs.getDouble("latitud"));
                c.setLongitud(rs.getDouble("longitud"));

                lista.add(c);
            }

        } catch (Exception e) {
            System.out.println("Error al listar centros: " + e.getMessage());
        } finally {
            cerrar();
        }

        return lista;
    }

    // 3. ACTUALIZAR
    public int actualizar(CentrosMedicos c) {
        String sql = "UPDATE Centros_medicos SET "
                + "id_usuario_referencia=?, nombre_centro=?, direccion=?, telefono_urgencias=?, latitud=?, longitud=? "
                + "WHERE id_centro=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, c.getId_usuario_referencia());
            ps.setString(2, c.getNombre_centro());
            ps.setString(3, c.getDireccion());
            ps.setString(4, c.getTelefono_urgencias());
            ps.setDouble(5, c.getLatitud());
            ps.setDouble(6, c.getLongitud());
            ps.setInt(7, c.getId_centro());

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error al actualizar centro: " + e.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // 4. ELIMINAR (SEGURO)
    public void eliminar(int id) {
        String sql = "DELETE FROM Centros_medicos WHERE id_centro=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error al eliminar centro: " + e.getMessage());
        } finally {
            cerrar();
        }
    }

    // CIERRE DE RECURSOS
    private void cerrar() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            System.out.println("Error cerrando recursos: " + e.getMessage());
        }
    }
    public CentrosMedicos obtenerPorId(int id) {

    CentrosMedicos c = null;

    String sql = "SELECT * FROM Centros_medicos WHERE id_centro=?";

    try {

        con = cn.getConnection();
        ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        rs = ps.executeQuery();

        if (rs.next()) {

            c = new CentrosMedicos();

            c.setId_centro(rs.getInt("id_centro"));
            c.setId_usuario_referencia(rs.getInt("id_usuario_referencia"));
            c.setNombre_centro(rs.getString("nombre_centro"));
            c.setDireccion(rs.getString("direccion"));
            c.setTelefono_urgencias(rs.getString("telefono_urgencias"));
            c.setLatitud(rs.getDouble("latitud"));
            c.setLongitud(rs.getDouble("longitud"));
        }

    } catch (Exception e) {
        System.out.println("Error obtener centro: " + e.getMessage());
    } finally {
        cerrar();
    }

    return c;
}
}