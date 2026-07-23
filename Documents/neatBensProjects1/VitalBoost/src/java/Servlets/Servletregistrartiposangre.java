package Servlets;

import Controlador.Tipo_sangreDAO;
import Modelo.Tipo_sangre;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Servletregistrartiposangre", urlPatterns = {"/Servletregistrartiposangre"})
public class Servletregistrartiposangre extends HttpServlet {

    private final Tipo_sangreDAO dao = new Tipo_sangreDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("editar".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                // Si en tu DAO el método de buscar se llama diferente (ej: listarId), ajusta el nombre aquí
                Tipo_sangre t = dao.buscarPorId(id); 
                request.setAttribute("registro", t);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } 
        else if ("eliminar".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
                response.sendRedirect(request.getContextPath() + "/Servletregistrartiposangre?msg=eliminado");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/Servletregistrartiposangre?msg=error");
                return;
            }
        }

        // Flujo principal: Cargar lista y reenviar al JSP
        request.setAttribute("lista", dao.listar());
        request.getRequestDispatcher("/vistas/registrartiposangre.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        try {
            Tipo_sangre t = new Tipo_sangre();
            t.setNombre_tipo(request.getParameter("txtNombreTipo"));

            if ("actualizar".equals(accion)) {
                t.setId_tipo_sangre(Integer.parseInt(request.getParameter("id")));
                dao.actualizar(t);
                response.sendRedirect(request.getContextPath() + "/Servletregistrartiposangre?msg=actualizado");
            } else {
                dao.insertar(t);
                response.sendRedirect(request.getContextPath() + "/Servletregistrartiposangre?msg=guardado");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Servletregistrartiposangre?msg=error");
        }
    }
}