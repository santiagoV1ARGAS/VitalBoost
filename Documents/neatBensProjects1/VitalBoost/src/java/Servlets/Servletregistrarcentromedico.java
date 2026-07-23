package Servlets;

import Controlador.CentrosMedicosDAO;
import Modelo.CentrosMedicos;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Servletregistrarcentromedico",
            urlPatterns = {"/Servletregistrarcentromedico"})
public class Servletregistrarcentromedico extends HttpServlet {

    CentrosMedicosDAO dao = new CentrosMedicosDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        // LISTAR
        if (accion == null || accion.equals("listar")) {

            request.setAttribute("listaCentros", dao.listar());

            request.getRequestDispatcher("/vistas/registrarcentromedico.jsp")
                    .forward(request, response);
        }

        // EDITAR
        else if (accion.equals("editar")) {

            int id = Integer.parseInt(request.getParameter("id"));

            CentrosMedicos c = dao.obtenerPorId(id);

            request.setAttribute("centroEditar", c);
            request.setAttribute("listaCentros", dao.listar());

            request.getRequestDispatcher("/vistas/registrarcentromedico.jsp")
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
                    + "/Servletregistrarcentromedico?accion=listar");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        CentrosMedicos c = new CentrosMedicos();

        c.setId_usuario_referencia(Integer.parseInt(request.getParameter("txtIdUsuario")));
        c.setNombre_centro(request.getParameter("txtNombreCentro"));
        c.setDireccion(request.getParameter("txtDireccion"));
        c.setTelefono_urgencias(request.getParameter("txtTelefono"));
        c.setLatitud(Double.parseDouble(request.getParameter("txtLatitud")));
        c.setLongitud(Double.parseDouble(request.getParameter("txtLongitud")));

        String accion = request.getParameter("accion");

        if ("guardar".equals(accion)) {
            dao.insertar(c);
        } else if ("actualizar".equals(accion)) {
            c.setId_centro(Integer.parseInt(request.getParameter("idCentro")));
            dao.actualizar(c);
        }

        response.sendRedirect(request.getContextPath()
                + "/Servletregistrarcentromedico?accion=listar");
    }
}