<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Signos Vitales - VitalBoost</title>
    <link rel="stylesheet" href="${ctx}/css/registrarsignosvitales.css">
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
                        <c:when test="${not empty registro}">Editar Signo Vital</c:when>
                        <c:otherwise>Registrar Signos Vitales</c:otherwise>
                    </c:choose>
                </h1>

                <!-- MENSAJES DE ESTADO -->
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
                <form action="${ctx}/Servletregistrarsignosvitales" method="POST">

                    <c:choose>
                        <c:when test="${not empty registro}">
                            <input type="hidden" name="accion" value="actualizar">
                            <input type="hidden" name="id" value="${registro.id_signo}">
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="accion" value="guardar">
                        </c:otherwise>
                    </c:choose>

                    <div class="grupo-formulario">
                        <label for="txtIdUsuario">ID Usuario</label>
                        <input type="number" id="txtIdUsuario" name="txtIdUsuario" 
                               value="${registro.id_usuario}" required min="1">
                    </div>

                    <div class="grupo-formulario">
                        <label for="txtFrecuencia">Frecuencia Cardíaca (BPM)</label>
                        <input type="number" id="txtFrecuencia" name="txtFrecuencia" 
                               value="${registro.frecuencia_cardiaca}" required min="1">
                    </div>

                    <div class="grupo-formulario">
                        <label for="txtPresion">Presión Arterial (e.g. 120/80)</label>
                        <input type="text" id="txtPresion" name="txtPresion" 
                               value="${registro.presion_arterial}" required 
                               pattern="^([0-9]{2,3})\/([0-9]{2,3})$" title="Formato válido: 120/80">
                    </div>

                    <div class="grupo-formulario">
                        <label for="txtSaturacion">Saturación Oxígeno (%)</label>
                        <input type="number" id="txtSaturacion" name="txtSaturacion" 
                               value="${registro.saturacion_oxigeno}" required min="0" max="100">
                    </div>

                    <div class="grupo-formulario">
                        <label for="txtTemperatura">Temperatura (°C)</label>
                        <input type="number" step="0.1" id="txtTemperatura" name="txtTemperatura" 
                               value="${registro.temperatura}" required min="20" max="45">
                    </div>

                    <div class="acciones-form">
                        <button type="submit" class="btn-guardar">
                            <c:choose>
                                <c:when test="${not empty registro}">Actualizar</c:when>
                                <c:otherwise>Guardar</c:otherwise>
                            </c:choose>
                        </button>
                        
                        <c:if test="${not empty registro}">
                            <a href="${ctx}/Servletregistrarsignosvitales" class="btn-cancelar">Cancelar</a>
                        </c:if>
                    </div>

                </form>

                <!-- TABLA DE REGISTROS -->
                <div class="tabla-contenedor">
                    <h2>Registros Recientes</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Usuario</th>
                                <th>FC</th>
                                <th>PA</th>
                                <th>SpO2</th>
                                <th>Temp</th>
                                <th>Fecha</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="s" items="${lista}">
                                <tr>
                                    <td>${s.id_signo}</td>
                                    <td>${s.id_usuario}</td>
                                    <td>${s.frecuencia_cardiaca} bpm</td>
                                    <td>${s.presion_arterial}</td>
                                    <td>${s.saturacion_oxigeno}%</td>
                                    <td>${s.temperatura} °C</td>
                                    <td>${s.fecha_registro}</td>
                                    <td>
                                        <a class="btn-editar" 
                                           href="${ctx}/Servletregistrarsignosvitales?accion=editar&id=${s.id_signo}">
                                            Editar
                                        </a>

                                        <a class="btn-eliminar" 
                                           href="javascript:void(0);" 
                                           onclick="confirmarEliminar('${ctx}/Servletregistrarsignosvitales?accion=eliminar&id=${s.id_signo}')">
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
        if (confirm("¿Estás seguro de que deseas eliminar este registro de signos vitales?")) {
            window.location.href = url;
        }
    }
</script>

</body>
</html>