<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro</title>
    <link rel="stylesheet" href="${ctx}/css/registro.css">
</head>

<body>

<form action="${ctx}/ServletRegistro" method="POST">
    <input type="hidden" name="accion" value="Registrar">

    <div class="form-wrapper">

        <div class="form-header">
            <h2>Registro</h2>
            <p>Completa los datos para continuar</p>
        </div>

        <!-- MENSAJES GENERALES -->
        <c:if test="${not empty error}">
            <div class="msg error">${error}</div>
        </c:if>

        <c:if test="${not empty msj}">
            <div class="msg success">${msj}</div>
        </c:if>

        <!-- NOMBRE -->
        <div class="form-field">
            <label>Nombre completo</label>
            <input type="text" name="txtNombre" placeholder="Ej. Laura Gómez Torres" required />
            <c:if test="${not empty errorNombre}">
                <small class="msg error">${errorNombre}</small>
            </c:if>
        </div>

        <!-- TIPO DOCUMENTO -->
        <div class="form-field">
            <label>Tipo documento</label>
            <select name="txtIdTipoDoc" required>
                <option value="">Seleccione</option>
                <c:forEach var="doc" items="${listaDocumentos}">
                    <option value="${doc.id_tipo_documento}">
                        ${doc.descripcion_tipo_documento}
                    </option>
                </c:forEach>
            </select>
            <c:if test="${not empty errorTipoDoc}">
                <small class="msg error">${errorTipoDoc}</small>
            </c:if>
        </div>

        <!-- DOCUMENTO -->
        <div class="form-field">
            <label>Número de identificación</label>
            <input type="text" name="txtNumeroDocumento" placeholder="Ej. 1023456789" required />
            <c:if test="${not empty errorDocumento}">
                <small class="msg error">${errorDocumento}</small>
            </c:if>
        </div>

        <!-- EMAIL -->
        <div class="form-field">
            <label>Correo electrónico</label>
            <input type="email" name="txtEmail" required />
            <c:if test="${not empty errorEmail}">
                <small class="msg error">${errorEmail}</small>
            </c:if>
        </div>

        <!-- PASSWORD -->
        <div class="form-field">
            <label>Contraseña</label>
            <input type="password" name="txtPassword" required />
            <c:if test="${not empty errorPassword}">
                <small class="msg error">${errorPassword}</small>
            </c:if>
        </div>

        <!-- FECHA NACIMIENTO -->
        <div class="form-field">
            <label>Fecha nacimiento</label>
            <input type="date" name="txtFecha" required />
            <c:if test="${not empty errorFecha}">
                <small class="msg error">${errorFecha}</small>
            </c:if>
        </div>

        <!-- TIPO SANGRE -->
        <div class="form-field">
            <label>Tipo sangre</label>
            <select name="txtIdSangre" required>
                <option value="">Seleccione</option>
                <c:forEach var="s" items="${listaSangres}">
                    <option value="${s.id_tipo_sangre}">
                        ${s.nombre_tipo}
                    </option>
                </c:forEach>
            </select>
            <c:if test="${not empty errorSangre}">
                <small class="msg error">${errorSangre}</small>
            </c:if>
        </div>

        <!-- ROL -->
        <div class="form-field">
            <label>Rol</label>
            <select name="txtIdRol" required>
                <option value="">Seleccione</option>
                <c:forEach var="r" items="${listaRoles}">
                    <option value="${r.id_rol}">
                        ${r.nombre_rol}
                    </option>
                </c:forEach>
            </select>
            <c:if test="${not empty errorRol}">
                <small class="msg error">${errorRol}</small>
            </c:if>
        </div>

        <!-- ALERGIAS -->
        <div class="form-field">
            <label>Alergias conocidas</label>
            <textarea name="txtAlergias" rows="3" placeholder="Describe las alergias"></textarea>
        </div>

        <!-- BOTÓN -->
        <button type="submit" class="form-submit">Registrar</button>

    </div>
</form>

</body>
</html>