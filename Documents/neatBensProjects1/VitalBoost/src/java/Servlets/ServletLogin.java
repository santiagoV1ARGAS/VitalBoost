package Servlets;

import Controlador.UsuarioDAO;
import Modelo.Usuario;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ServletLogin", urlPatterns = {"/ServletLogin"})
public class ServletLogin extends HttpServlet {

    private final UsuarioDAO udao = new UsuarioDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        HttpSession session = request.getSession();

        if (accion == null) {
            response.sendRedirect(request.getContextPath() + "/vistas/login.jsp");
            return;
        }

        // ==========================================
        // ACCESO DIRECTO MÉDICO DE EMERGENCIA
        // ==========================================
        if ("AccesoMedico".equalsIgnoreCase(accion)) {
            Usuario medicoTemporal = new Usuario();
            medicoTemporal.setId_rol(3); // Rol 3: Médico
            medicoTemporal.setNombre_completo("Personal Médico de Emergencias");

            session.setAttribute("usuarioLogueado", medicoTemporal);

            response.sendRedirect(request.getContextPath() + "/vistas/buscarpaciente.jsp");
            return;
        }

        // ==========================================
        // BUSCAR PACIENTE (FILTRO HUELLA)
        // ==========================================
        else if ("BuscarPaciente".equalsIgnoreCase(accion)) {
            String doc = request.getParameter("txtDocumento");

            if (doc == null || doc.isBlank()) {
                request.setAttribute("errorBusqueda", "Por favor, digite un documento.");
                request.getRequestDispatcher("/vistas/buscarpaciente.jsp").forward(request, response);
                return;
            }

            Usuario paciente = udao.buscarPorDocumento(doc);

            if (paciente == null) {
                request.setAttribute("errorBusqueda", "Paciente no registrado en VitalBoost.");
                request.getRequestDispatcher("/vistas/buscarpaciente.jsp").forward(request, response);
            } else {
                request.setAttribute("docPaciente", paciente.getNumero_documento());
                request.setAttribute("nombrePaciente", paciente.getNombre_completo());

                request.getRequestDispatcher("/vistas/verificarHuella.jsp").forward(request, response);
            }
            return;
        }

        // ==========================================
        // CONFIRMAR VERIFICACIÓN BIOMÉTRICA
        // ==========================================
        else if ("ConfirmarHuella".equalsIgnoreCase(accion)) {
            String doc = request.getParameter("txtDocumentoPaciente");

            Usuario paciente = udao.buscarPorDocumento(doc);

            if (paciente != null) {
                request.setAttribute("perfilPaciente", paciente);
                request.getRequestDispatcher("/vistas/perfil.jsp").forward(request, response);
            } else {
                request.setAttribute("errorBusqueda", "Error en la autenticación del paciente.");
                request.getRequestDispatcher("/vistas/buscarpaciente.jsp").forward(request, response);
            }
            return;
        }

        // =========================
        // LOGIN TRADICIONAL
        // =========================
        else if ("Ingresar".equalsIgnoreCase(accion)) {

            String correo = request.getParameter("txtEmail");
            String clave = request.getParameter("txtPassword");
            String rol = request.getParameter("txtRol");

            boolean hayError = false;

            if (correo == null || correo.isBlank()) {
                request.setAttribute("errorEmail", "El correo es obligatorio.");
                hayError = true;
            }
            if (clave == null || clave.isBlank()) {
                request.setAttribute("errorPassword", "La contraseña es obligatoria.");
                hayError = true;
            }
            if (rol == null || rol.isBlank()) {
                request.setAttribute("errorRol", "Seleccione un rol.");
                hayError = true;
            }

            if (hayError) {
                request.setAttribute("txtEmailOld", correo);
                request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
                return;
            }

            Usuario u = udao.buscarPorEmail(correo);

            if (u == null) {
                request.setAttribute("errorEmail", "El usuario no existe.");
                request.setAttribute("txtEmailOld", correo);
                request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
                return;
            }

            if (!u.getPassword().equals(clave)) {
                request.setAttribute("errorPassword", "Contraseña incorrecta.");
                request.setAttribute("txtEmailOld", correo);
                request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
                return;
            }

            if (u.getId_rol() != Integer.parseInt(rol)) {
                request.setAttribute("errorRol", "El rol seleccionado no corresponde al usuario.");
                request.setAttribute("txtEmailOld", correo);
                request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
                return;
            }

            // LOGIN EXITOSO
            session.setAttribute("usuarioLogueado", u);

            if (u.getId_rol() == 1) { // Admin
                response.sendRedirect(request.getContextPath() + "/vistas/dashboardAdmin.jsp");
            } else if (u.getId_rol() == 2) { // Paciente
                Usuario pacienteCompleto = udao.buscarPorDocumento(u.getNumero_documento());
                session.setAttribute("usuarioLogueado", pacienteCompleto != null ? pacienteCompleto : u);
                response.sendRedirect(request.getContextPath() + "/vistas/dashboard.jsp");
            } else if (u.getId_rol() == 3) { // Médico
                response.sendRedirect(request.getContextPath() + "/vistas/buscarpaciente.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/vistas/login.jsp");
            }
            return;
        }

        // =========================
        // LOGOUT
        // =========================
        else if ("Salir".equalsIgnoreCase(accion)) {
            session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/vistas/login.jsp");
            return;
        }

        // Si no coincide ninguna acción
        response.sendRedirect(request.getContextPath() + "/vistas/login.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}