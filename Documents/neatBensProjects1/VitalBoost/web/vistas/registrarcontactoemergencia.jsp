<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Contacto Emergencia</title>
    <link rel="stylesheet" href="${ctx}/css/registrarcontactoemergencia.css">
</head>

<body>

<div class="contenedor-admin">

    <aside class="sidebar">

        <div class="logo">VitalBoost</div>

        <nav class="menu">

            <a href="${ctx}/Servletlistarusuario?accion=listar">
                Dashboard
            </a>

            <a href="${ctx}/vistas/configuracion.jsp" class="activo">
                Configuración Sistema
            </a>

        </nav>

    </aside>

    <main class="contenido">

        <!-- FORMULARIO -->
        <div class="form-contenedor">

            <h1>
                <c:choose>
                    <c:when test="${contactoEditar != null}">
                        Editar Contacto
                    </c:when>
                    <c:otherwise>
                        Registrar Contacto
                    </c:otherwise>
                </c:choose>
            </h1>

            <form action="${ctx}/Servletregistrarcontactoemergencia" method="POST">

                <input type="hidden"
                       name="accion"
                       value="${contactoEditar != null ? 'actualizar' : 'guardar'}">

                <c:if test="${contactoEditar != null}">
                    <input type="hidden"
                           name="idContacto"
                           value="${contactoEditar.id_contacto}">
                </c:if>

                <div class="grupo-input">
                    <label>ID Usuario</label>
                    <input type="number"
                           name="txtIdUsuario"
                           value="${contactoEditar.id_usuario}"
                           required>
                </div>

                <div class="grupo-input">
                    <label>Nombre Contacto</label>
                    <input type="text"
                           name="txtNombreContacto"
                           value="${contactoEditar.nombre_contacto}"
                           required>
                </div>

                <div class="grupo-input">
                    <label>Parentesco</label>
                    <input type="text"
                           name="txtParentesco"
                           value="${contactoEditar.parentesco}"
                           required>
                </div>

                <div class="grupo-input">
                    <label>Teléfono</label>
                    <input type="text"
                           name="txtTelefono"
                           value="${contactoEditar.telefono}"
                           required>
                </div>

                <button type="submit" class="btn-agregar">
                    ${contactoEditar != null ? 'Actualizar' : 'Registrar'}
                </button>

            </form>
        </div>

        <!-- TABLA -->
        <div class="tabla-roles">

            <h2>Contactos Registrados</h2>

            <table>

                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Usuario</th>
                        <th>Nombre</th>
                        <th>Parentesco</th>
                        <th>Teléfono</th>
                        <th>Acción</th>
                    </tr>
                </thead>

                <tbody>

                    <c:forEach var="c" items="${listaContactos}">

                        <tr>
                            <td>${c.id_contacto}</td>
                            <td>${c.id_usuario}</td>
                            <td>${c.nombre_contacto}</td>
                            <td>${c.parentesco}</td>
                            <td>${c.telefono}</td>

                            <td>
                                <a href="${ctx}/Servletregistrarcontactoemergencia?accion=editar&id=${c.id_contacto}"
                                   class="btn-editar">
                                    Editar
                                </a>

                                <a href="javascript:void(0);"
                                   onclick="confirmarEliminar('${ctx}/Servletregistrarcontactoemergencia?accion=eliminar&id=${c.id_contacto}')"
                                   class="btn-eliminar">
                                    Eliminar
                                </a>
                            </td>
                        </tr>

                    </c:forEach>

                </tbody>

            </table>

        </div>

    </main>

</div>

<script>
    function confirmarEliminar(url) {
        if (confirm("¿Deseas eliminar este contacto de emergencia?")) {
            window.location.href = url;
        }
    }
</script>

</body>
</html>