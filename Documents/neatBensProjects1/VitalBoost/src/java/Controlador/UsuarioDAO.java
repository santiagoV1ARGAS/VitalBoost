package Controlador;

import Conexion.Conexion;
import Modelo.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    Conexion cn = new Conexion();

    // =========================
    // INSERTAR / AGREGAR
    // =========================
    public int insertar(Usuario u) {
        String sql = "INSERT INTO usuarios (id_rol, id_tipo_documento, id_tipo_sangre, numero_documento, nombre_completo, email, password, fecha_nacimiento, alergias_conocidas) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        int r = 0;

        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, u.getId_rol());
            ps.setInt(2, u.getId_tipo_documento());
            ps.setInt(3, u.getId_tipo_sangre());
            ps.setString(4, u.getNumero_documento());
            ps.setString(5, u.getNombre_completo());
            ps.setString(6, u.getEmail());
            ps.setString(7, u.getPassword());
            ps.setString(8, u.getFecha_nacimiento());
            ps.setString(9, u.getAlergias_conocidas());

            r = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return r;
    }

    // =========================
    // LISTAR TODOS
    // =========================
    public List<Usuario> listar() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuarios";

        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setId_rol(rs.getInt("id_rol"));
                u.setId_tipo_documento(rs.getInt("id_tipo_documento"));
                u.setId_tipo_sangre(rs.getInt("id_tipo_sangre"));
                u.setNumero_documento(rs.getString("numero_documento"));
                u.setNombre_completo(rs.getString("nombre_completo"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setFecha_nacimiento(rs.getString("fecha_nacimiento"));
                u.setAlergias_conocidas(rs.getString("alergias_conocidas"));
                lista.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    // =========================
    // BUSCAR POR ID
    // =========================
    public Usuario buscarPorId(int id) {
        Usuario u = null;
        String sql = "SELECT * FROM usuarios WHERE id_usuario = ?";

        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    u = new Usuario();
                    u.setId_usuario(rs.getInt("id_usuario"));
                    u.setId_rol(rs.getInt("id_rol"));
                    u.setId_tipo_documento(rs.getInt("id_tipo_documento"));
                    u.setId_tipo_sangre(rs.getInt("id_tipo_sangre"));
                    u.setNumero_documento(rs.getString("numero_documento"));
                    u.setNombre_completo(rs.getString("nombre_completo"));
                    u.setEmail(rs.getString("email"));
                    u.setPassword(rs.getString("password"));
                    u.setFecha_nacimiento(rs.getString("fecha_nacimiento"));
                    u.setAlergias_conocidas(rs.getString("alergias_conocidas"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    // =========================
    // BUSCAR POR DOCUMENTO (Requerido por ServletLogin)
    // =========================
    public Usuario buscarPorDocumento(String documento) {
        Usuario u = null;
        String sql = "SELECT * FROM usuarios WHERE numero_documento = ?";

        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, documento);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    u = new Usuario();
                    u.setId_usuario(rs.getInt("id_usuario"));
                    u.setId_rol(rs.getInt("id_rol"));
                    u.setId_tipo_documento(rs.getInt("id_tipo_documento"));
                    u.setId_tipo_sangre(rs.getInt("id_tipo_sangre"));
                    u.setNumero_documento(rs.getString("numero_documento"));
                    u.setNombre_completo(rs.getString("nombre_completo"));
                    u.setEmail(rs.getString("email"));
                    u.setPassword(rs.getString("password"));
                    u.setFecha_nacimiento(rs.getString("fecha_nacimiento"));
                    u.setAlergias_conocidas(rs.getString("alergias_conocidas"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    // =========================
    // BUSCAR POR EMAIL (Requerido por ServletLogin)
    // =========================
    public Usuario buscarPorEmail(String email) {
        Usuario u = null;
        String sql = "SELECT * FROM usuarios WHERE email = ?";

        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    u = new Usuario();
                    u.setId_usuario(rs.getInt("id_usuario"));
                    u.setId_rol(rs.getInt("id_rol"));
                    u.setId_tipo_documento(rs.getInt("id_tipo_documento"));
                    u.setId_tipo_sangre(rs.getInt("id_tipo_sangre"));
                    u.setNumero_documento(rs.getString("numero_documento"));
                    u.setNombre_completo(rs.getString("nombre_completo"));
                    u.setEmail(rs.getString("email"));
                    u.setPassword(rs.getString("password"));
                    u.setFecha_nacimiento(rs.getString("fecha_nacimiento"));
                    u.setAlergias_conocidas(rs.getString("alergias_conocidas"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    // =========================
    // ACTUALIZAR
    // =========================
    public boolean actualizar(Usuario u) {
        String sql = "UPDATE usuarios SET id_rol=?, id_tipo_documento=?, id_tipo_sangre=?, numero_documento=?, nombre_completo=?, email=?, password=?, fecha_nacimiento=?, alergias_conocidas=? WHERE id_usuario=?";

        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, u.getId_rol());
            ps.setInt(2, u.getId_tipo_documento());
            ps.setInt(3, u.getId_tipo_sangre());
            ps.setString(4, u.getNumero_documento());
            ps.setString(5, u.getNombre_completo());
            ps.setString(6, u.getEmail());
            ps.setString(7, u.getPassword());
            ps.setString(8, u.getFecha_nacimiento());
            ps.setString(9, u.getAlergias_conocidas());
            ps.setInt(10, u.getId_usuario());

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
        String sql = "DELETE FROM usuarios WHERE id_usuario = ?";

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