package Servlets;

import Controlador.Tipo_DocumentoDAO;
import Modelo.Tipo_Documento;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Servletregistrartipodocumento", urlPatterns = {"/Servletregistrartipodocumento"})
public class Servletregistrartipodocumento extends HttpServlet {

    private final Tipo_DocumentoDAO dao = new Tipo_DocumentoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("editar".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Tipo_Documento td = dao.buscarPorId(id);
                request.setAttribute("registro", td);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } 
        else if ("eliminar".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
                response.sendRedirect(request.getContextPath() + "/Servletregistrartipodocumento?msg=eliminado");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/Servletregistrartipodocumento?msg=error");
                return;
            }
        }

        // Flujo principal: Listar registros y mostrar la vista
        request.setAttribute("lista", dao.listar());
        request.getRequestDispatcher("/vistas/registrartipodocumento.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        try {
            Tipo_Documento td = new Tipo_Documento();
            td.setDescripcion_tipo_documento(request.getParameter("txtDescripcion"));

            if ("actualizar".equals(accion)) {
                td.setId_tipo_documento(Integer.parseInt(request.getParameter("id")));
                dao.actualizar(td);
                response.sendRedirect(request.getContextPath() + "/Servletregistrartipodocumento?msg=actualizado");
            } else {
                dao.insertar(td);
                response.sendRedirect(request.getContextPath() + "/Servletregistrartipodocumento?msg=guardado");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Servletregistrartipodocumento?msg=error");
        }
    }
}