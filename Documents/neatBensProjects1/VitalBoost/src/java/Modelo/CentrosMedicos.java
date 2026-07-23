package Modelo;
public class CentrosMedicos {
    private int id_centro;
    private int id_usuario_referencia;
    private String nombre_centro;
    private String direccion;
    private String telefono_urgencias;
    private double latitud;
    private double longitud;

    public int getId_centro() {
        return id_centro;
    }

    public void setId_centro(int id_centro) {
        this.id_centro = id_centro;
    }

    public int getId_usuario_referencia() {
        return id_usuario_referencia;
    }

    public void setId_usuario_referencia(int id_usuario_referencia) {
        this.id_usuario_referencia = id_usuario_referencia;
    }

    public String getNombre_centro() {
        return nombre_centro;
    }

    public void setNombre_centro(String nombre_centro) {
        this.nombre_centro = nombre_centro;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono_urgencias() {
        return telefono_urgencias;
    }

    public void setTelefono_urgencias(String telefono_urgencias) {
        this.telefono_urgencias = telefono_urgencias;
    }

    public double getLatitud() {
        return latitud;
    }

    public void setLatitud(double latitud) {
        this.latitud = latitud;
    }

    public double getLongitud() {
        return longitud;
    }

    public void setLongitud(double longitud) {
        this.longitud = longitud;
    }

    
}