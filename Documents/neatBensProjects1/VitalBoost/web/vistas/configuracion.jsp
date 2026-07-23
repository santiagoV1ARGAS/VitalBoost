
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

    <title>
        Configuración
    </title>

    <link rel="stylesheet"
          href="${ctx}/css/configuracion.css">

</head>

<body>

<div class="contenedor-admin">

    <!-- SIDEBAR -->
    <aside class="sidebar">

        <div class="logo">
            VitalBoost
        </div>

        <nav class="menu">

            <a href="${ctx}/Servletlistarusuario?accion=listar">
                Dashboard
            </a>

            <a href="${ctx}/vistas/configuracion.jsp"
               class="activo">

                Configuración Sistema

            </a>

        </nav>

    </aside>

    <!-- CONTENIDO -->
    <main class="contenido">

        <h1>
            Configuración del Sistema
        </h1>

        <div class="grid-config">

            <!-- ROLES -->
            <div class="card-config">

                <h2>Roles</h2>

                <p>
                    Gestión de roles del sistema
                </p>

                <a class="btn-config"
                   href="${ctx}/vistas/registrarRol.jsp">

                    Registrar Rol

                </a>

            </div>

            <!-- CONTACTO EMERGENCIA -->
            <div class="card-config">

                <h2>Contacto Emergencia</h2>

                <p>
                    Gestión de contactos de emergencia de usuarios
                </p>

                <a class="btn-config"
                   href="${ctx}/vistas/registrarcontactoemergencia.jsp">

                    Registrar Contacto

                </a>

            </div>

            <!-- EVIDENCIAS MEDICAS -->
            <div class="card-config">

                <h2>Evidencias Médicas</h2>

                <p>
                    Gestión de archivos médicos de usuarios
                </p>

                <a class="btn-config"
                   href="${ctx}/vistas/registrarevidenciasmedicas.jsp">

                    Registrar Evidencia

                </a>

            </div>

            <!-- HISTORIAL MEDICO -->
            <div class="card-config">

                <h2>Historial Médico</h2>

                <p>
                    Registro de antecedentes clínicos
                </p>

                <a class="btn-config"
                   href="${ctx}/vistas/registrarhistorialmedico.jsp">

                    Registrar Historial

                </a>

            </div>

            <!-- CENTROS MEDICOS -->
            <div class="card-config">

                <h2>Centros Médicos</h2>

                <p>
                    Gestión de hospitales y clínicas
                </p>

                <a class="btn-config"
                   href="${ctx}/vistas/registrarcentromedico.jsp">

                    Registrar Centro

                </a>

            </div>

            <!-- MEDICAMENTOS -->
            <div class="card-config">

                <h2>Medicamentos</h2>

                <p>
                    Gestión de medicamentos médicos
                </p>

                <a class="btn-config"
                   href="${ctx}/vistas/registrarmedicamentos.jsp">

                    Registrar Medicamento

                </a>

            </div>

            <!-- TOMA MEDICAMENTOS -->
            <div class="card-config">

                <h2>Registro Medicamentos</h2>

                <p>
                    Gestión de tomas de medicamentos
                </p>

                <a class="btn-config"
                   href="${ctx}/vistas/registrartomamedicamento.jsp">

                    Registrar Toma

                </a>

            </div>

            <!-- SIGNOS VITALES -->
            <div class="card-config">

                <h2>Signos Vitales</h2>

                <p>
                    Gestión de signos vitales clínicos
                </p>

                <a class="btn-config"
                   href="${ctx}/vistas/registrarsignosvitales.jsp">

                    Registrar Signos

                </a>

            </div>

            <!-- TIPO DOCUMENTO -->
            <div class="card-config">

                <h2>Tipo Documento</h2>

                <p>
                    Gestión de tipos documentales
                </p>

                <a class="btn-config"
                   href="${ctx}/vistas/registrartipodocumento.jsp">

                    Registrar Tipo

                </a>

            </div>

            <!-- TIPO SANGRE -->
            <div class="card-config">

                <h2>Tipo Sangre</h2>

                <p>
                    Gestión de tipos de sangre
                </p>

                <a class="btn-config"
                   href="${ctx}/vistas/registrartiposangre.jsp">

                    Registrar Tipo

                </a>

            </div>

            <!-- TRIAJE -->
            <div class="card-config">

                <h2>Triaje Inicial</h2>

                <p>
                    Gestión de evaluaciones iniciales
                </p>

                <a class="btn-config"
                   href="${ctx}/vistas/registrartriaje.jsp">

                    Registrar Triaje

                </a>

            </div>

            <!-- USUARIOS -->
            <div class="card-config">

                <h2>Usuarios</h2>

                <p>
                    Gestión de usuarios registrados
                </p>

                <a class="btn-config"
                   href="${ctx}/vistas/registrarusuario.jsp">

                    Registrar Usuario

                </a>

            </div>

        </div>

    </main>

</div>

</body>
</html>

