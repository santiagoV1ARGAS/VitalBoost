<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro Toma Medicamento - VitalBoost</title>
    <link rel="stylesheet" href="${ctx}/css/registrartomamedicamento.css">
</head>
<body>

<div class="contenedor-admin">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <div class="logo">VitalBoost</div>
        <nav class="menu">
            <a href="${ctx}/Servletlistarusuario?accion=listar">Dashboard</a>
            <a href="${ctx}/vistas/configuracion.jsp" class="activo">Configuración Sistema</a>
        </nav>
    </aside>

    <!-- CONTENIDO -->
    <main class="contenido">
        <div class="contenedor-formulario">
            <div class="card-formulario">

                <h1>
                    <c:choose>
                        <c:when test="${not empty registro}">Editar Registro de Toma</c:when>
                        <c:otherwise>Registro de Toma de Medicamento</c:otherwise>
                    </c:choose>
                </h1>

                <!-- MENSAJES DE ESTADO (FEEDBACK) -->
                <c:if test="${param.msg eq 'guardado'}">
                    <div class="mensaje-exito">Registro guardado con éxito.</div>
                </c:if>
                <c:if test="${param.msg eq 'actualizado'}">
                    <div class="mensaje-exito">Registro actualizado con éxito.</div>
                </c:if>
                <c:if test="${param.msg eq 'eliminado'}">
                    <div class="mensaje-exito">Registro eliminado con éxito.</div>
                </c:if>
                <c:if test="${param.msg eq 'error'}">
                    <div class="mensaje-error">Ocurrió un error al procesar la solicitud.</div>
                </c:if>

                <!-- FORMULARIO -->
                <form action="${ctx}/Servletregistrartomamedicamento" method="POST">

                    <c:choose>
                        <c:when test="${not empty registro}">
                            <input type="hidden" name="accion" value="actualizar">
                            <input type="hidden" name="id" value="${registro.id_registro}">
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="accion" value="guardar">
                        </c:otherwise>
                    </c:choose>

                    <div class="grupo-formulario">
                        <label for="txtIdUsuario">ID Usuario</label>
                        <input type="number" id="txtIdUsuario" name="txtIdUsuario"
                               value="${registro.id_usuario}" placeholder="ID del usuario" required>
                    </div>

                    <div class="grupo-formulario">
                        <label for="txtIdMedicamento">ID Medicamento</label>
                        <input type="number" id="txtIdMedicamento" name="txtIdMedicamento"
                               value="${registro.id_medicamento}" placeholder="ID del medicamento" required>
                    </div>

                    <div class="grupo-formulario">
                        <label for="txtSustancia">Sustancia Manual</label>
                        <input type="text" id="txtSustancia" name="txtSustancia"
                               value="${registro.nombre_sustancia_manual}" placeholder="Ej: Paracetamol" required>
                    </div>

                    <div class="grupo-formulario">
                        <label for="txtDosis">Dosis</label>
                        <input type="text" id="txtDosis" name="txtDosis"
                               value="${registro.dosis_tomada}" placeholder="Ej: 500 mg" required>
                    </div>

                    <div class="contenedor-botones">
                        <button type="submit" class="btn-guardar">
                            <c:choose>
                                <c:when test="${not empty registro}">Actualizar</c:when>
                                <c:otherwise>Guardar</c:otherwise>
                            </c:choose>
                        </button>

                        <c:if test="${not empty registro}">
                            <a href="${ctx}/Servletregistrartomamedicamento" class="btn-cancelar">Cancelar</a>
                        </c:if>
                    </div>

                </form>

                <!-- TABLA -->
                <div class="tabla-contenedor" style="margin-top: 30px;">
                    <h2>Registros Recientes</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Usuario</th>
                                <th>Medicamento</th>
                                <th>Sustancia</th>
                                <th>Dosis</th>
                                <th>Hora</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${lista}">
                                <tr>
                                    <td>${r.id_registro}</td>
                                    <td>${r.id_usuario}</td>
                                    <td>${r.id_medicamento}</td>
                                    <td>${r.nombre_sustancia_manual}</td>
                                    <td>${r.dosis_tomada}</td>
                                    <td>${r.hora_toma}</td>
                                    <td>
                                        <a class="btn-editar"
                                           href="${ctx}/Servletregistrartomamedicamento?accion=editar&id=${r.id_registro}">
                                            Editar
                                        </a>

                                        <a class="btn-eliminar"
                                           href="javascript:void(0);"
                                           onclick="confirmarEliminar('${ctx}/Servletregistrartomamedicamento?accion=eliminar&id=${r.id_registro}')">
                                            Eliminar
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </main>

</div>

<script>
    function confirmarEliminar(url) {
        if (confirm("¿Estás seguro de que deseas eliminar este registro de toma?")) {
            window.location.href = url;
        }
    }
</script>

</body>
</html>