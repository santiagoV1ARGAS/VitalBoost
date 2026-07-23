package Servlets;

import Controlador.RegistroTomaMedicamentosDAO;
import Modelo.RegistroTomaMedicamentos;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Servletregistrartomamedicamento", urlPatterns = {"/Servletregistrartomamedicamento"})
public class Servletregistrartomamedicamento extends HttpServlet {

    private final RegistroTomaMedicamentosDAO dao = new RegistroTomaMedicamentosDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("editar".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                RegistroTomaMedicamentos rtm = dao.buscarPorId(id);
                request.setAttribute("registro", rtm);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } 
        else if ("eliminar".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
                response.sendRedirect(request.getContextPath() + "/Servletregistrartomamedicamento?msg=eliminado");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/Servletregistrartomamedicamento?msg=error");
                return;
            }
        }

        // Cargar la lista completa y despachar a la vista JSP
        request.setAttribute("lista", dao.listar());
        request.getRequestDispatcher("/vistas/registrartomamedicamento.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        try {
            RegistroTomaMedicamentos rtm = new RegistroTomaMedicamentos();
            rtm.setId_usuario(Integer.parseInt(request.getParameter("txtIdUsuario")));
            rtm.setId_medicamento(Integer.parseInt(request.getParameter("txtIdMedicamento")));
            rtm.setNombre_sustancia_manual(request.getParameter("txtSustancia"));
            rtm.setDosis_tomada(request.getParameter("txtDosis"));

            if ("actualizar".equals(accion)) {
                rtm.setId_registro(Integer.parseInt(request.getParameter("id")));
                dao.actualizar(rtm);
                response.sendRedirect(request.getContextPath() + "/Servletregistrartomamedicamento?msg=actualizado");
            } else {
                dao.agregar(rtm); // O dao.insertar(rtm) según el método de tu DAO
                response.sendRedirect(request.getContextPath() + "/Servletregistrartomamedicamento?msg=guardado");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Servletregistrartomamedicamento?msg=error");
        }
    }
}