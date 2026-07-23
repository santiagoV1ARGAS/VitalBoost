<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Registrar Rol</title>
    <link rel="stylesheet" href="${ctx}/css/registrarRol.css">
</head>

<body>

<div class="contenedor-admin">

    <aside class="sidebar">

        <div class="logo">VitalBoost</div>

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

    <main class="contenido">

        <!-- FORMULARIO -->
        <div class="form-contenedor">

            <h1>
                <c:choose>
                    <c:when test="${rolEditar != null}">
                        Editar Rol
                    </c:when>
                    <c:otherwise>
                        Registrar Rol
                    </c:otherwise>
                </c:choose>
            </h1>

            <form action="${ctx}/ServletregistrarRol" method="POST">

                <input type="hidden"
                       name="accion"
                       value="${rolEditar != null ? 'actualizar' : 'guardar'}">

                <c:if test="${rolEditar != null}">
                    <input type="hidden"
                           name="idRol"
                           value="${rolEditar.id_rol}">
                </c:if>

                <div class="grupo-input">
                    <label>Nombre Rol</label>
                    <input type="text"
                           name="txtNombreRol"
                           value="${rolEditar.nombre_rol}"
                           required>
                </div>

                <div class="grupo-input">
                    <label>Descripción</label>
                    <textarea name="txtDescripcion"
                              rows="4">${rolEditar.descripcion}</textarea>
                </div>

                <button type="submit" class="btn-agregar">
                    ${rolEditar != null ? 'Actualizar Rol' : 'Registrar Rol'}
                </button>

            </form>

        </div>

        <!-- TABLA -->
        <div class="tabla-roles">

            <h2>Roles Registrados</h2>

            <table>

                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Acción</th>
                    </tr>
                </thead>

                <tbody>

                    <c:forEach var="rol" items="${listaRoles}">

                        <tr>
                            <td>${rol.id_rol}</td>
                            <td>${rol.nombre_rol}</td>
                            <td>${rol.descripcion}</td>

                            <td>
                                <a href="${ctx}/ServletregistrarRol?accion=editar&id=${rol.id_rol}"
                                   class="btn-editar">
                                    Editar
                                </a>

                                <a href="javascript:void(0);" 
                                   onclick="confirmarEliminar('${ctx}/ServletregistrarRol?accion=eliminar&id=${rol.id_rol}')"
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
        if (confirm("¿Estás seguro de que deseas eliminar este rol? Esta acción no se puede deshacer.")) {
            window.location.href = url;
        }
    }
</script>

</body>
</html>