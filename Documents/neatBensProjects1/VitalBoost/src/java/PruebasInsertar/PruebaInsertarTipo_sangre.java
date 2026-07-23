package PruebasInsertar;

import Controlador.Tipo_sangreDAO;

import java.util.Scanner;
import Modelo.Tipo_sangre;

public class PruebaInsertarTipo_sangre {

    public static void main(String[] args) {

        try (Scanner leer = new Scanner(System.in)) {
            Tipo_sangreDAO dao = new Tipo_sangreDAO();
            
            Tipo_sangre t = new Tipo_sangre();
            
            System.out.println("===== INSERTAR TIPO DE SANGRE =====");
            
            System.out.print("Ingrese nombre del tipo de sangre: ");
            t.setNombre_tipo(leer.nextLine());
            
            int resultado = dao.insertar(t);
            
            if (resultado > 0) {
                
                System.out.println("Tipo de sangre insertado correctamente.");
                
            } else {
                
                System.out.println("Error al insertar.");
            }
        }
    }
}