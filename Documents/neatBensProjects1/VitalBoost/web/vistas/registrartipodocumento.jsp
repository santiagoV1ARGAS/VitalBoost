<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión Tipo Documento - VitalBoost</title>
    <link rel="stylesheet" href="${ctx}/css/registrartipodocumento.css">
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
                        <c:when test="${not empty registro}">Editar Tipo Documento</c:when>
                        <c:otherwise>Registrar Tipo Documento</c:otherwise>
                    </c:choose>
                </h1>

                <!-- MENSAJES DE ESTADO DE LA URL -->
                <c:if test="${param.msg eq 'guardado'}">
                    <div class="mensaje-exito">Tipo de documento registrado con éxito.</div>
                </c:if>
                <c:if test="${param.msg eq 'actualizado'}">
                    <div class="mensaje-exito">Tipo de documento actualizado con éxito.</div>
                </c:if>
                <c:if test="${param.msg eq 'eliminado'}">
                    <div class="mensaje-exito">Tipo de documento eliminado con éxito.</div>
                </c:if>
                <c:if test="${param.msg eq 'error'}">
                    <div class="mensaje-error">Ocurrió un error al procesar la solicitud.</div>
                </c:if>

                <!-- FORMULARIO -->
                <form action="${ctx}/Servletregistrartipodocumento" method="POST">

                    <c:choose>
                        <c:when test="${not empty registro}">
                            <input type="hidden" name="accion" value="actualizar">
                            <input type="hidden" name="id" value="${registro.id_tipo_documento}">
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="accion" value="guardar">
                        </c:otherwise>
                    </c:choose>

                    <div class="grupo-formulario">
                        <label for="txtDescripcion">Descripción Tipo Documento</label>
                        <input type="text" id="txtDescripcion" name="txtDescripcion" 
                               value="${registro.descripcion_tipo_documento}" 
                               placeholder="Ej: Cédula de Ciudadanía" required>
                    </div>

                    <div class="contenedor-botones">
                        <button type="submit" class="btn-guardar">
                            <c:choose>
                                <c:when test="${not empty registro}">Actualizar Tipo</c:when>
                                <c:otherwise>Registrar Tipo</c:otherwise>
                            </c:choose>
                        </button>
                        
                        <c:if test="${not empty registro}">
                            <a href="${ctx}/Servletregistrartipodocumento" class="btn-cancelar">Cancelar</a>
                        </c:if>
                    </div>

                </form>

                <!-- TABLA DE REGISTROS -->
                <div class="tabla-contenedor" style="margin-top: 30px;">
                    <h2>Tipos de Documento Registrados</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Descripción</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="td" items="${lista}">
                                <tr>
                                    <td>${td.id_tipo_documento}</td>
                                    <td>${td.descripcion_tipo_documento}</td>
                                    <td>
                                        <a class="btn-editar" 
                                           href="${ctx}/Servletregistrartipodocumento?accion=editar&id=${td.id_tipo_documento}">
                                            Editar
                                        </a>

                                        <a class="btn-eliminar" 
                                           href="javascript:void(0);" 
                                           onclick="confirmarEliminar('${ctx}/Servletregistrartipodocumento?accion=eliminar&id=${td.id_tipo_documento}')">
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
        if (confirm("¿Estás seguro de que deseas eliminar este tipo de documento?")) {
            window.location.href = url;
        }
    }
</script>

</body>
</html>