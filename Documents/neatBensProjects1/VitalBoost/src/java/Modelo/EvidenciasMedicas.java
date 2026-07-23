package Modelo;

import java.sql.Timestamp;

public class EvidenciasMedicas {
    
     private int id_evidencia;
    private int id_usuario;
    private String url_archivo;
    private String descripcion_archivo;
    private String tipo_archivo;
    private Timestamp fecha_subida;

    public int getId_evidencia() {
        return id_evidencia;
    }

    public void setId_evidencia(int id_evidencia) {
        this.id_evidencia = id_evidencia;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getUrl_archivo() {
        return url_archivo;
    }

    public void setUrl_archivo(String url_archivo) {
        this.url_archivo = url_archivo;
    }

    public String getDescripcion_archivo() {
        return descripcion_archivo;
    }

    public void setDescripcion_archivo(String descripcion_archivo) {
        this.descripcion_archivo = descripcion_archivo;
    }

    public String getTipo_archivo() {
        return tipo_archivo;
    }

    public void setTipo_archivo(String tipo_archivo) {
        this.tipo_archivo = tipo_archivo;
    }

    public Timestamp getFecha_subida() {
        return fecha_subida;
    }

    public void setFecha_subida(Timestamp fecha_subida) {
        this.fecha_subida = fecha_subida;
    }
   

    
}