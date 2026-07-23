package  Modelo;
public class SignosVitales {
    private int id_signo;
    private int id_usuario;
    private int frecuencia_cardiaca;
    private String presion_arterial;
    private int saturacion_oxigeno;
    private double temperatura;
    private String fecha_registro;

    public int getId_signo() {
        return id_signo;
    }

    public void setId_signo(int id_signo) {
        this.id_signo = id_signo;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public int getFrecuencia_cardiaca() {
        return frecuencia_cardiaca;
    }

    public void setFrecuencia_cardiaca(int frecuencia_cardiaca) {
        this.frecuencia_cardiaca = frecuencia_cardiaca;
    }

    public String getPresion_arterial() {
        return presion_arterial;
    }

    public void setPresion_arterial(String presion_arterial) {
        this.presion_arterial = presion_arterial;
    }

    public int getSaturacion_oxigeno() {
        return saturacion_oxigeno;
    }

    public void setSaturacion_oxigeno(int saturacion_oxigeno) {
        this.saturacion_oxigeno = saturacion_oxigeno;
    }

    public double getTemperatura() {
        return temperatura;
    }

    public void setTemperatura(double temperatura) {
        this.temperatura = temperatura;
    }

    public String getFecha_registro() {
        return fecha_registro;
    }

    public void setFecha_registro(String fecha_registro) {
        this.fecha_registro = fecha_registro;
    }

    
}