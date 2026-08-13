package Servlets;

import Controlador.UsuarioDAO;
import Controlador.RolesDAO;
import Controlador.ContactoEmergenciaDAO;
import Modelo.Usuario;
import Modelo.Roles;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ServletLogin", urlPatterns = {"/ServletLogin"})
public class ServletLogin extends HttpServlet {

    private final UsuarioDAO udao = new UsuarioDAO();
    private final RolesDAO rdao = new RolesDAO();
    private final ContactoEmergenciaDAO cdao = new ContactoEmergenciaDAO();

    // ==================================================================
    // NORMALIZAR NOMBRE DE ROL (sin tildes, sin espacios extra, minúsculas)
    //
    // Los roles se administran dinámicamente desde la base de datos
    // (ver ServletregistrarRol), así que su id_rol puede cambiar según
    // el orden en que se crearon. Por eso NUNCA se debe asumir que
    // Admin=1, Paciente=2, Médico=3: hay que identificar el rol por su
    // NOMBRE, que es el dato estable y visible para el administrador.
    // ==================================================================
    private String normalizar(String texto) {
        if (texto == null) {
            return "";
        }
        String sinTildes = java.text.Normalizer.normalize(texto.trim(), java.text.Normalizer.Form.NFD)
                .replaceAll("\\p{M}", "");
        return sinTildes.toLowerCase();
    }

    private Roles rolPorId(int idRol) {
        return rdao.listar().stream()
                .filter(r -> r.getId_rol() == idRol)
                .findFirst()
                .orElse(null);
    }

    // ==================================================================
    // ROLES DISPONIBLES PARA INICIAR SESIÓN CON USUARIO/CONTRASEÑA
    //
    // Se muestran todos los roles registrados, incluyendo "Paciente":
    // aunque el paciente normalmente entra por su QR de emergencia,
    // también puede iniciar sesión con su correo y contraseña si lo
    // prefiere (el flujo de éxito ya lo redirige a su dashboard).
    // ==================================================================
    private List<Roles> rolesLoginDisponibles() {
        return rdao.listar();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        HttpSession session = request.getSession();

        if (accion == null) {
            request.setAttribute("listaRoles", rolesLoginDisponibles());
            request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
            return;
        }

        // ==========================================
        // BUSCAR PACIENTE (FILTRO HUELLA)
        // ==========================================
        if ("BuscarPaciente".equalsIgnoreCase(accion)) {
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
                request.setAttribute("origenAcceso", "medico");
                request.setAttribute("contactosEmergencia", cdao.listarPorUsuario(paciente.getId_usuario()));
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
            String terminos = request.getParameter("chkTerminos");

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
            if (terminos == null) {
                request.setAttribute("errorTerminos", "Debes aceptar los términos y condiciones para continuar.");
                hayError = true;
            } else {
                request.setAttribute("chkTerminosOld", terminos);
            }

            if (hayError) {
                request.setAttribute("txtEmailOld", correo);
                request.setAttribute("listaRoles", rolesLoginDisponibles());
                request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
                return;
            }

            Usuario u = udao.buscarPorEmail(correo);

            if (u == null) {
                request.setAttribute("errorEmail", "El usuario no existe.");
                request.setAttribute("txtEmailOld", correo);
                request.setAttribute("listaRoles", rolesLoginDisponibles());
                request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
                return;
            }

            if (!u.getPassword().equals(clave)) {
                request.setAttribute("errorPassword", "Contraseña incorrecta.");
                request.setAttribute("txtEmailOld", correo);
                request.setAttribute("listaRoles", rolesLoginDisponibles());
                request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
                return;
            }

            if (u.getActivo() == 0) {
                request.setAttribute("errorEmail", "Este usuario está inactivo. Contacta al administrador.");
                request.setAttribute("txtEmailOld", correo);
                request.setAttribute("listaRoles", rolesLoginDisponibles());
                request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
                return;
            }

            if (u.getId_rol() != Integer.parseInt(rol)) {
                request.setAttribute("errorRol", "El rol seleccionado no corresponde al usuario.");
                request.setAttribute("txtEmailOld", correo);
                request.setAttribute("listaRoles", rolesLoginDisponibles());
                request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
                return;
            }

            // LOGIN EXITOSO
            session.setAttribute("usuarioLogueado", u);

            Roles rolUsuario = rolPorId(u.getId_rol());
            String nombreRol = normalizar(rolUsuario != null ? rolUsuario.getNombre_rol() : "");

            if (nombreRol.equals("administrador") || nombreRol.equals("admin")) {
                response.sendRedirect(request.getContextPath() + "/vistas/dashboardAdmin.jsp");
            } else if (nombreRol.equals("paciente")) {
                Usuario pacienteCompleto = udao.buscarPorDocumento(u.getNumero_documento());
                session.setAttribute("usuarioLogueado", pacienteCompleto != null ? pacienteCompleto : u);
                response.sendRedirect(request.getContextPath() + "/DashboardPaciente");
            } else if (nombreRol.equals("medico")) {
                response.sendRedirect(request.getContextPath() + "/vistas/buscarpaciente.jsp");
            } else {
                // Rol reconocido en la base de datos pero sin un panel asignado
                // todavía (por ejemplo un rol nuevo creado por el administrador).
                request.setAttribute("errorRol",
                        "Tu rol (" + (rolUsuario != null ? rolUsuario.getNombre_rol() : "desconocido")
                        + ") no tiene un panel asignado. Contacta al administrador del sistema.");
                request.setAttribute("txtEmailOld", correo);
                request.setAttribute("listaRoles", rolesLoginDisponibles());
                request.getRequestDispatcher("/vistas/login.jsp").forward(request, response);
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
            response.sendRedirect(request.getContextPath() + "/ServletLogin");
            return;
        }

        // Si no coincide ninguna acción
        response.sendRedirect(request.getContextPath() + "/ServletLogin");
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