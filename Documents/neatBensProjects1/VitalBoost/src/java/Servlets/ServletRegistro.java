package Servlets;

import Controlador.Tipo_DocumentoDAO;
import Controlador.Tipo_sangreDAO;
import Controlador.UsuarioDAO;
import Controlador.RolesDAO;

import Modelo.Usuario;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ServletRegistro", urlPatterns = {"/ServletRegistro"})
public class ServletRegistro extends HttpServlet {

    UsuarioDAO udao = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("🔥 ENTRO AL SERVLET");

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
            String numeroDocumento = request.getParameter("txtNumeroDocumento");

            String tipoDoc = request.getParameter("txtIdTipoDoc");
            String tipoSangre = request.getParameter("txtIdSangre");
            String rol = request.getParameter("txtIdRol");

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
            // VALIDAR ROL
            // =========================

            if (rol == null || rol.isBlank()) {

                request.setAttribute("errorRol",
                        "Seleccione un rol.");

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

                request.setAttribute("listaRoles",
                        new RolesDAO().listar());

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
            u.setNumero_documento(numeroDocumento);

            u.setId_tipo_documento(Integer.parseInt(tipoDoc));
            u.setId_tipo_sangre(Integer.parseInt(tipoSangre));

            u.setId_rol(Integer.parseInt(rol));

            // =========================
            // INSERTAR
            // =========================

            int r = udao.insertar(u);

            if (r > 0) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/vistas/dashboard.jsp"
                );

            } else {

                request.setAttribute("error",
                        "No se pudo registrar el usuario.");

                request.setAttribute("listaDocumentos",
                        new Tipo_DocumentoDAO().listar());

                request.setAttribute("listaSangres",
                        new Tipo_sangreDAO().listar());

                request.setAttribute("listaRoles",
                        new RolesDAO().listar());

                request.getRequestDispatcher("/vistas/registro.jsp")
                        .forward(request, response);
            }

        } catch (Exception e) {

            System.out.println("🔥 ERROR REGISTRO:");
            e.printStackTrace();

            request.setAttribute("error", e.getMessage());

            request.setAttribute("listaDocumentos",
                    new Tipo_DocumentoDAO().listar());

            request.setAttribute("listaSangres",
                    new Tipo_sangreDAO().listar());

            request.setAttribute("listaRoles",
                    new RolesDAO().listar());

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

        request.setAttribute("listaRoles",
                new RolesDAO().listar());

        request.getRequestDispatcher("/vistas/registro.jsp")
                .forward(request, response);
    }
}