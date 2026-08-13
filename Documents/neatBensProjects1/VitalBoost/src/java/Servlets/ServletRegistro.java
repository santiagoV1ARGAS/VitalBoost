package Servlets;

import Controlador.Tipo_DocumentoDAO;
import Controlador.Tipo_sangreDAO;
import Controlador.UsuarioDAO;
import Controlador.RolesDAO;
import Controlador.ContactoEmergenciaDAO;

import Modelo.Usuario;
import Modelo.Roles;
import Modelo.ContactoEmergencia;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ServletRegistro", urlPatterns = {"/ServletRegistro"})
public class ServletRegistro extends HttpServlet {

    UsuarioDAO udao = new UsuarioDAO();
    RolesDAO rdao = new RolesDAO();
    ContactoEmergenciaDAO cdao = new ContactoEmergenciaDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {

            // =========================
            // RECIBIR DATOS
            // =========================

            String nombre = request.getParameter("txtNombre");
            String email = request.getParameter("txtEmail");
            String password = request.getParameter("txtPassword");
            String fecha = request.getParameter("txtFecha");
            String alergias = request.getParameter("txtAlergias");
            String eps = request.getParameter("txtEps");
            String medicamentos = request.getParameter("txtMedicamentos");
            String numeroDocumento = request.getParameter("txtNumeroDocumento");

            String tipoDoc = request.getParameter("txtIdTipoDoc");
            String tipoSangre = request.getParameter("txtIdSangre");

            String nombreContacto = request.getParameter("txtNombreContacto");
            String parentescoContacto = request.getParameter("txtParentescoContacto");
            String telefonoContacto = request.getParameter("txtTelefonoContacto");

            // El registro público siempre corresponde al rol Paciente.
            // El único rol que inicia sesión con credenciales es el Administrador.
            // Se busca el rol por NOMBRE porque los roles se administran
            // libremente desde el panel de admin y su id puede variar.
            Roles rolPaciente = rdao.obtenerPorNombre("Paciente");

            if (rolPaciente == null) {

                request.setAttribute("error",
                        "No existe un rol 'Paciente' configurado en el sistema. "
                        + "Contacta al administrador.");

                request.setAttribute("listaDocumentos",
                        new Tipo_DocumentoDAO().listar());

                request.setAttribute("listaSangres",
                        new Tipo_sangreDAO().listar());

                request.getRequestDispatcher("/vistas/registro.jsp")
                        .forward(request, response);

                return;
            }

            boolean hayError = false;

            // =========================
            // VALIDAR NOMBRE
            // =========================

            if (nombre == null || nombre.isBlank()) {

                request.setAttribute("errorNombre",
                        "El nombre es obligatorio.");

                hayError = true;
            }

            // =========================
            // VALIDAR EMAIL
            // =========================

            if (email == null || email.isBlank()) {

                request.setAttribute("errorEmail",
                        "El correo es obligatorio.");

                hayError = true;
            }

            // =========================
            // VALIDAR PASSWORD
            // =========================

            if (password == null || password.length() < 6) {

                request.setAttribute("errorPassword",
                        "La contraseña debe tener mínimo 6 caracteres.");

                hayError = true;
            }

            // =========================
            // VALIDAR DOCUMENTO
            // =========================

            if (numeroDocumento == null || numeroDocumento.isBlank()) {

                request.setAttribute("errorDocumento",
                        "El documento es obligatorio.");

                hayError = true;
            }

            // =========================
            // VALIDAR FECHA
            // =========================

            if (fecha == null || fecha.isBlank()) {

                request.setAttribute("errorFecha",
                        "La fecha es obligatoria.");

                hayError = true;
            }

            // =========================
            // VALIDAR TIPO DOC
            // =========================

            if (tipoDoc == null || tipoDoc.isBlank()) {

                request.setAttribute("errorTipoDoc",
                        "Seleccione un tipo de documento.");

                hayError = true;
            }

            // =========================
            // VALIDAR SANGRE
            // =========================

            if (tipoSangre == null || tipoSangre.isBlank()) {

                request.setAttribute("errorSangre",
                        "Seleccione un tipo de sangre.");

                hayError = true;
            }

            // =========================
            // VALIDAR CONTACTO DE EMERGENCIA
            // =========================

            if (nombreContacto == null || nombreContacto.isBlank()) {

                request.setAttribute("errorNombreContacto",
                        "El nombre del contacto de emergencia es obligatorio.");

                hayError = true;
            }

            if (telefonoContacto == null || telefonoContacto.isBlank()) {

                request.setAttribute("errorTelefonoContacto",
                        "El número de emergencia es obligatorio.");

                hayError = true;
            }

            // =========================
            // SI HAY ERRORES
            // =========================

            if (hayError) {

                request.setAttribute("listaDocumentos",
                        new Tipo_DocumentoDAO().listar());

                request.setAttribute("listaSangres",
                        new Tipo_sangreDAO().listar());

                request.getRequestDispatcher("/vistas/registro.jsp")
                        .forward(request, response);

                return;
            }

            // =========================
            // CREAR OBJETO
            // =========================

            Usuario u = new Usuario();

            u.setNombre_completo(nombre);
            u.setEmail(email);
            u.setPassword(password);
            u.setFecha_nacimiento(fecha);
            u.setAlergias_conocidas(alergias);
            u.setEps(eps);
            u.setMedicamentos_actuales(medicamentos);
            u.setNumero_documento(numeroDocumento);

            u.setId_tipo_documento(Integer.parseInt(tipoDoc));
            u.setId_tipo_sangre(Integer.parseInt(tipoSangre));

            u.setId_rol(rolPaciente.getId_rol());

            // =========================
            // INSERTAR
            // =========================

            int r = udao.insertar(u);

            if (r > 0) {

                // ==================================================
                // GUARDAR CONTACTO DE EMERGENCIA
                //
                // Se busca el usuario recién creado por su número de
                // documento (único) para obtener su id_usuario, ya que
                // el INSERT no retorna la llave generada.
                // ==================================================
                Usuario pacienteCreado = udao.buscarPorDocumento(numeroDocumento);

                if (pacienteCreado != null) {
                    ContactoEmergencia contacto = new ContactoEmergencia();
                    contacto.setId_usuario(pacienteCreado.getId_usuario());
                    contacto.setNombre_contacto(nombreContacto);
                    contacto.setParentesco(parentescoContacto);
                    contacto.setTelefono(telefonoContacto);

                    cdao.agregar(contacto);
                }

                // ==================================================
                // REGISTRO EXITOSO: en vez de iniciar sesión, se
                // genera el enlace/QR de la Hoja de Vida de emergencia.
                // El paciente NO necesita volver a iniciar sesión;
                // basta con guardar/escanear su código QR.
                // ==================================================

                String urlBase = request.getScheme() + "://"
                        + request.getServerName()
                        + ":" + request.getServerPort()
                        + request.getContextPath();

                String urlHojaVida = urlBase + "/HojaVidaPublica?doc="
                        + java.net.URLEncoder.encode(numeroDocumento, "UTF-8");

                String qrImageUrl = "https://api.qrserver.com/v1/create-qr-code/?size=260x260&data="
                        + java.net.URLEncoder.encode(urlHojaVida, "UTF-8");

                request.setAttribute("nombrePaciente", nombre);
                request.setAttribute("urlHojaVida", urlHojaVida);
                request.setAttribute("qrImageUrl", qrImageUrl);

                request.getRequestDispatcher("/vistas/registroExitoso.jsp")
                        .forward(request, response);

            } else {

                request.setAttribute("error",
                        "No se pudo registrar el usuario.");

                request.setAttribute("listaDocumentos",
                        new Tipo_DocumentoDAO().listar());

                request.setAttribute("listaSangres",
                        new Tipo_sangreDAO().listar());

                request.getRequestDispatcher("/vistas/registro.jsp")
                        .forward(request, response);
            }

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute("error", e.getMessage());

            request.setAttribute("listaDocumentos",
                    new Tipo_DocumentoDAO().listar());

            request.setAttribute("listaSangres",
                    new Tipo_sangreDAO().listar());

            request.getRequestDispatcher("/vistas/registro.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("listaDocumentos",
                new Tipo_DocumentoDAO().listar());

        request.setAttribute("listaSangres",
                new Tipo_sangreDAO().listar());

        request.getRequestDispatcher("/vistas/registro.jsp")
                .forward(request, response);
    }
}