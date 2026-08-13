<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />


<c:choose>
    <c:when test="${not empty perfilPaciente}">
        <c:set var="u" value="${perfilPaciente}" />
        <c:set var="esMedico" value="${origenAcceso == 'medico'}" />
        <c:set var="esQR" value="${origenAcceso == 'qr'}" />
    </c:when>
    <c:otherwise>
        <c:set var="u" value="${sessionScope.usuarioLogueado}" />
        <c:set var="esMedico" value="false" />
        <c:set var="esQR" value="false" />
    </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hoja de Vida Médica - VitalBoost</title>
    <link rel="stylesheet" href="${ctx}/css/perfil.css">
    <link rel="stylesheet" href="${ctx}/css/global.css">
</head>
<body>

<%@ include file="/includes/loader.jspf" %>

<c:choose>

    <c:when test="${not empty errorQR}">

        <%-- =====================================
             CÓDIGO QR INVÁLIDO O PACIENTE NO ENCONTRADO
        ====================================== --%>
        <div class="resume-container">
            <header class="resume-header">
                <div class="patient-title">
                    <h1>Código no válido</h1>
                    <span class="badge-role">Acceso de Emergencia por QR</span>
                </div>
            </header>
            <div class="resume-body">
                <section class="resume-section alert-section">
                    <p><c:out value="${errorQR}" /></p>
                </section>
            </div>
            <footer class="resume-footer">
                <a href="${ctx}/index.jsp" class="btn btn-secondary">Volver al Inicio</a>
            </footer>
        </div>

    </c:when>

    <c:otherwise>

<div class="resume-container">

    <header class="resume-header">
        <div class="patient-title">
            <div class="avatar-circle">
                <c:out value="${fn:length(u.nombre_completo) > 0 ? fn:substring(u.nombre_completo, 0, 1) : '?'}" />
            </div>
            <div>
                <h1><c:out value="${u.nombre_completo}" /></h1>
                <span class="badge-role">
                    <c:choose>
                        <c:when test="${esMedico}">Vista de Emergencia Médico</c:when>
                        <c:when test="${esQR}">🚨 Acceso de Emergencia por Código QR</c:when>
                        <c:otherwise>Perfil de Paciente</c:otherwise>
                    </c:choose>
                </span>
            </div>
        </div>
        <div class="vital-blood">
            <small>TIPO DE SANGRE</small>
            <h2>
                <c:choose>
                    <c:when test="${not empty u.nombreTipoSangre}"><c:out value="${u.nombreTipoSangre}" /></c:when>
                    <c:otherwise>No registrado</c:otherwise>
                </c:choose>
            </h2>
        </div>
    </header>

    <div class="resume-body">
        
        <section class="resume-section">
            <h3>🪪 Identificación y Datos Personales</h3>
            <div class="grid-2-col">
                <div class="data-group">
                    <label>Tipo de Documento</label>
                    <p>
                        <c:choose>
                            <c:when test="${not empty u.nombreTipoDocumento}"><c:out value="${u.nombreTipoDocumento}" /></c:when>
                            <c:otherwise>No registrado</c:otherwise>
                        </c:choose>
                    </p>
                </div>
                <div class="data-group">
                    <label>Número de Documento</label>
                    <p><c:out value="${u.numero_documento}" /></p>
                </div>
                <div class="data-group">
                    <label>Fecha de Nacimiento</label>
                    <p><c:out value="${u.fecha_nacimiento}" /></p>
                </div>
                <div class="data-group">
                    <label>Correo de Contacto</label>
                    <p><c:out value="${u.email}" /></p>
                </div>
            </div>
        </section>

        <section class="resume-section contact-section">
            <h3>📞 Contacto de Emergencia</h3>

            <c:choose>
                <c:when test="${not empty contactosEmergencia}">
                    <div class="contact-grid">
                        <c:forEach var="c" items="${contactosEmergencia}">
                            <div class="contact-card">
                                <div class="contact-avatar"><c:out value="${fn:length(c.nombre_contacto) > 0 ? fn:substring(c.nombre_contacto, 0, 1) : '?'}" /></div>
                                <div class="contact-info">
                                    <p class="contact-name"><c:out value="${c.nombre_contacto}" /></p>
                                    <span class="contact-relation"><c:out value="${c.parentesco}" /></span>
                                    <a class="contact-phone" href="tel:${c.telefono}">📱 <c:out value="${c.telefono}" /></a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="textarea-display">
                        <span class="no-data">Este paciente no tiene contactos de emergencia registrados.</span>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>

        <section class="resume-section medica-section">
            <h3>🩺 Información Médica Importante</h3>
            <div class="medica-grid">

                <div class="medica-card medica-card--info">
                    <label>EPS</label>
                    <p>
                        <c:choose>
                            <c:when test="${not empty u.eps}"><c:out value="${u.eps}" /></c:when>
                            <c:otherwise><span class="no-data">No registrada.</span></c:otherwise>
                        </c:choose>
                    </p>
                </div>

                <div class="medica-card medica-card--alerta">
                    <label>Alergias Conocidas</label>
                    <p>
                        <c:choose>
                            <c:when test="${not empty u.alergias_conocidas}"><c:out value="${u.alergias_conocidas}" /></c:when>
                            <c:otherwise><span class="no-data">No registra alergias conocidas.</span></c:otherwise>
                        </c:choose>
                    </p>
                </div>

                <div class="medica-card medica-card--info">
                    <label>Medicamentos Actuales</label>
                    <p>
                        <c:choose>
                            <c:when test="${not empty u.medicamentos_actuales}"><c:out value="${u.medicamentos_actuales}" /></c:when>
                            <c:otherwise><span class="no-data">No registra medicamentos actuales.</span></c:otherwise>
                        </c:choose>
                    </p>
                </div>

            </div>
        </section>

    </div>

    <footer class="resume-footer">
        <c:choose>
            <c:when test="${esMedico}">
                <a href="${ctx}/vistas/buscarpaciente.jsp" class="btn btn-secondary">← Volver al Buscador</a>
            </c:when>
            <c:when test="${esQR}">
                <a href="${ctx}/index.jsp" class="btn btn-secondary">Volver al Inicio</a>
            </c:when>
            <c:otherwise>
                <a href="${ctx}/vistas/dashboard.jsp" class="btn btn-secondary">Volver al Panel</a>
                <a href="#" class="btn btn-primary">Editar Historial Clínico</a>
            </c:otherwise>
        </c:choose>
    </footer>

</div>

    </c:otherwise>

</c:choose>

</body>
</html>
