<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<c:if test="${empty usuarioLogueado}">
    <c:redirect url="/ServletLogin"/>
</c:if>

<%-- Si alguien entra directo por la URL del JSP (sin pasar por el
     servlet) igual lo mandamos por /DashboardPaciente para que
     lleguen el QR, los contactos y el catálogo de tipos de sangre. --%>
<c:if test="${empty qrImageUrl}">
    <c:redirect url="/DashboardPaciente"/>
</c:if>

<c:set var="u" value="${usuarioLogueado}" />
<c:if test="${not empty contactosEmergencia}">
    <c:set var="contactoPrincipal" value="${contactosEmergencia[0]}" />
</c:if>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Panel - VitalBoost</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${ctx}/css/dashboard.css">
    <link rel="stylesheet" href="${ctx}/css/global.css">
</head>
<body>

<%@ include file="/includes/loader.jspf" %>

<header class="vb-header">
    <a href="${ctx}/vistas/dashboard.jsp" class="vb-logo">
        <div class="vb-logo-icono">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M20.8 6.6c-1.8-3.4-6.2-4.2-8.8-1.6l-.9.9-.9-.9C7.6 2.4 3.2 3.2 1.4 6.6c-1.5 2.9-.7 6.4 1.9 9l7.7 7.6 7.7-7.6c2.6-2.6 3.4-6.1 1.9-9z"/><path d="M6 12h3l1.5-3 2 6 1.5-3H18"/></svg>
        </div>
        <span>Vital<b>Boost</b></span>
    </a>

    <div class="user-info">
        <span class="saludo">
            Hola, <strong><c:out value="${u.nombre_completo}" /></strong>
        </span>
        <a href="${ctx}/ServletCerrarSesion" class="btn-salir">Cerrar Sesión</a>
    </div>
</header>

