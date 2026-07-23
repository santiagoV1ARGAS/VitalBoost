<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<c:if test="${empty usuarioLogueado}">
    <c:redirect url="/vistas/login.jsp"/>
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

</head>

<body>

<div class="contenedor-admin">

    <!-- =====================================
         SIDEBAR
    ====================================== -->

    <aside class="sidebar">

        <div class="logo">
            VitalBoost
        </div>

        <nav class="menu">

            <!-- DASHBOARD -->

            <a href="${ctx}/Servletlistarusuario?accion=listar"
               class="activo">

                Dashboard

            </a>

            <!-- USUARIOS -->

            <a href="${ctx}/Servletlistarusuario?accion=listar">

                Usuarios

            </a>

            <!-- CONFIGURACIÓN -->

            <a href="${ctx}/vistas/configuracion.jsp">

                Configuración Sistema

            </a>

            <!-- CERRAR SESIÓN -->

            <a href="${ctx}/ServletCerrarSesion">

                Cerrar Sesión

            </a>

        </nav>

    </aside>

    <!-- =====================================
         CONTENIDO
    ====================================== -->

    <main class="contenido">

        <!-- =====================================
             TOPBAR
        ====================================== -->

        <header class="topbar">

            <div>

                <h1>
                    Panel Administrador
                </h1>

                <p class="subtitulo">
                    Gestión de usuarios y perfiles médicos
                </p>

            </div>

            <div class="usuario-admin">

                <span>
                    Administrador
                </span>

                <strong>
                    ${usuarioLogueado.nombre_completo}
                </strong>

            </div>

        </header>

        <!-- =====================================
             CARDS
        ====================================== -->

        <section class="cards">

            <div class="card">

                <h3>
                    Usuarios Registrados
                </h3>

                <p>
                    ${totalUsuarios}
                </p>

            </div>

            <div class="card">

                <h3>
                    Usuarios Activos
                </h3>

                <p>
                    ${totalUsuarios}
                </p>

            </div>

            <div class="card">

                <h3>
                    Sistema
                </h3>

                <p>
                    VitalBoost
                </p>

            </div>

            <div class="card">

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

                <a href="${ctx}/vistas/registrarUsuario.jsp"
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
                                            ${u.id_tipo_sangre}
                                        </td>

                                        <td>
                                            ${u.id_rol}
                                        </td>

                                        <td>

                                            <div class="acciones">

                                                <a href="${ctx}/Servletlistarusuario?accion=perfil&id=${u.id_usuario}"
                                                   class="btn-perfil">

                                                    Ver Perfil

                                                </a>

                                                <a href="${ctx}/Servletlistarusuario?accion=editar&id=${u.id_usuario}"
                                                   class="btn-editar">

                                                    Editar

                                                </a>

                                                <a href="${ctx}/Servletlistarusuario?accion=eliminar&id=${u.id_usuario}"
                                                   class="btn-eliminar">

                                                    Eliminar

                                                </a>

                                            </div>

                                        </td>

                                    </tr>

                                </c:forEach>

                            </c:when>

                            <c:otherwise>

                                <tr>

                                    <td colspan="6"
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

</body>

</html>