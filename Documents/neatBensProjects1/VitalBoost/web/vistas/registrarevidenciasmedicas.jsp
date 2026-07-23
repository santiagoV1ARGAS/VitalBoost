<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Registrar Evidencia Médica</title>

    <link rel="stylesheet" href="${ctx}/css/registrarevidenciasmedicas.css">

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

            <a href="${ctx}/vistas/configuracion.jsp" class="activo">
                Configuración Sistema
            </a>

        </nav>

    </aside>

    <!-- CONTENIDO -->
    <main class="contenido">

        <!-- FORMULARIO -->
        <div class="form-contenedor">

            <h1>
                ${evidenciaEditar != null ? 'Editar Evidencia Médica' : 'Registrar Evidencia Médica'}
            </h1>

            <form action="${ctx}/Servletregistrarevidenciasmedicas" method="POST">

                <!-- ID oculto para editar -->
                <c:if test="${evidenciaEditar != null}">
                    <input type="hidden" name="idEvidencia" value="${evidenciaEditar.id_evidencia}">
                </c:if>

                <!-- ACCION -->
                <input type="hidden" name="accion"
                       value="${evidenciaEditar != null ? 'actualizar' : 'guardar'}">

                <div class="grupo-input">
                    <label>ID Usuario</label>
                    <input type="number" name="txtIdUsuario"
                           value="${evidenciaEditar.id_usuario}" required>
                </div>

                <div class="grupo-input">
                    <label>URL Archivo</label>
                    <input type="text" name="txtUrlArchivo"
                           value="${evidenciaEditar.url_archivo}" required>
                </div>

                <div class="grupo-input">
                    <label>Descripción</label>
                    <textarea name="txtDescripcionArchivo" rows="4" required>${evidenciaEditar.descripcion_archivo}</textarea>
                </div>

                <div class="grupo-input">
                    <label>Tipo Archivo</label>
                    <input type="text" name="txtTipoArchivo"
                           value="${evidenciaEditar.tipo_archivo}" required>
                </div>

                <div class="grupo-input">
                    <label>Fecha Subida</label>
                    <input type="date" name="txtFechaSubida"
                           value="${evidenciaEditar.fecha_subida != null ? evidenciaEditar.fecha_subida.toString().substring(0,10) : ''}">
                </div>

                <button type="submit" class="btn-agregar">
                    ${evidenciaEditar != null ? 'Actualizar Evidencia' : 'Registrar Evidencia'}
                </button>

            </form>

        </div>

        <!-- TABLA LISTADO -->
        <div class="tabla-roles">

            <h2>Lista de Evidencias Médicas</h2>

            <table>

                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Usuario</th>
                        <th>URL</th>
                        <th>Descripción</th>
                        <th>Tipo</th>
                        <th>Fecha</th>
                        <th>Acción</th>
                    </tr>
                </thead>

                <tbody>

                    <c:forEach var="e" items="${listaEvidencias}">

                        <tr>
                            <td>${e.id_evidencia}</td>
                            <td>${e.id_usuario}</td>
                            <td>${e.url_archivo}</td>
                            <td>${e.descripcion_archivo}</td>
                            <td>${e.tipo_archivo}</td>
                            <td>${e.fecha_subida}</td>

                            <td>
                                <a href="${ctx}/Servletregistrarevidenciasmedicas?accion=editar&id=${e.id_evidencia}"
                                   class="btn-editar">
                                    Editar
                                </a>

                                <a href="javascript:void(0);"
                                   onclick="confirmarEliminar('${ctx}/Servletregistrarevidenciasmedicas?accion=eliminar&id=${e.id_evidencia}')"
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
        if (confirm("¿Estás seguro de eliminar esta evidencia médica?")) {
            window.location.href = url;
        }
    }
</script>

</body>
</html>