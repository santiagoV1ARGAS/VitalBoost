package PruebasInsertar;

import java.util.Scanner;

import Controlador.UsuarioDAO;
import Modelo.Usuario;

public class PruebaInsertarUsuario {

    public static void main(String[] args) {

        Scanner leer = new Scanner(System.in);

        UsuarioDAO dao = new UsuarioDAO();

        Usuario u = new Usuario();

        System.out.println("===== REGISTRO USUARIO =====");

        // =========================
        // ID ROL
        // =========================
        System.out.print(
                "ID Rol (1 Admin / 2 Usuario): "
        );

        u.setId_rol(
                leer.nextInt()
        );

        // =========================
        // ID TIPO DOCUMENTO
        // =========================
        System.out.print(
                "ID Tipo Documento: "
        );

        u.setId_tipo_documento(
                leer.nextInt()
        );

        // =========================
        // ID TIPO SANGRE
        // =========================
        System.out.print(
                "ID Tipo Sangre: "
        );

        leer.nextLine();

        u.setId_tipo_sangre(
    Integer.parseInt(leer.nextLine())
);

        // =========================
        // NOMBRE
        // =========================
        System.out.print(
                "Nombre Completo: "
        );

        u.setNombre_completo(
                leer.nextLine()
        );

        // =========================
        // EMAIL
        // =========================
        System.out.print(
                "Email: "
        );

        u.setEmail(
                leer.nextLine()
        );

        // =========================
        // PASSWORD
        // =========================
        System.out.print(
                "Password: "
        );

        u.setPassword(
                leer.nextLine()
        );

        // =========================
        // FECHA NACIMIENTO
        // =========================
        System.out.print(
                "Fecha Nacimiento (YYYY-MM-DD): "
        );

        u.setFecha_nacimiento(
                leer.nextLine()
        );

        // =========================
        // ALERGIAS
        // =========================
        System.out.print(
                "Alergias: "
        );

        u.setAlergias_conocidas(
                leer.nextLine()
        );

        // =========================
        // INSERTAR
        // =========================
        int res = dao.insertar(u);

        if (res > 0) {

            System.out.println(
                    "\nUsuario guardado correctamente."
            );

        } else {

            System.out.println(
                    "\nError al guardar usuario."
            );
        }

        leer.close();
    }
}