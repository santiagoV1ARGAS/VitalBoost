package Servlets;

import Controlador.UsuarioDAO;
import Modelo.Usuario;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Servletregistrarusuario", urlPatterns = {"/Servletregistrarusuario"})
public class Servletregistrarusuario extends HttpServlet {

    private final UsuarioDAO dao = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("editar".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Usuario u = dao.buscarPorId(id);
                request.setAttribute("usuarioEdit", u);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } 
        else if ("eliminar".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
                response.sendRedirect(request.getContextPath() + "/Servletregistrarusuario?msg=eliminado");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/Servletregistrarusuario?msg=error");
                return;
            }
        }

        request.setAttribute("lista", dao.listar());
        request.getRequestDispatcher("/vistas/registrarusuario.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        try {
            Usuario u = new Usuario();
            u.setId_rol(Integer.parseInt(request.getParameter("txtIdRol")));
            u.setId_tipo_documento(Integer.parseInt(request.getParameter("txtIdTipoDocumento")));
            u.setId_tipo_sangre(Integer.parseInt(request.getParameter("txtIdTipoSangre")));
            u.setNumero_documento(request.getParameter("txtNumeroDocumento"));
            u.setNombre_completo(request.getParameter("txtNombre"));
            u.setEmail(request.getParameter("txtEmail"));
            u.setPassword(request.getParameter("txtPassword"));
            u.setFecha_nacimiento(request.getParameter("txtFechaNacimiento"));
            u.setAlergias_conocidas(request.getParameter("txtAlergias"));

            if ("actualizar".equals(accion)) {
                u.setId_usuario(Integer.parseInt(request.getParameter("id")));
                dao.actualizar(u);
                response.sendRedirect(request.getContextPath() + "/Servletregistrarusuario?msg=actualizado");
            } else {
                dao.insertar(u);
                response.sendRedirect(request.getContextPath() + "/Servletregistrarusuario?msg=guardado");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Servletregistrarusuario?msg=error");
        }
    }
}