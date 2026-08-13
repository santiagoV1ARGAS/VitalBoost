<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<c:if test="${empty usuarioLogueado}">
    <c:redirect url="/ServletLogin"/>
</c:if>

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Panel Administrador</title>

    <link rel="stylesheet"
          href="${ctx}/css/dashboardAdmin.css">
    <link rel="stylesheet" href="${ctx}/css/global.css">

</head>

<body>

<div class="contenedor-admin">

    <!-- =====================================
         SIDEBAR
    ====================================== -->

    <aside class="sidebar">

        <div class="sidebar-brand">
            <span class="brand-icon">
                <svg viewBox="0 0 24 24" fill="currentColor"><path d="M10.5 3h3v6.5H20v3h-6.5V19h-3v-6.5H4v-3h6.5z"/></svg>
            </span>
            <span class="brand-text">Vital<strong>Boost</strong></span>
        </div>
        <span class="sidebar-tag">Panel Administrador</span>

        <nav class="menu">

            <!-- DASHBOARD -->

            <a href="${ctx}/Servletlistarusuario?accion=listar"
               class="activo">
                <span class="menu-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7" height="9" rx="1.5"/><rect x="14" y="3" width="7" height="5" rx="1.5"/><rect x="14" y="12" width="7" height="9" rx="1.5"/><rect x="3" y="16" width="7" height="5" rx="1.5"/></svg>
                </span>
                Dashboard
            </a>

            <!-- USUARIOS -->

            <a href="${ctx}/Servletlistarusuario?accion=listar">
                <span class="menu-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                </span>
                Usuarios
            </a>

            <!-- CONFIGURACIÓN -->

            <a href="${ctx}/vistas/configuracion.jsp">
                <span class="menu-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 1 1-2.83-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 1 1 2.83-2.83l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 1 1 2.83 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/></svg>
                </span>
                Configuración Sistema
            </a>

        </nav>

        <div class="sidebar-footer">

            <div class="sidebar-profile">
                <span class="avatar-mini">${fn:substring(usuarioLogueado.nombre_completo, 0, 1)}</span>
                <div class="perfil-info">
                    <div class="perfil-nombre">${usuarioLogueado.nombre_completo}</div>
                    <div class="perfil-rol">${usuarioLogueado.nombreRol}</div>
                </div>
            </div>

            <!-- CERRAR SESIÓN -->

            <a href="${ctx}/ServletCerrarSesion" class="menu-logout">
                <span class="menu-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
                </span>
                Cerrar Sesión
            </a>

        </div>

    </aside>

    <!-- =====================================
         CONTENIDO
    ====================================== -->

    <main class="contenido">

        <div class="franja-salud"></div>

        <!-- =====================================
             TOPBAR
        ====================================== -->

        <header class="topbar">

            <div>

                <h1>
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#0d9488" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 12h-4l-3 9L9 3l-3 9H2"/></svg>
                    Panel Administrador
                </h1>

                <p class="subtitulo">
                    Gestión de usuarios y perfiles médicos
                </p>

            </div>

            <div class="usuario-admin">

                <div>
                    <span>Administrador</span>
                    <strong>${usuarioLogueado.nombre_completo}</strong>
                    <span class="rol-chip">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
                        ${usuarioLogueado.nombreRol}
                    </span>
                </div>

                <span class="admin-avatar">${fn:substring(usuarioLogueado.nombre_completo, 0, 1)}</span>

            </div>

        </header>

        <!-- =====================================
             PERFIL DE ADMINISTRADOR
        ====================================== -->

        <section class="perfil-admin-card">

            <div class="perfil-admin-izq">

                <span class="perfil-admin-avatar">${fn:substring(usuarioLogueado.nombre_completo, 0, 1)}</span>

                <div class="perfil-admin-datos">

                    <h2>${usuarioLogueado.nombre_completo}</h2>

                    <span class="perfil-admin-shield">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
                        Administrador del sistema
                    </span>

                    <div class="perfil-admin-meta">

                        <span>
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="4" width="20" height="16" rx="2"/><path d="M22 6l-10 7L2 6"/></svg>
                            ${usuarioLogueado.email}
                        </span>

                        <span>
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
                            Administrador desde ${usuarioLogueado.fecha_registro}
                        </span>

                        <c:if test="${not empty usuarioLogueado.numero_documento}">
                            <span>
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/></svg>
                                Doc. ${usuarioLogueado.numero_documento}
                            </span>
                        </c:if>

                    </div>

                </div>

            </div>

            <div class="perfil-admin-der">
                <small>Usuarios en el sistema</small>
                <strong>${totalUsuarios}</strong>
            </div>

        </section>

        <!-- =====================================
             CARDS
        ====================================== -->

        <section class="cards">

            <div class="card">
                <span class="card-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                </span>
                <h3>
                    Usuarios Registrados
                </h3>

                <p>
                    ${totalUsuarios}
                </p>

            </div>

            <div class="card">
                <span class="card-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                </span>
                <h3>
                    Usuarios Activos
                </h3>

                <p>
                    ${totalUsuarios}
                </p>

            </div>

            <div class="card">
                <span class="card-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 12h-4l-3 9L9 3l-3 9H2"/></svg>
                </span>
                <h3>
                    Sistema
                </h3>

                <p>
                    VitalBoost
                </p>

            </div>

            <div class="card">
                <span class="card-icon">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 8a6 6 0 0 0-12 0c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>
                </span>
                <h3>
                    Alertas
                </h3>

                <p>
                    0
                </p>

            </div>

        </section>

        <!-- =====================================
             TABLA USUARIOS
        ====================================== -->

        <section class="tabla-contenedor">

            <div class="tabla-header">

                <div>

                    <h2>
                        Usuarios Registrados
                    </h2>

                    <p class="descripcion-tabla">
                        Gestión de pacientes y perfiles clínicos
                    </p>

                </div>

                <!-- BOTÓN NUEVO USUARIO -->

                <a href="${ctx}/Servletregistrarusuario"
                   class="btn-agregar">

                    + Nuevo Usuario

                </a>

            </div>

            <!-- =====================================
                 TABLA RESPONSIVE
            ====================================== -->

            <div class="tabla-responsive">

                <table>

                    <thead>

                        <tr>

                            <th>Nombre</th>

                            <th>Correo</th>

                            <th>Documento</th>

                            <th>Tipo Sangre</th>

                            <th>Rol</th>

                            <th>Estado</th>

                            <th>Acciones</th>

                        </tr>

                    </thead>

                    <tbody>

                        <c:choose>

                            <c:when test="${not empty listaUsuarios}">

                                <c:forEach var="u"
                                           items="${listaUsuarios}">

                                    <tr>

                                        <td>
                                            ${u.nombre_completo}
                                        </td>

                                        <td>
                                            ${u.email}
                                        </td>

                                        <td>
                                            ${u.numero_documento}
                                        </td>

                                        <td>
                                            ${u.nombreTipoSangre}
                                        </td>

                                        <td>
                                            ${u.nombreRol}
                                        </td>

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

                                                <a href="javascript:void(0);"
                                                   class="btn-perfil"
                                                   onclick="verPerfil(this)"
                                                   data-nombre="${u.nombre_completo}"
                                                   data-email="${u.email}"
                                                   data-documento="${u.numero_documento}"
                                                   data-tipodocumento="${u.nombreTipoDocumento}"
                                                   data-fecha="${u.fecha_nacimiento}"
                                                   data-sangre="${u.nombreTipoSangre}"
                                                   data-rol="${u.nombreRol}"
                                                   data-alergias="${u.alergias_conocidas}">

                                                    Ver Perfil

                                                </a>

                                                <a href="${ctx}/Servletregistrarusuario?accion=editar&id=${u.id_usuario}"
                                                   class="btn-editar">

                                                    Editar

                                                </a>

                                                <c:choose>
                                                    <c:when test="${u.activo == 0}">
                                                        <a href="javascript:void(0);"
                                                           class="btn-editar"
                                                           onclick="confirmarAccion('${ctx}/Servletlistarusuario?accion=activar&id=${u.id_usuario}', '¿Activar nuevamente a este usuario?')">

                                                            Activar

                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="javascript:void(0);"
                                                           class="btn-eliminar"
                                                           onclick="confirmarAccion('${ctx}/Servletlistarusuario?accion=eliminar&id=${u.id_usuario}', '¿Desactivar a este usuario? Podrás reactivarlo luego.')">

                                                            Desactivar

                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>

                                            </div>

                                        </td>

                                    </tr>

                                </c:forEach>

                            </c:when>

                            <c:otherwise>

                                <tr>

                                    <td colspan="7"
                                        class="sin-registros">

                                        No hay usuarios registrados

                                    </td>

                                </tr>

                            </c:otherwise>

                        </c:choose>

                    </tbody>

                </table>

            </div>

        </section>

    </main>