<main class="vb-main">

    <c:if test="${not empty flashSuccess}">
        <div class="flash-msg flash-ok"><c:out value="${flashSuccess}" /></div>
    </c:if>
    <c:if test="${not empty flashError}">
        <div class="flash-msg flash-error"><c:out value="${flashError}" /></div>
    </c:if>

    <!-- HERO -->
    <section class="hero">
        <div class="hero-texto">
            <h2>Cuidamos de ti hoy</h2>
            <p>Tu hoja de vida médica, tu código QR de emergencia y tus datos, todo en un solo lugar.</p>
        </div>
        <div class="hero-sangre">
            <small>TIPO DE SANGRE</small>
            <strong>
                <c:choose>
                    <c:when test="${not empty u.nombreTipoSangre}"><c:out value="${u.nombreTipoSangre}" /></c:when>
                    <c:otherwise>No registrado</c:otherwise>
                </c:choose>
            </strong>
        </div>
    </section>

    <!-- PESTAÑAS -->
    <nav class="vb-tabs" role="tablist">
        <button type="button" class="vb-tab activo" data-tab="historial">🩺 Hoja de Vida</button>
        <button type="button" class="vb-tab" data-tab="qr">📱 Mi Código QR</button>
        <button type="button" class="vb-tab" data-tab="editar">✏️ Editar Datos</button>
    </nav>

    <!-- PANEL: HOJA DE VIDA -->
    <section class="vb-panel activo" id="panel-historial">
        <div class="panel-card">

            <div class="panel-card-header">
                <div class="avatar-circle">
                    <c:out value="${fn:length(u.nombre_completo) > 0 ? fn:substring(u.nombre_completo, 0, 1) : '?'}" />
                </div>
                <div>
                    <h3><c:out value="${u.nombre_completo}" /></h3>
                    <span class="badge-role">Perfil de Paciente</span>
                </div>
            </div>

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

            <div class="resume-section contact-section">
                <h4>📞 Contacto de Emergencia</h4>
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
                            <span class="no-data">Aún no registras un contacto de emergencia.</span>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="resume-section medica-section">
                <h4>🩺 Información Médica Importante</h4>
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
            </div>

            <div class="panel-card-footer">
                <a href="${ctx}/vistas/perfil.jsp" target="_blank" class="btn btn-secondary">Ver hoja de vida completa</a>
                <button type="button" class="btn btn-primary" data-goto-tab="editar">Editar Historial Clínico</button>
            </div>

        </div>
    </section>

    <!-- PANEL: QR -->
    <section class="vb-panel" id="panel-qr">
        <div class="panel-card qr-card">
            <h3>Tu código QR de emergencia</h3>
            <p class="qr-desc">
                Cualquier personal médico puede escanear este código para ver tu tipo de
                sangre, alergias y contacto de emergencia al instante, sin que necesites
                iniciar sesión.
            </p>

            <img src="${qrImageUrl}" alt="Código QR de emergencia" class="qr-imagen">

            <p class="qr-url"><c:out value="${urlHojaVida}" /></p>

            <div class="qr-acciones">
                <a href="${urlHojaVida}" target="_blank" class="btn btn-primary">Ver mi Hoja de Vida</a>
                <a href="${qrImageUrl}" download="vitalboost-qr.png" class="btn btn-secondary">Descargar QR</a>
                <button type="button" class="btn btn-outline" id="btnCopiarEnlace" data-url="${urlHojaVida}">Copiar enlace</button>
            </div>
        </div>
    </section>

    <!-- PANEL: EDITAR DATOS -->
    <section class="vb-panel" id="panel-editar">
        <div class="panel-card">
            <h3>Editar mis datos</h3>
            <p class="qr-desc">Mantén tu hoja de vida médica al día para que esté lista en cualquier emergencia.</p>

            <form class="form-editar" action="${ctx}/EditarPaciente" method="POST">

                <fieldset class="form-section">
                    <legend>Datos personales</legend>

                    <div class="form-field">
                        <label for="txtNombre">Nombre completo</label>
                        <input type="text" id="txtNombre" name="txtNombre" value="${u.nombre_completo}" required>
                    </div>

                    <div class="form-row">
                        <div class="form-field">
                            <label for="txtEmail">Correo electrónico</label>
                            <input type="email" id="txtEmail" name="txtEmail" value="${u.email}" required>
                        </div>
                        <div class="form-field">
                            <label for="txtFecha">Fecha de nacimiento</label>
                            <input type="date" id="txtFecha" name="txtFecha" value="${u.fecha_nacimiento}" required>
                        </div>
                    </div>
                </fieldset>

                <fieldset class="form-section">
                    <legend>Datos médicos</legend>

                    <div class="form-field">
                        <label for="txtIdSangre">Tipo de sangre</label>
                        <select id="txtIdSangre" name="txtIdSangre" required>
                            <option value="">Seleccione</option>
                            <c:forEach var="s" items="${listaSangres}">
                                <option value="${s.id_tipo_sangre}" ${u.id_tipo_sangre == s.id_tipo_sangre ? 'selected' : ''}>
                                    ${s.nombre_tipo}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-field">
                        <label for="txtEps">EPS</label>
                        <input type="text" id="txtEps" name="txtEps" value="${u.eps}" placeholder="Ej. Sura, Sanitas, Nueva EPS...">
                    </div>

                    <div class="form-field">
                        <label for="txtAlergias">Alergias conocidas</label>
                        <textarea id="txtAlergias" name="txtAlergias" rows="3" placeholder="Déjalo vacío si no tienes">${u.alergias_conocidas}</textarea>
                    </div>

                    <div class="form-field">
                        <label for="txtMedicamentos">Medicamentos que tomas actualmente</label>
                        <textarea id="txtMedicamentos" name="txtMedicamentos" rows="3" placeholder="Ej. Losartán 50mg cada 12h. Déjalo vacío si no tomas ninguno">${u.medicamentos_actuales}</textarea>
                    </div>
                </fieldset>

                <fieldset class="form-section">
                    <legend>Contacto de emergencia</legend>

                    <div class="form-field">
                        <label for="txtNombreContacto">Nombre del contacto</label>
                        <input type="text" id="txtNombreContacto" name="txtNombreContacto" value="${contactoPrincipal.nombre_contacto}">
                    </div>

                    <div class="form-row">
                        <div class="form-field">
                            <label for="txtParentescoContacto">Parentesco</label>
                            <input type="text" id="txtParentescoContacto" name="txtParentescoContacto" value="${contactoPrincipal.parentesco}">
                        </div>
                        <div class="form-field">
                            <label for="txtTelefonoContacto">Número de emergencia</label>
                            <input type="tel" id="txtTelefonoContacto" name="txtTelefonoContacto" value="${contactoPrincipal.telefono}">
                        </div>
                    </div>
                </fieldset>

                <button type="submit" class="btn btn-primary btn-block">Guardar cambios</button>

            </form>
        </div>
    </section>

</main>

<footer class="vb-footer">
    <p>"Tu salud es nuestra prioridad número uno"</p>
</footer>

<script>
(function () {
    var tabs = Array.prototype.slice.call(document.querySelectorAll('.vb-tab'));
    var paneles = Array.prototype.slice.call(document.querySelectorAll('.vb-panel'));

    function activar(nombre) {
        tabs.forEach(function (t) { t.classList.toggle('activo', t.getAttribute('data-tab') === nombre); });
        paneles.forEach(function (p) { p.classList.toggle('activo', p.id === 'panel-' + nombre); });
    }

    tabs.forEach(function (t) {
        t.addEventListener('click', function () { activar(t.getAttribute('data-tab')); });
    });

    Array.prototype.slice.call(document.querySelectorAll('[data-goto-tab]')).forEach(function (btn) {
        btn.addEventListener('click', function () { activar(btn.getAttribute('data-goto-tab')); });
    });

    var btnCopiar = document.getElementById('btnCopiarEnlace');
    if (btnCopiar) {
        btnCopiar.addEventListener('click', function () {
            var url = btnCopiar.getAttribute('data-url');
            navigator.clipboard.writeText(url).then(function () {
                var textoOriginal = btnCopiar.textContent;
                btnCopiar.textContent = '¡Copiado!';
                setTimeout(function () { btnCopiar.textContent = textoOriginal; }, 1800);
            });
        });
    }
})();
</script>

</body>
</html>
