package Modelo;
public class RegistroTomaMedicamentos {
    private int id_registro;
    private int id_usuario;
    private int id_medicamento;
    private String nombre_sustancia_manual;
    private String dosis_tomada;
    private String hora_toma;

    public int getId_registro() {
        return id_registro;
    }

    public void setId_registro(int id_registro) {
        this.id_registro = id_registro;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public int getId_medicamento() {
        return id_medicamento;
    }

    public void setId_medicamento(int id_medicamento) {
        this.id_medicamento = id_medicamento;
    }

    public String getNombre_sustancia_manual() {
        return nombre_sustancia_manual;
    }

    public void setNombre_sustancia_manual(String nombre_sustancia_manual) {
        this.nombre_sustancia_manual = nombre_sustancia_manual;
    }

    public String getDosis_tomada() {
        return dosis_tomada;
    }

    public void setDosis_tomada(String dosis_tomada) {
        this.dosis_tomada = dosis_tomada;
    }

    public String getHora_toma() {
        return hora_toma;
    }

    public void setHora_toma(String hora_toma) {
        this.hora_toma = hora_toma;
    }

    
    
}