</div>

<!-- =====================================
     MODAL VER PERFIL
====================================== -->

<div id="modalPerfil" class="modal-overlay" style="display:none;">

    <div class="modal-caja">

        <div class="modal-caja-header">
            <button type="button" class="modal-cerrar" onclick="cerrarPerfil()">&times;</button>
            <h2>
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/></svg>
                Perfil del Usuario
            </h2>
        </div>

        <ul class="modal-lista">
            <li><strong>Nombre</strong><span id="pNombre"></span></li>
            <li><strong>Email</strong><span id="pEmail"></span></li>
            <li><strong>Documento</strong><span id="pDocumento"></span></li>
            <li><strong>Tipo Documento</strong><span id="pTipoDocumento"></span></li>
            <li><strong>Fecha Nacimiento</strong><span id="pFecha"></span></li>
            <li><strong>Tipo de Sangre</strong><span id="pSangre"></span></li>
            <li><strong>Rol</strong><span id="pRol"></span></li>
            <li><strong>Alergias</strong><span id="pAlergias"></span></li>
        </ul>

    </div>

</div>

<script>
    function verPerfil(btn) {
        document.getElementById('pNombre').textContent = btn.dataset.nombre || '-';
        document.getElementById('pEmail').textContent = btn.dataset.email || '-';
        document.getElementById('pDocumento').textContent = btn.dataset.documento || '-';
        document.getElementById('pTipoDocumento').textContent = btn.dataset.tipodocumento || '-';
        document.getElementById('pFecha').textContent = btn.dataset.fecha || '-';
        document.getElementById('pSangre').textContent = btn.dataset.sangre || '-';
        document.getElementById('pRol').textContent = btn.dataset.rol || '-';
        document.getElementById('pAlergias').textContent = btn.dataset.alergias || '-';

        document.getElementById('modalPerfil').style.display = 'flex';
    }

    function cerrarPerfil() {
        document.getElementById('modalPerfil').style.display = 'none';
    }

    function confirmarAccion(url, mensaje) {
        if (confirm(mensaje)) {
            window.location.href = url;
        }
    }
</script>

</body>

</html>
