package Controlador;

import Conexion.Conexion;
import Modelo.ContactoEmergencia;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactoEmergenciaDAO {

    Conexion cn = new Conexion();

    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    // LISTAR
    public List<ContactoEmergencia> listar() {

        List<ContactoEmergencia> lista = new ArrayList<>();

        String sql = "SELECT * FROM Contactos_emergencia";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {

                ContactoEmergencia c = new ContactoEmergencia();

                c.setId_contacto(rs.getInt("id_contacto"));
                c.setId_usuario(rs.getInt("id_usuario"));
                c.setNombre_contacto(rs.getString("nombre_contacto"));
                c.setParentesco(rs.getString("parentesco"));
                c.setTelefono(rs.getString("telefono"));

                lista.add(c);
            }

        } catch (Exception e) {
            System.out.println("Error listar contactos: " + e.getMessage());
        } finally {
            cerrar();
        }

        return lista;
    }

    // INSERTAR
    public int agregar(ContactoEmergencia c) {

        String sql = "INSERT INTO Contactos_emergencia "
                + "(id_usuario, nombre_contacto, parentesco, telefono) "
                + "VALUES (?,?,?,?)";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, c.getId_usuario());
            ps.setString(2, c.getNombre_contacto());
            ps.setString(3, c.getParentesco());
            ps.setString(4, c.getTelefono());

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error agregar contacto: " + e.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // ACTUALIZAR
    public int actualizar(ContactoEmergencia c) {

        String sql = "UPDATE Contactos_emergencia SET "
                + "id_usuario=?, nombre_contacto=?, parentesco=?, telefono=? "
                + "WHERE id_contacto=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, c.getId_usuario());
            ps.setString(2, c.getNombre_contacto());
            ps.setString(3, c.getParentesco());
            ps.setString(4, c.getTelefono());
            ps.setInt(5, c.getId_contacto());

            return ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error actualizar contacto: " + e.getMessage());
            return 0;
        } finally {
            cerrar();
        }
    }

    // ELIMINAR
    public void eliminar(int id) {

        String sql = "DELETE FROM Contactos_emergencia WHERE id_contacto=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error eliminar contacto: " + e.getMessage());
        } finally {
            cerrar();
        }
    }

    // CERRAR RECURSOS
    private void cerrar() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            System.out.println("Error cerrando recursos: " + e.getMessage());
        }
    }
    public ContactoEmergencia obtenerPorId(int id) {

    ContactoEmergencia c = null;

    String sql = "SELECT * FROM Contactos_emergencia WHERE id_contacto=?";

    try {
        con = cn.getConnection();
        ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        rs = ps.executeQuery();

        if (rs.next()) {

            c = new ContactoEmergencia();

            c.setId_contacto(rs.getInt("id_contacto"));
            c.setId_usuario(rs.getInt("id_usuario"));
            c.setNombre_contacto(rs.getString("nombre_contacto"));
            c.setParentesco(rs.getString("parentesco"));
            c.setTelefono(rs.getString("telefono"));
        }

    } catch (Exception e) {
        System.out.println("Error obtener contacto: " + e.getMessage());
    } finally {
        cerrar();
    }

    return c;
}
}