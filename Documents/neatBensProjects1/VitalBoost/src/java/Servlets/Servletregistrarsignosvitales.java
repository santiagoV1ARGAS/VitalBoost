package Servlets;

import Controlador.SignosVitalesDAO;
import Modelo.SignosVitales;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Servletregistrarsignosvitales", urlPatterns = {"/Servletregistrarsignosvitales"})
public class Servletregistrarsignosvitales extends HttpServlet {

    private final SignosVitalesDAO dao = new SignosVitalesDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("editar".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                SignosVitales sv = dao.buscarPorId(id);
                request.setAttribute("registro", sv);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        } 
        else if ("eliminar".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
                response.sendRedirect(request.getContextPath() + "/Servletregistrarsignosvitales?msg=eliminado");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/Servletregistrarsignosvitales?msg=error");
                return;
            }
        }

        // Flujo por defecto: Cargar lista y mostrar la vista
        request.setAttribute("lista", dao.listar());
        request.getRequestDispatcher("/vistas/registrarsignosvitales.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        try {
            SignosVitales sv = new SignosVitales();
            sv.setId_usuario(Integer.parseInt(request.getParameter("txtIdUsuario")));
            sv.setFrecuencia_cardiaca(Integer.parseInt(request.getParameter("txtFrecuencia")));
            sv.setPresion_arterial(request.getParameter("txtPresion"));
            sv.setSaturacion_oxigeno(Integer.parseInt(request.getParameter("txtSaturacion")));
            sv.setTemperatura(Double.parseDouble(request.getParameter("txtTemperatura")));

            if ("actualizar".equals(accion)) {
                sv.setId_signo(Integer.parseInt(request.getParameter("id")));
                dao.actualizar(sv);
                response.sendRedirect(request.getContextPath() + "/Servletregistrarsignosvitales?msg=actualizado");
            } else {
                dao.agregar(sv);
                response.sendRedirect(request.getContextPath() + "/Servletregistrarsignosvitales?msg=guardado");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/Servletregistrarsignosvitales?msg=error");
        }
    }
}