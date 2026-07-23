package PruebasInsertar;

import Controlador.Tipo_DocumentoDAO;
import Modelo.Tipo_Documento;
import java.util.Scanner;

public class PruebaInsertarTipo_documento {

    public static void main(String[] args) {

        Scanner leer = new Scanner(System.in);

        Tipo_DocumentoDAO dao = new Tipo_DocumentoDAO();
        Tipo_Documento td = new Tipo_Documento();

        System.out.println("--- Registro de Nuevo Tipo Documento ---");

        System.out.print("Descripción del tipo de documento (ej. CC, TI, Pasaporte): ");
        td.setDescripcion_tipo_documento(leer.nextLine());

        int res = dao.insertar(td);

        if (res > 0) {
            System.out.println("✅ Tipo de documento agregado exitosamente.");
        } else {
            System.out.println("❌ Error al agregar el tipo de documento.");
        }
    }
}