package  Modelo;
public class TriajeInicial {
    private int id_triaje;
    private int id_usuario;
    private int nivel_dolor_escala;
    private String sintoma_principal;
    private int estado_consciencia;
    private String fecha_triaje;

    public int getId_triaje() {
        return id_triaje;
    }

    public void setId_triaje(int id_triaje) {
        this.id_triaje = id_triaje;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public int getNivel_dolor_escala() {
        return nivel_dolor_escala;
    }

    public void setNivel_dolor_escala(int nivel_dolor_escala) {
        this.nivel_dolor_escala = nivel_dolor_escala;
    }

    public String getSintoma_principal() {
        return sintoma_principal;
    }

    public void setSintoma_principal(String sintoma_principal) {
        this.sintoma_principal = sintoma_principal;
    }

    public int getEstado_consciencia() {
        return estado_consciencia;
    }

    public void setEstado_consciencia(int estado_consciencia) {
        this.estado_consciencia = estado_consciencia;
    }

    public String getFecha_triaje() {
        return fecha_triaje;
    }

    public void setFecha_triaje(String fecha_triaje) {
        this.fecha_triaje = fecha_triaje;
    }

    
}