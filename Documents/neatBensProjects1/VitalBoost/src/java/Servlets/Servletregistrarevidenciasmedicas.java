package Servlets;

import Controlador.EvidenciasMedicasDAO;
import Modelo.EvidenciasMedicas;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Servletregistrarevidenciasmedicas",
        urlPatterns = {"/Servletregistrarevidenciasmedicas"})
public class Servletregistrarevidenciasmedicas extends HttpServlet {

    EvidenciasMedicasDAO dao = new EvidenciasMedicasDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        // LISTAR
        if (accion == null || accion.equals("listar")) {

            request.setAttribute("listaEvidencias", dao.listar());

            request.getRequestDispatcher("/vistas/registrarevidenciasmedicas.jsp")
                    .forward(request, response);
        }

        // EDITAR
        else if ("editar".equals(accion)) {

            int id = Integer.parseInt(request.getParameter("id"));

            EvidenciasMedicas e = dao.obtenerPorId(id);

            request.setAttribute("evidenciaEditar", e);
            request.setAttribute("listaEvidencias", dao.listar());

            request.getRequestDispatcher("/vistas/registrarevidenciasmedicas.jsp")
                    .forward(request, response);
        }

        // ELIMINAR
        else if ("eliminar".equals(accion)) {

            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            response.sendRedirect(request.getContextPath()
                    + "/Servletregistrarevidenciasmedicas?accion=listar");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        EvidenciasMedicas e = new EvidenciasMedicas();

        e.setId_usuario(Integer.parseInt(request.getParameter("txtIdUsuario")));
        e.setUrl_archivo(request.getParameter("txtUrlArchivo"));
        e.setDescripcion_archivo(request.getParameter("txtDescripcionArchivo"));
        e.setTipo_archivo(request.getParameter("txtTipoArchivo"));

        String fecha = request.getParameter("txtFechaSubida");
        if (fecha != null && !fecha.trim().isEmpty()) {
            e.setFecha_subida(java.sql.Timestamp.valueOf(fecha + " 00:00:00"));
        } else if ("guardar".equals(accion)) {
            // Si es un nuevo registro y no envió fecha, toma la fecha/hora actual del sistema
            e.setFecha_subida(new java.sql.Timestamp(System.currentTimeMillis()));
        }

        // GUARDAR
        if ("guardar".equals(accion)) {
            dao.agregar(e);
        }

        // ACTUALIZAR
        else if ("actualizar".equals(accion)) {

            e.setId_evidencia(Integer.parseInt(request.getParameter("idEvidencia")));
            dao.actualizar(e);
        }

        response.sendRedirect(request.getContextPath()
                + "/Servletregistrarevidenciasmedicas?accion=listar");
    }
}