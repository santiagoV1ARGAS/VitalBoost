<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Triaje - VitalBoost</title>
    <link rel="stylesheet" href="${ctx}/css/registrartriaje.css">
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
                        <c:when test="${not empty registro}">Editar Triaje</c:when>
                        <c:otherwise>Registrar Triaje Inicial</c:otherwise>
                    </c:choose>
                </h1>

                <!-- MENSAJES DE ESTADO DE LA URL -->
                <c:if test="${param.msg eq 'guardado'}">
                    <div class="mensaje-exito">Triaje registrado con éxito.</div>
                </c:if>
                <c:if test="${param.msg eq 'actualizado'}">
                    <div class="mensaje-exito">Triaje actualizado con éxito.</div>
                </c:if>
                <c:if test="${param.msg eq 'eliminado'}">
                    <div class="mensaje-exito">Triaje eliminado con éxito.</div>
                </c:if>
                <c:if test="${param.msg eq 'error'}">
                    <div class="mensaje-error">Ocurrió un error al procesar la solicitud.</div>
                </c:if>

                <!-- FORMULARIO -->
                <form action="${ctx}/Servletregistrartriaje" method="POST">

                    <c:choose>
                        <c:when test="${not empty registro}">
                            <input type="hidden" name="accion" value="actualizar">
                            <input type="hidden" name="id" value="${registro.id_triaje}">
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="accion" value="guardar">
                        </c:otherwise>
                    </c:choose>

                    <div class="grupo-formulario">
                        <label for="txtIdUsuario">ID Usuario / Paciente</label>
                        <input type="number" id="txtIdUsuario" name="txtIdUsuario" 
                               value="${registro.id_usuario}" required>
                    </div>

                    <div class="grupo-formulario">
                        <label for="txtNivelDolor">Nivel Dolor Escala (0-10)</label>
                        <input type="number" id="txtNivelDolor" name="txtNivelDolor" 
                               min="0" max="10" value="${registro.nivel_dolor_escala}" required>
                    </div>

                    <div class="grupo-formulario">
                        <label for="txtSintoma">Síntoma Principal</label>
                        <input type="text" id="txtSintoma" name="txtSintoma" 
                               value="${registro.sintoma_principal}" required>
                    </div>

                    <div class="grupo-formulario">
                        <label for="txtEstado">Estado Consciencia</label>
                        <input type="number" id="txtEstado" name="txtEstado" 
                               value="${registro.estado_consciencia}" required>
                    </div>

                    <div class="contenedor-botones">
                        <button type="submit" class="btn-guardar">
                            <c:choose>
                                <c:when test="${not empty registro}">Actualizar Triaje</c:when>
                                <c:otherwise>Registrar Triaje</c:otherwise>
                            </c:choose>
                        </button>

                        <c:if test="${not empty registro}">
                            <a href="${ctx}/Servletregistrartriaje" class="btn-cancelar">Cancelar</a>
                        </c:if>
                    </div>

                </form>

                <!-- TABLA DE REGISTROS -->
                <div class="tabla-contenedor" style="margin-top: 30px;">
                    <h2>Triajes Registrados</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Usuario</th>
                                <th>Nivel Dolor</th>
                                <th>Síntoma</th>
                                <th>Estado Consciencia</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="t" items="${lista}">
                                <tr>
                                    <td>${t.id_triaje}</td>
                                    <td>${t.id_usuario}</td>
                                    <td>${t.nivel_dolor_escala}</td>
                                    <td>${t.sintoma_principal}</td>
                                    <td>${t.estado_consciencia}</td>
                                    <td>
                                        <a class="btn-editar" 
                                           href="${ctx}/Servletregistrartriaje?accion=editar&id=${t.id_triaje}">
                                            Editar
                                        </a>

                                        <a class="btn-eliminar" 
                                           href="javascript:void(0);" 
                                           onclick="confirmarEliminar('${ctx}/Servletregistrartriaje?accion=eliminar&id=${t.id_triaje}')">
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
        if (confirm("¿Estás seguro de que deseas eliminar este registro de triaje?")) {
            window.location.href = url;
        }
    }
</script>

</body>
</html>