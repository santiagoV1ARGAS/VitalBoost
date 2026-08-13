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
            // LISTAR USUARIOS (DASHBOARD)
            // =========================

            case "listar":

                listarUsuarios(request, response, "/vistas/dashboardAdmin.jsp");

                break;

            // =========================
            // LISTAR USUARIOS (CONFIGURACIÓN DEL SISTEMA)
            // =========================

            case "listarConfig":

                listarUsuarios(request, response, "/vistas/configuracion.jsp");

                break;

            // =========================
            // DESACTIVAR USUARIO (BORRADO LÓGICO)
            // =========================

            case "eliminar":

                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    dao.desactivar(id);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                response.sendRedirect(request.getContextPath()
                        + "/Servletlistarusuario?accion=" + accionRetorno(request));

                break;

            // =========================
            // ACTIVAR USUARIO
            // =========================

            case "activar":

                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    dao.activar(id);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                response.sendRedirect(request.getContextPath()
                        + "/Servletlistarusuario?accion=" + accionRetorno(request));

                break;

            // =========================
            // DEFAULT
            // =========================

            default:

                listarUsuarios(request, response, "/vistas/dashboardAdmin.jsp");

                break;
        }

    }

    // =========================
    // DETERMINA A DÓNDE VOLVER (DASHBOARD O CONFIGURACIÓN)
    // SEGÚN EL PARÁMETRO "origen" QUE ENVÍA EL BOTÓN
    // =========================

    private String accionRetorno(HttpServletRequest request) {

        String origen = request.getParameter("origen");

        if ("config".equalsIgnoreCase(origen)) {
            return "listarConfig";
        }

        return "listar";
    }

    // =========================
    // MÉTODO LISTAR
    // =========================

    private void listarUsuarios(HttpServletRequest request,
                                HttpServletResponse response,
                                String vistaDestino)

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
            vistaDestino
        ).forward(request, response);

    }

}