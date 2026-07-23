package Controlador;

import Conexion.Conexion;
import Modelo.TriajeInicial;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TriajeInicialDAO {

    Conexion cn = new Conexion();

    // =========================
    // AGREGAR / INSERTAR
    // =========================
    public int agregar(TriajeInicial t) {
        String sql = "INSERT INTO triaje_inicial (id_usuario, nivel_dolor_escala, sintoma_principal, estado_consciencia) VALUES (?, ?, ?, ?)";
        int r = 0;
        
        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, t.getId_usuario());
            ps.setInt(2, t.getNivel_dolor_escala());
            ps.setString(3, t.getSintoma_principal());
            ps.setInt(4, t.getEstado_consciencia());

            r = ps.executeUpdate(); // Retorna 1 si insertó correctamente
        } catch (Exception e) {
            e.printStackTrace();
        }
        return r;
    }

    // =========================
    // LISTAR TODOS
    // =========================
    public List<TriajeInicial> listar() {
        List<TriajeInicial> lista = new ArrayList<>();
        String sql = "SELECT * FROM triaje_inicial";

        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                TriajeInicial t = new TriajeInicial();
                t.setId_triaje(rs.getInt("id_triaje"));
                t.setId_usuario(rs.getInt("id_usuario"));
                t.setNivel_dolor_escala(rs.getInt("nivel_dolor_escala"));
                t.setSintoma_principal(rs.getString("sintoma_principal"));
                t.setEstado_consciencia(rs.getInt("estado_consciencia"));
                lista.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    // =========================
    // BUSCAR POR ID (Para editar)
    // =========================
    public TriajeInicial buscarPorId(int id) {
        TriajeInicial t = new TriajeInicial();
        String sql = "SELECT * FROM triaje_inicial WHERE id_triaje = ?";

        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    t.setId_triaje(rs.getInt("id_triaje"));
                    t.setId_usuario(rs.getInt("id_usuario"));
                    t.setNivel_dolor_escala(rs.getInt("nivel_dolor_escala"));
                    t.setSintoma_principal(rs.getString("sintoma_principal"));
                    t.setEstado_consciencia(rs.getInt("estado_consciencia"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }

    // =========================
    // ACTUALIZAR
    // =========================
    public boolean actualizar(TriajeInicial t) {
        String sql = "UPDATE triaje_inicial SET id_usuario=?, nivel_dolor_escala=?, sintoma_principal=?, estado_consciencia=? WHERE id_triaje=?";

        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, t.getId_usuario());
            ps.setInt(2, t.getNivel_dolor_escala());
            ps.setString(3, t.getSintoma_principal());
            ps.setInt(4, t.getEstado_consciencia());
            ps.setInt(5, t.getId_triaje());

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
        String sql = "DELETE FROM triaje_inicial WHERE id_triaje = ?";

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