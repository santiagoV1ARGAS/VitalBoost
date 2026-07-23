<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Centros Médicos</title>

    <link rel="stylesheet" href="${ctx}/css/registrarcentromedico.css">
</head>

<body>

<div class="contenedor-admin">

    <!-- SIDEBAR (NO TOCAR) -->
    <aside class="sidebar">

        <div class="logo">VitalBoost</div>

        <nav class="menu">
            <a href="${ctx}/Servletlistarusuario?accion=listar">Dashboard</a>
            <a href="${ctx}/vistas/configuracion.jsp" class="activo">Configuración Sistema</a>
        </nav>

    </aside>

    <main class="contenido">

        <!-- FORM -->
        <div class="form-contenedor">

            <h1>
                ${centroEditar != null ? 'Editar Centro Médico' : 'Registrar Centro Médico'}
            </h1>

            <form action="${ctx}/Servletregistrarcentromedico" method="POST">

                <c:if test="${centroEditar != null}">
                    <input type="hidden" name="idCentro" value="${centroEditar.id_centro}">
                </c:if>

                <input type="hidden" name="accion"
                       value="${centroEditar != null ? 'actualizar' : 'guardar'}">

                <div class="grupo-input">
                    <label>ID Usuario</label>
                    <input type="number" name="txtIdUsuario"
                           value="${centroEditar.id_usuario_referencia}">
                </div>

                <div class="grupo-input">
                    <label>Nombre Centro</label>
                    <input type="text" name="txtNombreCentro"
                           value="${centroEditar.nombre_centro}">
                </div>

                <div class="grupo-input">
                    <label>Dirección</label>
                    <input type="text" name="txtDireccion"
                           value="${centroEditar.direccion}">
                </div>

                <div class="grupo-input">
                    <label>Teléfono Urgencias</label>
                    <input type="text" name="txtTelefono"
                           value="${centroEditar.telefono_urgencias}">
                </div>

                <div class="grupo-input">
                    <label>Latitud</label>
                    <input type="text" name="txtLatitud"
                           value="${centroEditar.latitud}">
                </div>

                <div class="grupo-input">
                    <label>Longitud</label>
                    <input type="text" name="txtLongitud"
                           value="${centroEditar.longitud}">
                </div>

                <button type="submit" class="btn-agregar">
                    ${centroEditar != null ? 'Actualizar' : 'Registrar'}
                </button>

            </form>

        </div>

        <!-- TABLA -->
        <div class="tabla-roles">

            <h2>Centros Médicos Registrados</h2>

            <table>

                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Dirección</th>
                        <th>Teléfono</th>
                        <th>Lat</th>
                        <th>Lng</th>
                        <th>Acción</th>
                    </tr>
                </thead>

                <tbody>

                    <c:forEach var="c" items="${listaCentros}">

                        <tr>
                            <td>${c.id_centro}</td>
                            <td>${c.nombre_centro}</td>
                            <td>${c.direccion}</td>
                            <td>${c.telefono_urgencias}</td>
                            <td>${c.latitud}</td>
                            <td>${c.longitud}</td>

                            <td>
                                <a class="btn-editar"
                                   href="${ctx}/Servletregistrarcentromedico?accion=editar&id=${c.id_centro}">
                                    Editar
                                </a>

                                <a class="btn-eliminar"
                                   href="javascript:void(0);"
                                   onclick="confirmarEliminar('${ctx}/Servletregistrarcentromedico?accion=eliminar&id=${c.id_centro}')">
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
        if (confirm("¿Estás seguro de que deseas eliminar este centro médico? Esta acción no se puede deshacer.")) {
            window.location.href = url;
        }
    }
</script>

</body>
</html>