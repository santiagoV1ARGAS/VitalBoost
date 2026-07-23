<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />


<c:choose>
    <c:when test="${not empty perfilPaciente}">
        <c:set var="u" value="${perfilPaciente}" />
        <c:set var="esMedico" value="true" />
    </c:when>
    <c:otherwise>
        <c:set var="u" value="${sessionScope.usuarioLogueado}" />
        <c:set var="esMedico" value="false" />
    </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hoja de Vida Médica - VitalBoost</title>
    <link rel="stylesheet" href="${ctx}/css/perfil.css">
</head>
<body>

<div class="resume-container">
    
    <header class="resume-header">
        <div class="patient-title">
            <h1><c:out value="${u.nombre_completo}" /></h1>
            <span class="badge-role">
                <c:choose>
                    <c:when test="${esMedico}">Vista de Emergencia Médico</c:when>
                    <c:otherwise>Perfil de Paciente</c:otherwise>
                </c:choose>
            </span>
        </div>
        <div class="vital-blood">
            <small>TIPO DE SANGRE</small>
            <h2><c:out value="${u.nombreTipoSangre}" /></h2>
        </div>
    </header>

    <div class="resume-body">
        
        <section class="resume-section">
            <h3>Identification & Datos Personales</h3>
            <div class="grid-2-col">
                <div class="data-group">
                    <label>Tipo de Documento</label>
                    <p><c:out value="${u.nombreTipoDocumento}" /></p>
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

        <section class="resume-section alert-section">
            <h3>🚨 Alertas Médicas Críticas</h3>
            <div class="data-group full-width">
                <label>Alergias Conocidas</label>
                <div class="textarea-display">
                    <c:choose>
                        <c:when test="${not empty u.alergias_conocidas}">
                            <c:out value="${u.alergias_conocidas}" />
                        </c:when>
                        <c:otherwise>
                            <span class="no-data">No registra alergias conocidas.</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </section>

    </div>

    <footer class="resume-footer">
        <c:choose>
            <c:when test="${esMedico}">
                <a href="${ctx}/vistas/buscarpaciente.jsp" class="btn btn-secondary">← Volver al Buscador</a>
            </c:when>
            <c:otherwise>
                <a href="${ctx}/vistas/dashboard.jsp" class="btn btn-secondary">Volver al Panel</a>
                <a href="#" class="btn btn-primary">Editar Historial Clínico</a>
            </c:otherwise>
        </c:choose>
    </footer>

</div>

</body>
</html>