package Servlets;

import Controlador.UsuarioDAO;
import Controlador.ContactoEmergenciaDAO;
import Modelo.Usuario;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// ==================================================================
// ACCESO PÚBLICO A LA HOJA DE VIDA MÉDICA (CÓDIGO QR DE EMERGENCIA)
//
// No requiere inicio de sesión: cualquier persona que escanee el QR
// del paciente (por ejemplo personal médico en una emergencia) llega
// directamente a esta hoja de vida con los datos críticos.
// ==================================================================
@WebServlet(name = "ServletHojaVidaPublica", urlPatterns = {"/HojaVidaPublica"})
public class ServletHojaVidaPublica extends HttpServlet {

    private final UsuarioDAO udao = new UsuarioDAO();
    private final ContactoEmergenciaDAO cdao = new ContactoEmergenciaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String doc = request.getParameter("doc");

        if (doc == null || doc.isBlank()) {
            request.setAttribute("errorQR", "Código QR inválido: no se indicó ningún documento.");
            request.getRequestDispatcher("/vistas/perfil.jsp").forward(request, response);
            return;
        }

        Usuario paciente = udao.buscarPorDocumento(doc);

        if (paciente == null) {
            request.setAttribute("errorQR", "No se encontró ningún paciente registrado con este código.");
            request.getRequestDispatcher("/vistas/perfil.jsp").forward(request, response);
            return;
        }

        if (paciente.getActivo() == 0) {
            request.setAttribute("errorQR", "Este perfil se encuentra inactivo. Contacta al administrador de VitalBoost.");
            request.getRequestDispatcher("/vistas/perfil.jsp").forward(request, response);
            return;
        }

        request.setAttribute("perfilPaciente", paciente);
        request.setAttribute("origenAcceso", "qr");
        request.setAttribute("contactosEmergencia", cdao.listarPorUsuario(paciente.getId_usuario()));
        request.getRequestDispatcher("/vistas/perfil.jsp").forward(request, response);
    }
}
