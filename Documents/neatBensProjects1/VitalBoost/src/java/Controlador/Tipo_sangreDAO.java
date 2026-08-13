package Controlador;
import Conexion.Conexion;
import Modelo.Tipo_sangre;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
public class Tipo_sangreDAO {
    Conexion cn = new Conexion();
    // =========================
    // LISTAR TODOS
    // =========================
    public List<Tipo_sangre> listar() {
        List<Tipo_sangre> lista = new ArrayList<>();
        String sql = "SELECT * FROM Tipo_sangre";
        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Tipo_sangre t = new Tipo_sangre();
                t.setId_tipo_sangre(rs.getInt("id_tipo_sangre"));
                t.setNombre_tipo(rs.getString("nombre_tipo_sangre"));
                lista.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
    // =========================
    // INSERTAR
    // =========================
    public int insertar(Tipo_sangre t) {
        String sql = "INSERT INTO Tipo_sangre(nombre_tipo_sangre) VALUES(?)";
        int r = 0;
        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getNombre_tipo());
            r = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return r;
    }
    // =========================
    // BUSCAR POR ID
    // =========================
    public Tipo_sangre buscarPorId(int id) {
        Tipo_sangre t = null;
        String sql = "SELECT * FROM Tipo_sangre WHERE id_tipo_sangre = ?";
        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    t = new Tipo_sangre();
                    t.setId_tipo_sangre(rs.getInt("id_tipo_sangre"));
                    t.setNombre_tipo(rs.getString("nombre_tipo_sangre"));
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
    public boolean actualizar(Tipo_sangre t) {
        String sql = "UPDATE Tipo_sangre SET nombre_tipo_sangre = ? WHERE id_tipo_sangre = ?";
        try (Connection con = cn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getNombre_tipo());
            ps.setInt(2, t.getId_tipo_sangre());
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
        String sql = "DELETE FROM Tipo_sangre WHERE id_tipo_sangre = ?";
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