package Servlets;

import Controlador.UsuarioDAO;
import Controlador.ContactoEmergenciaDAO;
import Controlador.Tipo_sangreDAO;
import Modelo.Usuario;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// ==================================================================
// PANEL PRINCIPAL DEL PACIENTE
//
// Reúne todo lo que la vista dashboard.jsp necesita mostrar:
//   - Los datos actualizados del paciente (por si acaba de editarlos)
//   - Sus contactos de emergencia
//   - El catálogo de tipos de sangre (para el formulario de edición)
//   - La imagen y el enlace de su código QR de emergencia
//   - Mensajes "flash" que haya dejado ServletEditarPaciente
// ==================================================================
@WebServlet(name = "ServletDashboardPaciente", urlPatterns = {"/DashboardPaciente"})
public class ServletDashboardPaciente extends HttpServlet {

    private final UsuarioDAO udao = new UsuarioDAO();
    private final ContactoEmergenciaDAO cdao = new ContactoEmergenciaDAO();
    private final Tipo_sangreDAO sdao = new Tipo_sangreDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario sesionUsuario = (Usuario) session.getAttribute("usuarioLogueado");

        if (sesionUsuario == null) {
            response.sendRedirect(request.getContextPath() + "/ServletLogin");
            return;
        }

        // Se recarga desde la BD por si el paciente acaba de editar sus datos
        Usuario paciente = udao.buscarPorId(sesionUsuario.getId_usuario());
        if (paciente == null) {
            paciente = sesionUsuario;
        }
        session.setAttribute("usuarioLogueado", paciente);

        // -------- Enlace y código QR de la hoja de vida de emergencia --------
        String urlBase = request.getScheme() + "://"
                + request.getServerName()
                + ":" + request.getServerPort()
                + request.getContextPath();

        String urlHojaVida = urlBase + "/HojaVidaPublica?doc="
                + java.net.URLEncoder.encode(paciente.getNumero_documento(), "UTF-8");

        String qrImageUrl = "https://api.qrserver.com/v1/create-qr-code/?size=260x260&data="
                + java.net.URLEncoder.encode(urlHojaVida, "UTF-8");

        request.setAttribute("urlHojaVida", urlHojaVida);
        request.setAttribute("qrImageUrl", qrImageUrl);

        // -------- Contacto de emergencia y catálogo de tipos de sangre --------
        request.setAttribute("contactosEmergencia", cdao.listarPorUsuario(paciente.getId_usuario()));
        request.setAttribute("listaSangres", sdao.listar());

        // -------- Mensajes flash dejados por ServletEditarPaciente --------
        Object flashOk = session.getAttribute("flashSuccess");
        Object flashError = session.getAttribute("flashError");
        if (flashOk != null) {
            request.setAttribute("flashSuccess", flashOk);
            session.removeAttribute("flashSuccess");
        }
        if (flashError != null) {
            request.setAttribute("flashError", flashError);
            session.removeAttribute("flashError");
        }

        request.getRequestDispatcher("/vistas/dashboard.jsp").forward(request, response);
    }
}
