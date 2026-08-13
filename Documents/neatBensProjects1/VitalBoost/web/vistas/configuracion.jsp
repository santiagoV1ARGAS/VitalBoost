
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>
        Configuración
    </title>

    <link rel="stylesheet"
          href="${ctx}/css/configuracion.css">

    <link rel="stylesheet"
          href="${ctx}/css/dashboardAdmin.css">
    <link rel="stylesheet" href="${ctx}/css/global.css">

</head>

<body>

<%@ include file="/includes/loader.jspf" %>

<div class="contenedor-admin">

    <!-- SIDEBAR -->
    <aside class="sidebar">

        <div class="logo">
            VitalBoost
        </div>

        <nav class="menu">

            <a href="${ctx}/Servletlistarusuario?accion=listar">
                Usuarios
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
                   href="${ctx}/ServletregistrarRol">

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
                   href="${ctx}/Servletregistrarcontactoemergencia">

                    Registrar Contacto

                </a>

            </div>

            <!-- TIPO DOCUMENTO -->
            <div class="card-config">

                <h2>Tipo Documento</h2>

                <p>
                    Gestión de tipos documentales
                </p>

                <a class="btn-config"
                   href="${ctx}/Servletregistrartipodocumento">

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
                   href="${ctx}/Servletregistrartiposangre">

                    Registrar Tipo

                </a>

            </div>

            <!-- USUARIOS -->
            <div class="card-config">

                <h2>Usuarios</h2>

                <p>
                    Gestión de usuarios registrados
                </p>

                <a class="btn-config"
                   href="${ctx}/Servletregistrarusuario">

                    Registrar Usuario

                </a>

                <a class="btn-config"
                   style="margin-top: 8px;"
                   href="${ctx}/Servletlistarusuario?accion=listarConfig">

                    Activar / Desactivar Usuarios

                </a>

            </div>

        </div>

        <!-- =====================================
             GESTIÓN DE USUARIOS (ACTIVAR / DESACTIVAR)
             Solo se muestra cuando se entra por
             "Activar / Desactivar Usuarios"
        ====================================== -->

        <c:if test="${not empty listaUsuarios}">

            <section class="tabla-contenedor" style="margin-top: 25px;">

                <div class="tabla-header">

                    <div>
                        <h2>Usuarios Registrados</h2>
                        <p class="descripcion-tabla">
                            Activa o desactiva usuarios desde Configuración del Sistema
                        </p>
                    </div>

                    <a href="${ctx}/Servletregistrarusuario" class="btn-agregar">
                        + Nuevo Usuario
                    </a>

                </div>

                <div class="tabla-responsive">

                    <table>

                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Correo</th>
                                <th>Documento</th>
                                <th>Rol</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>

                        <tbody>

                            <c:choose>

                                <c:when test="${not empty listaUsuarios}">

                                    <c:forEach var="u" items="${listaUsuarios}">

                                        <tr>

                                            <td>${u.nombre_completo}</td>
                                            <td>${u.email}</td>
                                            <td>${u.numero_documento}</td>
                                            <td>${u.nombreRol}</td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${u.activo == 0}">
                                                        <span class="badge-inactivo">Inactivo</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge-activo">Activo</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td>
                                                <div class="acciones">

                                                    <c:choose>
                                                        <c:when test="${u.activo == 0}">
                                                            <a href="javascript:void(0);"
                                                               class="btn-editar"
                                                               onclick="confirmarAccion('${ctx}/Servletlistarusuario?accion=activar&id=${u.id_usuario}&origen=config', '¿Activar nuevamente a este usuario?')">

                                                                Activar

                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="javascript:void(0);"
                                                               class="btn-eliminar"
                                                               onclick="confirmarAccion('${ctx}/Servletlistarusuario?accion=eliminar&id=${u.id_usuario}&origen=config', '¿Desactivar a este usuario? Podrás reactivarlo luego.')">

                                                                Desactivar

                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:if test="${fn:toLowerCase(u.nombreRol) == 'paciente'}">
                                                        <a href="${ctx}/HojaVidaPublica?doc=${u.numero_documento}"
                                                           class="btn-perfil"
                                                           target="_blank">

                                                            Ver QR

                                                        </a>
                                                    </c:if>

                                                </div>
                                            </td>

                                        </tr>

                                    </c:forEach>

                                </c:when>

                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="sin-registros">
                                            No hay usuarios registrados
                                        </td>
                                    </tr>
                                </c:otherwise>

                            </c:choose>

                        </tbody>

                    </table>

                </div>

            </section>

        </c:if>

    </main>

    <script>
        function confirmarAccion(url, mensaje) {
            if (confirm(mensaje)) {
                window.location.href = url;
            }
        }
    </script>

</div>

</body>
</html>

