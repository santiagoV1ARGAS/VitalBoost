<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro exitoso - VitalBoost</title>
    <link rel="stylesheet" href="${ctx}/css/registroExitoso.css">
</head>

<body>

<%@ include file="/includes/loader.jspf" %>

    <div class="exito-blob exito-blob--1"></div>
    <div class="exito-blob exito-blob--2"></div>
    <div class="exito-blob exito-blob--3"></div>

    <div class="exito-card">

        <div class="exito-icono">
            <svg viewBox="0 0 24 24" fill="none" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                <path d="M20 6 9 17l-5-5"/>
            </svg>
        </div>

        <h1>¡Registro exitoso!</h1>
        <p class="exito-sub">
            Gracias, <strong><c:out value="${nombrePaciente}" /></strong>.
            Este es tu código QR de emergencia.
        </p>

        <div class="exito-nota">
            <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="12" cy="12" r="10"/><path d="M12 16v-4M12 8h.01"/>
            </svg>
            <span>
                Guarda o imprime este código: no necesitas iniciar sesión para usarlo.
                Cualquier personal médico podrá escanearlo en caso de emergencia
                para ver tu hoja de vida (tipo de sangre, EPS, alergias y medicamentos).
            </span>
        </div>

        <div class="exito-qr-box">
            <img src="${qrImageUrl}" alt="Código QR de emergencia">
        </div>

        <p class="exito-url">
            <c:out value="${urlHojaVida}" />
        </p>

        <div class="exito-acciones">
            <a href="${urlHojaVida}" target="_blank" class="exito-btn exito-btn--primary">
                Ver mi Hoja de Vida
            </a>
            <a href="${ctx}/index.jsp" class="exito-btn exito-btn--secundario">
                Volver al Inicio
            </a>
        </div>

    </div>

</body>
</html>
