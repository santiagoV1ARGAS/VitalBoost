<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión Tipo Sangre - VitalBoost</title>
    <link rel="stylesheet" href="${ctx}/css/registrartiposangre.css">
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
                        <c:when test="${not empty registro}">Editar Tipo Sangre</c:when>
                        <c:otherwise>Registrar Tipo Sangre</c:otherwise>
                    </c:choose>
                </h1>

                <!-- MENSAJES DE ESTADO DE LA URL -->
                <c:if test="${param.msg eq 'guardado'}">
                    <div class="mensaje-exito">Tipo de sangre registrado con éxito.</div>
                </c:if>
                <c:if test="${param.msg eq 'actualizado'}">
                    <div class="mensaje-exito">Tipo de sangre actualizado con éxito.</div>
                </c:if>
                <c:if test="${param.msg eq 'eliminado'}">
                    <div class="mensaje-exito">Tipo de sangre eliminado con éxito.</div>
                </c:if>
                <c:if test="${param.msg eq 'error'}">
                    <div class="mensaje-error">Ocurrió un error al procesar la solicitud.</div>
                </c:if>

                <!-- FORMULARIO -->
                <form action="${ctx}/Servletregistrartiposangre" method="POST">

                    <c:choose>
                        <c:when test="${not empty registro}">
                            <input type="hidden" name="accion" value="actualizar">
                            <input type="hidden" name="id" value="${registro.id_tipo_sangre}">
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="accion" value="guardar">
                        </c:otherwise>
                    </c:choose>

                    <div class="grupo-formulario">
                        <label for="txtNombreTipo">Nombre Tipo Sangre</label>
                        <input type="text" id="txtNombreTipo" name="txtNombreTipo" 
                               value="${registro.nombre_tipo}" 
                               placeholder="Ej: O+, A-, AB+" required>
                    </div>

                    <div class="contenedor-botones">
                        <button type="submit" class="btn-guardar">
                            <c:choose>
                                <c:when test="${not empty registro}">Actualizar Tipo</c:when>
                                <c:otherwise>Registrar Tipo</c:otherwise>
                            </c:choose>
                        </button>
                        
                        <c:if test="${not empty registro}">
                            <a href="${ctx}/Servletregistrartiposangre" class="btn-cancelar">Cancelar</a>
                        </c:if>
                    </div>

                </form>

                <!-- TABLA DE REGISTROS -->
                <div class="tabla-contenedor" style="margin-top: 30px;">
                    <h2>Tipos de Sangre Registrados</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tipo de Sangre</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="ts" items="${lista}">
                                <tr>
                                    <td>${ts.id_tipo_sangre}</td>
                                    <td>${ts.nombre_tipo}</td>
                                    <td>
                                        <a class="btn-editar" 
                                           href="${ctx}/Servletregistrartiposangre?accion=editar&id=${ts.id_tipo_sangre}">
                                            Editar
                                        </a>

                                        <a class="btn-eliminar" 
                                           href="javascript:void(0);" 
                                           onclick="confirmarEliminar('${ctx}/Servletregistrartiposangre?accion=eliminar&id=${ts.id_tipo_sangre}')">
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
        if (confirm("¿Estás seguro de que deseas eliminar este tipo de sangre?")) {
            window.location.href = url;
        }
    }
</script>

</body>
</html>