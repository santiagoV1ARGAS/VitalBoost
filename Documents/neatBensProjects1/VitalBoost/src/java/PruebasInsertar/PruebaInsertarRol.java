package PruebasInsertar;

import java.util.Scanner;
import Controlador.RolesDAO;
import Modelo.Roles;

public class PruebaInsertarRol {

    public static void main(String[] args) {

        Scanner leer = new Scanner(System.in);
        RolesDAO dao = new RolesDAO();
        Roles r = new Roles();

        System.out.println("--- Registro de Nuevo Rol ---");

        System.out.print("Nombre del Rol (ej. Admin, Paciente): ");
        r.setNombre_rol(leer.nextLine());

        System.out.print("Descripción: ");
        r.setDescripcion(leer.nextLine());

        int res = dao.agregar(r);

        if (res > 0) {
            System.out.println("\n✅ Rol agregado exitosamente.");
        } else {
            System.out.println("\n❌ Error al agregar el rol.");
        }

        leer.close();
    }
}