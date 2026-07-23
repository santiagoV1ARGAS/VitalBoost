package Servlets;

import Controlador.TriajeInicialDAO;
import Modelo.TriajeInicial;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Servletregistrartriaje", urlPatterns = {"/Servletregistrartriaje"})
public class Servletregistrartriaje extends HttpServlet {

    private final TriajeInicialDAO dao = new TriajeInicialDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("editar".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                TriajeInicial t = dao.buscarPorId(id);
                request.setAttribute("registro", t);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } 
        else if ("eliminar".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
                response.sendRedirect(request.getContextPath() + "/Servletregistrartriaje?msg=eliminado");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/Servletregistrartriaje?msg=error");
                return;
            }
        }

        // Cargar lista y mostrar vista
        request.setAttribute("lista", dao.listar());
        request.getRequestDispatcher("/vistas/registrartriaje.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        try {
            TriajeInicial t = new TriajeInicial();
            t.setId_usuario(Integer.parseInt(request.getParameter("txtIdUsuario")));
            t.setNivel_dolor_escala(Integer.parseInt(request.getParameter("txtNivelDolor")));
            t.setSintoma_principal(request.getParameter("txtSintoma"));
            t.setEstado_consciencia(Integer.parseInt(request.getParameter("txtEstado")));

            if ("actualizar".equals(accion)) {
                t.setId_triaje(Integer.parseInt(request.getParameter("id")));
                dao.actualizar(t);
                response.sendRedirect(request.getContextPath() + "/Servletregistrartriaje?msg=actualizado");
            } else {
                dao.agregar(t); // O dao.insertar(t) según tu DAO
                response.sendRedirect(request.getContextPath() + "/Servletregistrartriaje?msg=guardado");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Servletregistrartriaje?msg=error");
        }
    }
}