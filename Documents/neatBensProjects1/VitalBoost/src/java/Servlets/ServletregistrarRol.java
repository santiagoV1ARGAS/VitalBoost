package Servlets;

import Controlador.RolesDAO;
import Modelo.Roles;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ServletregistrarRol", urlPatterns = {"/ServletregistrarRol"})
public class ServletregistrarRol extends HttpServlet {

    RolesDAO dao = new RolesDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        // LISTAR
        if (accion == null || accion.equals("listar")) {

            request.setAttribute("listaRoles", dao.listar());

            request.getRequestDispatcher("/vistas/registrarRol.jsp")
                    .forward(request, response);
        }

        // EDITAR (CARGAR DATOS EN FORMULARIO)
        else if (accion.equals("editar")) {

            int id = Integer.parseInt(request.getParameter("id"));

            Roles rol = dao.obtenerPorId(id);

            request.setAttribute("rolEditar", rol);
            request.setAttribute("listaRoles", dao.listar());

            request.getRequestDispatcher("/vistas/registrarRol.jsp")
                    .forward(request, response);
        }

        // ELIMINAR
        else if (accion.equals("eliminar")) {

            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
            } catch (Exception e) {
                e.printStackTrace();
            }

            response.sendRedirect(request.getContextPath() 
                    + "/ServletregistrarRol?accion=listar");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        Roles r = new Roles();

        r.setNombre_rol(request.getParameter("txtNombreRol"));
        r.setDescripcion(request.getParameter("txtDescripcion"));

        // GUARDAR
        if ("guardar".equals(accion)) {
            dao.agregar(r);
        }

        // ACTUALIZAR
        else if ("actualizar".equals(accion)) {

            r.setId_rol(Integer.parseInt(request.getParameter("idRol")));
            dao.actualizar(r);
        }

        response.sendRedirect(request.getContextPath()
                + "/ServletregistrarRol?accion=listar");
    }
}