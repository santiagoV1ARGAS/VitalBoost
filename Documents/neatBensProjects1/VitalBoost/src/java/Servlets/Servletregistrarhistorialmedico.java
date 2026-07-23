package Servlets;

import Controlador.HistorialMedicoDAO;
import Modelo.HistorialMedico;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "Servletregistrarhistorialmedico",
        urlPatterns = {"/Servletregistrarhistorialmedico"})
public class Servletregistrarhistorialmedico extends HttpServlet {

    HistorialMedicoDAO dao = new HistorialMedicoDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        // LISTAR
        if (accion == null || accion.equals("listar")) {

            request.setAttribute("listaHistorial", dao.listar());

            request.getRequestDispatcher("/vistas/registrarhistorialmedico.jsp")
                    .forward(request, response);
        }

        // EDITAR
        else if ("editar".equals(accion)) {

            int id = Integer.parseInt(request.getParameter("id"));

            HistorialMedico h = dao.obtenerPorId(id);

            request.setAttribute("historialEditar", h);
            request.setAttribute("listaHistorial", dao.listar());

            request.getRequestDispatcher("/vistas/registrarhistorialmedico.jsp")
                    .forward(request, response);
        }

        // ELIMINAR
        else if ("eliminar".equals(accion)) {

            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
            } catch (Exception e) {
                e.printStackTrace();
            }

            response.sendRedirect(request.getContextPath()
                    + "/Servletregistrarhistorialmedico?accion=listar");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HistorialMedico h = new HistorialMedico();

        h.setId_usuario(Integer.parseInt(request.getParameter("txtIdUsuario")));
        h.setEnfermedad(request.getParameter("txtEnfermedad"));
        h.setDescripcion(request.getParameter("txtDescripcion"));
        h.setFecha_registro(request.getParameter("txtFechaRegistro"));

        String accion = request.getParameter("accion");

        if ("guardar".equals(accion)) {
            dao.agregar(h);
        } else if ("actualizar".equals(accion)) {
            h.setId_historial(Integer.parseInt(request.getParameter("idHistorial")));
            dao.actualizar(h);
        }

        response.sendRedirect(request.getContextPath()
                + "/Servletregistrarhistorialmedico?accion=listar");
    }
}