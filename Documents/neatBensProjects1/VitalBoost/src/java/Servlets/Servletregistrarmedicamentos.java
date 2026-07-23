package Servlets;

import Controlador.MedicamentosDAO;
import Modelo.Medicamentos;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Servletregistrarmedicamentos",
        urlPatterns = {"/Servletregistrarmedicamentos"})
public class Servletregistrarmedicamentos extends HttpServlet {

    MedicamentosDAO dao = new MedicamentosDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        // LISTAR
        if (accion == null || accion.equals("listar")) {

            request.setAttribute("listaMedicamentos", dao.listar());

            request.getRequestDispatcher("/vistas/registrarmedicamentos.jsp")
                    .forward(request, response);
        }

        // EDITAR
        else if ("editar".equals(accion)) {

            int id = Integer.parseInt(request.getParameter("id"));

            Medicamentos m = dao.obtenerPorId(id);

            request.setAttribute("medEditar", m);
            request.setAttribute("listaMedicamentos", dao.listar());

            request.getRequestDispatcher("/vistas/registrarmedicamentos.jsp")
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
                    + "/Servletregistrarmedicamentos?accion=listar");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        Medicamentos m = new Medicamentos();

        m.setNombre_comun(request.getParameter("txtNombreComun"));
        m.setUso_para(request.getParameter("txtUsoPara"));
        m.setIndicaciones(request.getParameter("txtIndicaciones"));
        m.setContraindicaciones(request.getParameter("txtContraindicaciones"));
        m.setAdvertencia_critica(request.getParameter("txtAdvertencia"));

        String accion = request.getParameter("accion");

        if ("guardar".equals(accion)) {
            dao.agregar(m);
        } else if ("actualizar".equals(accion)) {
            m.setId_medicamento(Integer.parseInt(request.getParameter("idMedicamento")));
            dao.actualizar(m);
        }

        response.sendRedirect(request.getContextPath()
                + "/Servletregistrarmedicamentos?accion=listar");
    }
}