package Servlets;

import Controlador.UsuarioDAO;
import Modelo.Usuario;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Servletlistarusuario",
            urlPatterns = {"/Servletlistarusuario"})

public class Servletlistarusuario extends HttpServlet {

    UsuarioDAO dao = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)

            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        // =========================
        // SI NO HAY ACCIÓN
        // =========================

        if (accion == null) {

            accion = "listar";

        }

        switch (accion) {

            // =========================
            // LISTAR USUARIOS
            // =========================

            case "listar":

                listarUsuarios(request, response);

                break;

            // =========================
            // DEFAULT
            // =========================

            default:

                listarUsuarios(request, response);

                break;
        }

    }

    // =========================
    // MÉTODO LISTAR
    // =========================

    private void listarUsuarios(HttpServletRequest request,
                                HttpServletResponse response)

            throws ServletException, IOException {

        List<Usuario> listaUsuarios = dao.listar();

        // =========================
        // ENVIAR LISTA
        // =========================

        request.setAttribute(
            "listaUsuarios",
            listaUsuarios
        );

        // =========================
        // TOTAL USUARIOS
        // =========================

        request.setAttribute(
            "totalUsuarios",
            listaUsuarios.size()
        );

        // =========================
        // REDIRECCIONAR
        // =========================

        request.getRequestDispatcher(
            "/vistas/dashboardAdmin.jsp"
        ).forward(request, response);

    }

}