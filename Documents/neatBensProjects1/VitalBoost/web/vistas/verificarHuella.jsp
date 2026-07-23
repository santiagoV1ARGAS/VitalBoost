<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Validación Biométrica - VitalBoost</title>
    <link rel="stylesheet" href="${ctx}/css/verificarHuella.css">
</head>
<body>

<div class="biometric-card">
    <div class="alert-icon">🔒</div>
    <h2>Filtro de Seguridad Biométrica</h2>
    <p class="instruction">
        Se ha localizado el registro de: <br>
        <strong><c:out value="${nombrePaciente}"/></strong>
    </p>
    <p class="sub-instruction">Por favor, solicite al paciente colocar su dedo índice en el lector biométrico conectado para autorizar el acceso.</p>

    <form action="${ctx}/ServletLogin" method="POST">
        <input type="hidden" name="txtDocumentoPaciente" value="${docPaciente}" />

        <div class="scanner-container">
            <div class="fingerprint-icon">📌</div>
            <span class="pulse-ring"></span>
        </div>

        <button type="submit" name="accion" value="ConfirmarHuella" class="btn-scan">
            Simular Lectura de Huella
        </button>
    </form>

    <a href="${ctx}/vistas/buscarpaciente.jsp" class="cancel-link">Cancelar Consulta</a>
</div>

</body>
</html>