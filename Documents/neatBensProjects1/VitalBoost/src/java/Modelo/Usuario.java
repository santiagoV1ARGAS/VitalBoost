package Modelo;

public class Usuario {

    private int id_usuario;
    private int id_rol;
    private int id_tipo_documento;
    private int id_tipo_sangre;

    private String numero_documento;
    private String nombre_completo;
    private String email;
    private String password;
    private String fecha_nacimiento;
    private String alergias_conocidas;
    private String fecha_registro;

    // =========================
    // CAMPOS EXTRA PARA JOINS
    // =========================

    private String nombreRol;
    private String nombreTipoSangre;
    private String nombreTipoDocumento;

    // =========================
    // GETTERS Y SETTERS
    // =========================

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public int getId_rol() {
        return id_rol;
    }

    public void setId_rol(int id_rol) {
        this.id_rol = id_rol;
    }

    public int getId_tipo_documento() {
        return id_tipo_documento;
    }

    public void setId_tipo_documento(int id_tipo_documento) {
        this.id_tipo_documento = id_tipo_documento;
    }

    public int getId_tipo_sangre() {
        return id_tipo_sangre;
    }

    public void setId_tipo_sangre(int id_tipo_sangre) {
        this.id_tipo_sangre = id_tipo_sangre;
    }

    public String getNumero_documento() {
        return numero_documento;
    }

    public void setNumero_documento(String numero_documento) {
        this.numero_documento = numero_documento;
    }

    public String getNombre_completo() {
        return nombre_completo;
    }

    public void setNombre_completo(String nombre_completo) {
        this.nombre_completo = nombre_completo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFecha_nacimiento() {
        return fecha_nacimiento;
    }

    public void setFecha_nacimiento(String fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    public String getAlergias_conocidas() {
        return alergias_conocidas;
    }

    public void setAlergias_conocidas(String alergias_conocidas) {
        this.alergias_conocidas = alergias_conocidas;
    }

    public String getFecha_registro() {
        return fecha_registro;
    }

    public void setFecha_registro(String fecha_registro) {
        this.fecha_registro = fecha_registro;
    }

    // =========================
    // GETTERS Y SETTERS JOINS
    // =========================

    public String getNombreRol() {
        return nombreRol;
    }

    public void setNombreRol(String nombreRol) {
        this.nombreRol = nombreRol;
    }

    public String getNombreTipoSangre() {
        return nombreTipoSangre;
    }

    public void setNombreTipoSangre(String nombreTipoSangre) {
        this.nombreTipoSangre = nombreTipoSangre;
    }

    public String getNombreTipoDocumento() {
        return nombreTipoDocumento;
    }

    public void setNombreTipoDocumento(String nombreTipoDocumento) {
        this.nombreTipoDocumento = nombreTipoDocumento;
    }

}