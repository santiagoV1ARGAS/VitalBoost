package Modelo;
public class Medicamentos {
    private int id_medicamento;
    private String nombre_comun;
    private String uso_para;
    private String indicaciones;
    private String contraindicaciones;
    private String advertencia_critica;

    public int getId_medicamento() {
        return id_medicamento;
    }

    public void setId_medicamento(int id_medicamento) {
        this.id_medicamento = id_medicamento;
    }

    public String getNombre_comun() {
        return nombre_comun;
    }

    public void setNombre_comun(String nombre_comun) {
        this.nombre_comun = nombre_comun;
    }

    public String getUso_para() {
        return uso_para;
    }

    public void setUso_para(String uso_para) {
        this.uso_para = uso_para;
    }

    public String getIndicaciones() {
        return indicaciones;
    }

    public void setIndicaciones(String indicaciones) {
        this.indicaciones = indicaciones;
    }

    public String getContraindicaciones() {
        return contraindicaciones;
    }

    public void setContraindicaciones(String contraindicaciones) {
        this.contraindicaciones = contraindicaciones;
    }

    public String getAdvertencia_critica() {
        return advertencia_critica;
    }

    public void setAdvertencia_critica(String advertencia_critica) {
        this.advertencia_critica = advertencia_critica;
    }

    
    
}