<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Historial Médico</title>

    <link rel="stylesheet" href="${ctx}/css/registrarhistorialmedico.css">
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
                ${historialEditar != null ? 'Editar Historial Médico' : 'Registrar Historial Médico'}
            </h1>

            <form action="${ctx}/Servletregistrarhistorialmedico" method="POST">

                <c:if test="${historialEditar != null}">
                    <input type="hidden" name="idHistorial" value="${historialEditar.id_historial}">
                </c:if>

                <input type="hidden" name="accion"
                       value="${historialEditar != null ? 'actualizar' : 'guardar'}">

                <div class="grupo-input">
                    <label>ID Usuario</label>
                    <input type="number" name="txtIdUsuario"
                           value="${historialEditar.id_usuario}" required>
                </div>

                <div class="grupo-input">
                    <label>Enfermedad</label>
                    <input type="text" name="txtEnfermedad"
                           value="${historialEditar.enfermedad}" required>
                </div>

                <div class="grupo-input">
                    <label>Descripción</label>
                    <textarea name="txtDescripcion" rows="4" required>${historialEditar.descripcion}</textarea>
                </div>

                <div class="grupo-input">
                    <label>Fecha Registro</label>
                    <input type="date" name="txtFechaRegistro"
                           value="${historialEditar.fecha_registro}">
                </div>

                <button type="submit" class="btn-agregar">
                    ${historialEditar != null ? 'Actualizar Historial' : 'Registrar Historial'}
                </button>

            </form>

        </div>

        <!-- TABLA -->
        <div class="tabla-roles">

            <h2>Historial Médico Registrado</h2>

            <table>

                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Usuario</th>
                        <th>Enfermedad</th>
                        <th>Descripción</th>
                        <th>Fecha</th>
                        <th>Acción</th>
                    </tr>
                </thead>

                <tbody>

                    <c:forEach var="h" items="${listaHistorial}">

                        <tr>
                            <td>${h.id_historial}</td>
                            <td>${h.id_usuario}</td>
                            <td>${h.enfermedad}</td>
                            <td>${h.descripcion}</td>
                            <td>${h.fecha_registro}</td>

                            <td>
                                <a href="${ctx}/Servletregistrarhistorialmedico?accion=editar&id=${h.id_historial}"
                                   class="btn-editar">
                                    Editar
                                </a>

                                <a href="javascript:void(0);"
                                   onclick="confirmarEliminar('${ctx}/Servletregistrarhistorialmedico?accion=eliminar&id=${h.id_historial}')"
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
        if (confirm("¿Estás seguro de que deseas eliminar este registro de historial médico?")) {
            window.location.href = url;
        }
    }
</script>

</body>
</html>