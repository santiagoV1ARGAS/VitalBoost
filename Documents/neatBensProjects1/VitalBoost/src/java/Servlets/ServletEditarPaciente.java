package Servlets;

import Controlador.UsuarioDAO;
import Controlador.ContactoEmergenciaDAO;
import Modelo.Usuario;
import Modelo.ContactoEmergencia;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// ==================================================================
// EDICIÓN DE DATOS DEL PACIENTE (DESDE SU PROPIO PANEL)
//
// Solo permite editar los datos del usuario que tiene la sesión
// abierta: nombre, correo, fecha de nacimiento, tipo de sangre,
// alergias y su contacto de emergencia principal. El número de
// documento, la contraseña y el rol NO se tocan aquí.
// ==================================================================
@WebServlet(name = "ServletEditarPaciente", urlPatterns = {"/EditarPaciente"})
public class ServletEditarPaciente extends HttpServlet {

    private final UsuarioDAO udao = new UsuarioDAO();
    private final ContactoEmergenciaDAO cdao = new ContactoEmergenciaDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Usuario sesionUsuario = (Usuario) session.getAttribute("usuarioLogueado");

        if (sesionUsuario == null) {
            response.sendRedirect(request.getContextPath() + "/ServletLogin");
            return;
        }

        String nombre = request.getParameter("txtNombre");
        String email = request.getParameter("txtEmail");
        String fecha = request.getParameter("txtFecha");
        String idSangre = request.getParameter("txtIdSangre");
        String alergias = request.getParameter("txtAlergias");
        String eps = request.getParameter("txtEps");
        String medicamentos = request.getParameter("txtMedicamentos");
        String nombreContacto = request.getParameter("txtNombreContacto");
        String parentescoContacto = request.getParameter("txtParentescoContacto");
        String telefonoContacto = request.getParameter("txtTelefonoContacto");

        if (nombre == null || nombre.isBlank()
                || email == null || email.isBlank()
                || fecha == null || fecha.isBlank()
                || idSangre == null || idSangre.isBlank()) {

            session.setAttribute("flashError", "Completa nombre, correo, fecha de nacimiento y tipo de sangre.");
            response.sendRedirect(request.getContextPath() + "/DashboardPaciente");
            return;
        }

        // Se parte del registro completo en BD para no perder datos que
        // este formulario no edita (número de documento, password, rol...)
        Usuario paciente = udao.buscarPorId(sesionUsuario.getId_usuario());
        if (paciente == null) {
            paciente = sesionUsuario;
        }

        paciente.setNombre_completo(nombre.trim());
        paciente.setEmail(email.trim());
        paciente.setFecha_nacimiento(fecha.trim());
        paciente.setAlergias_conocidas(alergias != null ? alergias.trim() : "");
        paciente.setEps(eps != null ? eps.trim() : "");
        paciente.setMedicamentos_actuales(medicamentos != null ? medicamentos.trim() : "");

        try {
            paciente.setId_tipo_sangre(Integer.parseInt(idSangre));
        } catch (NumberFormatException e) {
            session.setAttribute("flashError", "Selecciona un tipo de sangre válido.");
            response.sendRedirect(request.getContextPath() + "/DashboardPaciente");
            return;
        }

        boolean actualizado = udao.actualizar(paciente);

        // -------- Contacto de emergencia (actualiza el primero o lo crea) --------
        if (nombreContacto != null && !nombreContacto.isBlank()
                && telefonoContacto != null && !telefonoContacto.isBlank()) {

            List<ContactoEmergencia> contactos = cdao.listarPorUsuario(paciente.getId_usuario());

            ContactoEmergencia contacto = !contactos.isEmpty() ? contactos.get(0) : new ContactoEmergencia();
            contacto.setId_usuario(paciente.getId_usuario());
            contacto.setNombre_contacto(nombreContacto.trim());
            contacto.setParentesco(parentescoContacto != null ? parentescoContacto.trim() : "");
            contacto.setTelefono(telefonoContacto.trim());

            if (!contactos.isEmpty()) {
                cdao.actualizar(contacto);
            } else {
                cdao.agregar(contacto);
            }
        }

        if (actualizado) {
            session.setAttribute("usuarioLogueado", paciente);
            session.setAttribute("flashSuccess", "Tus datos se actualizaron correctamente.");
        } else {
            session.setAttribute("flashError", "No se pudieron guardar los cambios. Intenta de nuevo.");
        }

        response.sendRedirect(request.getContextPath() + "/DashboardPaciente");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/DashboardPaciente");
    }
}
