package Servlets;

import Controlador.ContactoEmergenciaDAO;
import Modelo.ContactoEmergencia;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(
    name = "Servletregistrarcontactoemergencia",
    urlPatterns = {"/Servletregistrarcontactoemergencia"}
)
public class Servletregistrarcontactoemergencia extends HttpServlet {

    ContactoEmergenciaDAO dao = new ContactoEmergenciaDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        // LISTAR
        if (accion == null || accion.equals("listar")) {

            request.setAttribute("listaContactos", dao.listar());

            request.getRequestDispatcher("/vistas/registrarcontactoemergencia.jsp")
                    .forward(request, response);
        }

        // EDITAR
        else if (accion.equals("editar")) {

            int id = Integer.parseInt(request.getParameter("id"));

            ContactoEmergencia c = dao.obtenerPorId(id);

            request.setAttribute("contactoEditar", c);
            request.setAttribute("listaContactos", dao.listar());

            request.getRequestDispatcher("/vistas/registrarcontactoemergencia.jsp")
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
                    + "/Servletregistrarcontactoemergencia?accion=listar");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        ContactoEmergencia c = new ContactoEmergencia();

        c.setId_usuario(Integer.parseInt(request.getParameter("txtIdUsuario")));
        c.setNombre_contacto(request.getParameter("txtNombreContacto"));
        c.setParentesco(request.getParameter("txtParentesco"));
        c.setTelefono(request.getParameter("txtTelefono"));

        // GUARDAR
        if ("guardar".equals(accion)) {
            dao.agregar(c);
        }

        // ACTUALIZAR
        else if ("actualizar".equals(accion)) {

            c.setId_contacto(Integer.parseInt(request.getParameter("idContacto")));
            dao.actualizar(c);
        }

        response.sendRedirect(request.getContextPath()
                + "/Servletregistrarcontactoemergencia?accion=listar");
    }
}