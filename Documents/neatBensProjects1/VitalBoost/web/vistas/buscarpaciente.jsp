<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buscar Paciente - VitalBoost</title>
    
    <%-- Vinculación al CSS externo --%>
    <link rel="stylesheet" href="${ctx}/css/buscarpaciente.css">
</head>
<body>

<div class="search-card">
    <h2>Módulo de Emergencia</h2>
    <p>Ingrese el documento de identidad del paciente para consultar su Hoja de Vida Médica.</p>

<form action="${ctx}/ServletLogin" method="POST">        
        <div class="form-group">
            <label for="txtDocumento">Número de Documento</label>
            <input type="text" id="txtDocumento" name="txtDocumento" placeholder="Ej: 1023456789" required>
            
            <c:if test="${not empty errorBusqueda}">
                <small class="error-msg">${errorBusqueda}</small>
            </c:if>
        </div>

        <button type="submit" name="accion" value="BuscarPaciente">
            Consultar Historial Clínico
        </button>
    </form>

    <a href="${ctx}/ServletLogin?accion=Salir" class="back-link">Volver al Login</a>
</div>

</body>
</html>