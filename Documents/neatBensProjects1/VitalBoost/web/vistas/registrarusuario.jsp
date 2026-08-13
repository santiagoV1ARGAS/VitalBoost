<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${not empty usuarioEdit}">Editar Usuario</c:when>
            <c:otherwise>Registrar Usuario</c:otherwise>
        </c:choose>
    </title>
    <link rel="stylesheet" href="${ctx}/css/registrarusuario.css">
    <link rel="stylesheet" href="${ctx}/css/global.css">
</head>

<body>

<%@ include file="/includes/loader.jspf" %>

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
                        <c:when test="${not empty usuarioEdit}">Editar Usuario</c:when>
                        <c:otherwise>Registrar Usuario</c:otherwise>
                    </c:choose>
                </h1>

                <!-- MENSAJES DE ESTADO DE LA URL -->
                <c:if test="${param.msg eq 'guardado'}">
                    <div class="mensaje-exito">Usuario registrado con éxito.</div>
                </c:if>
                <c:if test="${param.msg eq 'actualizado'}">
                    <div class="mensaje-exito">Usuario actualizado con éxito.</div>
                </c:if>
                <c:if test="${param.msg eq 'eliminado'}">
                    <div class="mensaje-exito">Usuario eliminado con éxito.</div>
                </c:if>
                <c:if test="${param.msg eq 'error'}">
                    <div class="mensaje-error">Ocurrió un error al procesar la solicitud.</div>
                </c:if>

                <form action="${ctx}/Servletregistrarusuario" method="POST">

                    <c:choose>
                        <c:when test="${not empty usuarioEdit}">
                            <input type="hidden" name="accion" value="actualizar">
                            <input type="hidden" name="id" value="${usuarioEdit.id_usuario}">
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="accion" value="guardar">
                        </c:otherwise>
                    </c:choose>

                    <!-- ROL -->
                    <div class="grupo-formulario">
                        <label for="txtIdRol">Rol</label>
                        <select id="txtIdRol" name="txtIdRol" required>
                            <option value="">Seleccione un rol</option>
                            <c:forEach var="rol" items="${listaRoles}">
                                <option value="${rol.id_rol}" ${rol.id_rol == usuarioEdit.id_rol ? 'selected' : ''}>${rol.nombre_rol}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- TIPO DOCUMENTO -->
                    <div class="grupo-formulario">
                        <label for="txtIdTipoDocumento">Tipo de Documento</label>
                        <select id="txtIdTipoDocumento" name="txtIdTipoDocumento" required>
                            <option value="">Seleccione un tipo de documento</option>
                            <c:forEach var="td" items="${listaTiposDocumento}">
                                <option value="${td.id_tipo_documento}" ${td.id_tipo_documento == usuarioEdit.id_tipo_documento ? 'selected' : ''}>${td.descripcion_tipo_documento}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- TIPO SANGRE -->
                    <div class="grupo-formulario">
                        <label for="txtIdTipoSangre">Tipo de Sangre</label>
                        <select id="txtIdTipoSangre" name="txtIdTipoSangre" required>
                            <option value="">Seleccione un tipo de sangre</option>
                            <c:forEach var="ts" items="${listaTiposSangre}">
                                <option value="${ts.id_tipo_sangre}" ${ts.id_tipo_sangre == usuarioEdit.id_tipo_sangre ? 'selected' : ''}>${ts.nombre_tipo}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- NUMERO DOCUMENTO -->
                    <div class="grupo-formulario">
                        <label for="txtNumeroDocumento">Número Documento</label>
                        <input type="text" id="txtNumeroDocumento" name="txtNumeroDocumento" value="${usuarioEdit.numero_documento}" required>
                    </div>

                    <!-- NOMBRE -->
                    <div class="grupo-formulario">
                        <label for="txtNombre">Nombre Completo</label>
                        <input type="text" id="txtNombre" name="txtNombre" value="${usuarioEdit.nombre_completo}" required>
                    </div>

                    <!-- EMAIL -->
                    <div class="grupo-formulario">
                        <label for="txtEmail">Email</label>
                        <input type="email" id="txtEmail" name="txtEmail" value="${usuarioEdit.email}" required>
                    </div>

                    <!-- PASSWORD -->
                    <div class="grupo-formulario">
                        <label for="txtPassword">Contraseña</label>
                        <input type="password" id="txtPassword" name="txtPassword" value="${usuarioEdit.password}" required>
                    </div>

                    <!-- FECHA -->
                    <div class="grupo-formulario">
                        <label for="txtFechaNacimiento">Fecha Nacimiento</label>
                        <input type="date" id="txtFechaNacimiento" name="txtFechaNacimiento" value="${usuarioEdit.fecha_nacimiento}" required>
                    </div>

                    <!-- ALERGIAS -->
                    <div class="grupo-formulario">
                        <label for="txtAlergias">Alergias Conocidas</label>
                        <input type="text" id="txtAlergias" name="txtAlergias" value="${usuarioEdit.alergias_conocidas}" required>
                    </div>

                    <!-- BOTON -->
                    <div class="contenedor-botones">
                        <button type="submit" class="btn-guardar">
                            <c:choose>
                                <c:when test="${not empty usuarioEdit}">Actualizar Usuario</c:when>
                                <c:otherwise>Registrar Usuario</c:otherwise>
                            </c:choose>
                        </button>

                        <c:if test="${not empty usuarioEdit}">
                            <a href="${ctx}/Servletregistrarusuario" class="btn-cancelar">Cancelar</a>
                        </c:if>
                    </div>

                </form>

                <!-- TABLA DE REGISTROS -->
                <div class="tabla-contenedor" style="margin-top: 30px;">
                    <h2>Usuarios Registrados</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Documento</th>
                                <th>Nombre</th>
                                <th>Email</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${lista}">
                                <tr>
                                    <td>${u.id_usuario}</td>
                                    <td>${u.numero_documento}</td>
                                    <td>${u.nombre_completo}</td>
                                    <td>${u.email}</td>
                                    <td>
                                        <a class="btn-editar" 
                                           href="${ctx}/Servletregistrarusuario?accion=editar&id=${u.id_usuario}">
                                            Editar
                                        </a>

                                        <a class="btn-eliminar" 
                                           href="javascript:void(0);" 
                                           onclick="confirmarEliminar('${ctx}/Servletregistrarusuario?accion=eliminar&id=${u.id_usuario}')">
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
        if (confirm("¿Estás seguro de que deseas eliminar este usuario?")) {
            window.location.href = url;
        }
    }
</script>

</body>
</html>
