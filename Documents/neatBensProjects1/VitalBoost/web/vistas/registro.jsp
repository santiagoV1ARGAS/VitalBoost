<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Regístrate - VitalBoost</title>

    <link rel="stylesheet" href="${ctx}/css/registro.css">
    <link rel="stylesheet" href="${ctx}/css/global.css">
</head>

<body>

<%@ include file="/includes/loader.jspf" %>

<main class="main-container">

    <!-- ================================================= -->
    <!-- PANEL IZQUIERDO — mismo lenguaje visual que login   -->
    <!-- ================================================= -->
    <section class="left-panel">

        <a href="${ctx}/index.jsp" class="left-logo">
            <div class="logo-icono">
                <svg viewBox="0 0 24 24" fill="none" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M20.8 6.6c-1.8-3.4-6.2-4.2-8.8-1.6l-.9.9-.9-.9C7.6 2.4 3.2 3.2 1.4 6.6c-1.5 2.9-.7 6.4 1.9 9l7.7 7.6 7.7-7.6c2.6-2.6 3.4-6.1 1.9-9z"/><path d="M6 12h3l1.5-3 2 6 1.5-3H18"/></svg>
            </div>
            <span>Vital<b>Boost</b></span>
        </a>

        <div class="left-content">

            <div class="left-badge">
                <span class="punto"></span>
                Tu QR de emergencia en minutos
            </div>

            <h1>Crea tu <span>hoja de vida médica</span></h1>

            <p>
                Completa tus datos para generar tu código QR de emergencia.
                Cualquier persona podrá escanearlo para ver tu información
                médica crítica cuando más la necesites.
            </p>

            <!-- Pasos dinámicos: se resaltan según la sección visible del formulario -->
            <ol class="left-steps" id="listaPasos">
                <li class="paso" data-paso="1">
                    <span class="paso-num">1</span>
                    <div class="paso-texto">
                        <strong>Datos personales</strong>
                        <small>Quién eres y cómo contactarte</small>
                    </div>
                </li>
                <li class="paso" data-paso="2">
                    <span class="paso-num">2</span>
                    <div class="paso-texto">
                        <strong>Datos médicos</strong>
                        <small>Tipo de sangre y alergias</small>
                    </div>
                </li>
                <li class="paso" data-paso="3">
                    <span class="paso-num">3</span>
                    <div class="paso-texto">
                        <strong>Contacto de emergencia</strong>
                        <small>A quién avisar si te encuentran</small>
                    </div>
                </li>
            </ol>

            <div class="left-progreso">
                <div class="left-progreso-barra">
                    <div class="left-progreso-fill" id="progresoFill"></div>
                </div>
                <span id="progresoTexto">0% completado</span>
            </div>

        </div>

    </section>

    <!-- ================================================= -->
    <!-- PANEL DERECHO — formulario de registro              -->
    <!-- ================================================= -->
    <section class="right-panel">

        <div class="registro-card">

            <a href="${ctx}/index.jsp" class="back-link back-link-top">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><line x1="19" y1="12" x2="5" y2="12"/><polyline points="12 19 5 12 12 5"/></svg>
                Volver al inicio
            </a>

            <div class="registro-header">
                <h2>Regístrate</h2>
                <p>Completa los tres pasos para obtener tu código QR</p>
            </div>

            <form class="form-registro" id="formRegistro" action="${ctx}/ServletRegistro" method="POST" novalidate>
                <input type="hidden" name="accion" value="Registrar">

                <!-- MENSAJES GENERALES -->
                <c:if test="${not empty error}">
                    <div class="msg-box error">${error}</div>
                </c:if>

                <c:if test="${not empty msj}">
                    <div class="msg-box success">${msj}</div>
                </c:if>

                <!-- ============================= -->
                <!-- SECCIÓN 1: DATOS PERSONALES    -->
                <!-- ============================= -->
                <fieldset class="form-section" data-paso="1">
                    <legend><span class="section-num">1</span> Datos personales</legend>

                    <div class="form-field">
                        <label for="txtNombre">Nombre completo</label>
                        <input type="text" id="txtNombre" name="txtNombre"
                               placeholder="Ej. Laura Gómez Torres"
                               value="${param.txtNombre}" required />
                        <c:if test="${not empty errorNombre}">
                            <small class="msg error">${errorNombre}</small>
                        </c:if>
                    </div>

                    <div class="form-row">
                        <div class="form-field">
                            <label for="txtIdTipoDoc">Tipo documento</label>
                            <select id="txtIdTipoDoc" name="txtIdTipoDoc" required>
                                <option value="">Seleccione</option>
                                <c:forEach var="doc" items="${listaDocumentos}">
                                    <option value="${doc.id_tipo_documento}"
                                            ${param.txtIdTipoDoc == doc.id_tipo_documento ? 'selected' : ''}>
                                        ${doc.descripcion_tipo_documento}
                                    </option>
                                </c:forEach>
                            </select>
                            <c:if test="${not empty errorTipoDoc}">
                                <small class="msg error">${errorTipoDoc}</small>
                            </c:if>
                        </div>

                        <div class="form-field">
                            <label for="txtNumeroDocumento">Número de identificación</label>
                            <input type="text" id="txtNumeroDocumento" name="txtNumeroDocumento"
                                   placeholder="Ej. 1023456789"
                                   value="${param.txtNumeroDocumento}" required />
                            <c:if test="${not empty errorDocumento}">
                                <small class="msg error">${errorDocumento}</small>
                            </c:if>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-field">
                            <label for="txtEmail">Correo electrónico</label>
                            <input type="email" id="txtEmail" name="txtEmail"
                                   placeholder="nombre@ejemplo.com"
                                   value="${param.txtEmail}" required />
                            <c:if test="${not empty errorEmail}">
                                <small class="msg error">${errorEmail}</small>
                            </c:if>
                        </div>

                        <div class="form-field">
                            <label for="txtPassword">Contraseña</label>
                            <input type="password" id="txtPassword" name="txtPassword"
                                   placeholder="Mínimo 6 caracteres" required />
                            <div class="fuerza-clave" id="fuerzaClave">
                                <span></span><span></span><span></span>
                            </div>
                            <c:if test="${not empty errorPassword}">
                                <small class="msg error">${errorPassword}</small>
                            </c:if>
                        </div>
                    </div>

                    <div class="form-field">
                        <label for="txtFecha">Fecha de nacimiento</label>
                        <input type="date" id="txtFecha" name="txtFecha"
                               value="${param.txtFecha}" required />
                        <c:if test="${not empty errorFecha}">
                            <small class="msg error">${errorFecha}</small>
                        </c:if>
                    </div>
                </fieldset>

                <!-- ============================= -->
                <!-- SECCIÓN 2: DATOS MÉDICOS       -->
                <!-- ============================= -->
                <fieldset class="form-section" data-paso="2">
                    <legend><span class="section-num">2</span> Datos médicos</legend>

                    <div class="form-field">
                        <label for="txtIdSangre">Tipo de sangre</label>
                        <select id="txtIdSangre" name="txtIdSangre" required>
                            <option value="">Seleccione</option>
                            <c:forEach var="s" items="${listaSangres}">
                                <option value="${s.id_tipo_sangre}"
                                        ${param.txtIdSangre == s.id_tipo_sangre ? 'selected' : ''}>
                                    ${s.nombre_tipo}
                                </option>
                            </c:forEach>
                        </select>
                        <c:if test="${not empty errorSangre}">
                            <small class="msg error">${errorSangre}</small>
                        </c:if>
                    </div>

                    <div class="form-field">
                        <label for="txtEps">EPS</label>
                        <input type="text" id="txtEps" name="txtEps"
                               placeholder="Ej. Sura, Sanitas, Nueva EPS... (opcional)"
                               value="${param.txtEps}">
                    </div>

                    <div class="form-field">
                        <label for="txtAlergias">Alergias conocidas</label>
                        <textarea id="txtAlergias" name="txtAlergias" rows="3"
                                  placeholder="Describe las alergias (déjalo vacío si no tienes)">${param.txtAlergias}</textarea>
                    </div>

                    <div class="form-field">
                        <label for="txtMedicamentos">Medicamentos que tomas actualmente</label>
                        <textarea id="txtMedicamentos" name="txtMedicamentos" rows="3"
                                  placeholder="Ej. Losartán 50mg cada 12h (déjalo vacío si no tomas ninguno)">${param.txtMedicamentos}</textarea>
                    </div>
                </fieldset>

                <!-- ============================= -->
                <!-- SECCIÓN 3: CONTACTO EMERGENCIA -->
                <!-- ============================= -->
                <fieldset class="form-section highlight" data-paso="3">
                    <legend><span class="section-num">3</span> Contacto de emergencia</legend>
                    <p class="section-hint">
                        Esta es la persona a la que podrán llamar si te encuentran
                        en una emergencia.
                    </p>

                    <div class="form-field">
                        <label for="txtNombreContacto">Nombre del contacto</label>
                        <input type="text" id="txtNombreContacto" name="txtNombreContacto"
                               placeholder="Ej. María Torres"
                               value="${param.txtNombreContacto}" required />
                        <c:if test="${not empty errorNombreContacto}">
                            <small class="msg error">${errorNombreContacto}</small>
                        </c:if>
                    </div>

                    <div class="form-row">
                        <div class="form-field">
                            <label for="txtParentescoContacto">Parentesco</label>
                            <input type="text" id="txtParentescoContacto" name="txtParentescoContacto"
                                   placeholder="Ej. Madre, hermano, pareja..."
                                   value="${param.txtParentescoContacto}" />
                        </div>

                        <div class="form-field">
                            <label for="txtTelefonoContacto">Número de emergencia</label>
                            <input type="tel" id="txtTelefonoContacto" name="txtTelefonoContacto"
                                   placeholder="Ej. 3001234567"
                                   value="${param.txtTelefonoContacto}" required />
                            <c:if test="${not empty errorTelefonoContacto}">
                                <small class="msg error">${errorTelefonoContacto}</small>
                            </c:if>
                        </div>
                    </div>
                </fieldset>

                <button type="submit" class="btn-ingresar">
                    Registrarme y generar mi QR
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"/><polyline points="10 17 15 12 10 7"/><line x1="15" y1="12" x2="3" y2="12"/></svg>
                </button>

                <div class="footer-link" style="margin-top: 20px;">
                    <p>¿Ya tienes una cuenta?</p>
                    <a href="${ctx}/ServletLogin">Inicia sesión</a>
                </div>

            </form>

        </div>

    </section>

</main>

<script>
(function () {
    var form = document.getElementById('formRegistro');
    var secciones = Array.prototype.slice.call(form.querySelectorAll('.form-section'));
    var pasos = Array.prototype.slice.call(document.querySelectorAll('#listaPasos .paso'));
    var progresoFill = document.getElementById('progresoFill');
    var progresoTexto = document.getElementById('progresoTexto');
    var todosCampos = Array.prototype.slice.call(form.querySelectorAll('input[required], select[required], textarea[required]'));

    /* --- Resalta el paso activo del panel izquierdo al hacer scroll por el form --- */
    var observador = new IntersectionObserver(function (entradas) {
        entradas.forEach(function (entrada) {
            var num = entrada.target.getAttribute('data-paso');
            var pasoEl = document.querySelector('.paso[data-paso="' + num + '"]');
            if (!pasoEl) { return; }
            if (entrada.isIntersecting) {
                pasos.forEach(function (p) { p.classList.remove('activo'); });
                pasoEl.classList.add('activo');
            }
        });
    }, { threshold: 0.35, rootMargin: '-10% 0px -40% 0px' });

    secciones.forEach(function (s) { observador.observe(s); });

    /* --- Barra de progreso dinámica según campos obligatorios completados --- */
    function actualizarProgreso() {
        var llenos = todosCampos.filter(function (c) { return c.value && c.value.trim() !== ''; }).length;
        var porcentaje = todosCampos.length ? Math.round((llenos / todosCampos.length) * 100) : 0;
        progresoFill.style.width = porcentaje + '%';
        progresoTexto.textContent = porcentaje + '% completado';

        secciones.forEach(function (sec) {
            var campos = Array.prototype.slice.call(sec.querySelectorAll('input[required], select[required], textarea[required]'));
            var completa = campos.length > 0 && campos.every(function (c) { return c.value && c.value.trim() !== ''; });
            var num = sec.getAttribute('data-paso');
            var pasoEl = document.querySelector('.paso[data-paso="' + num + '"]');
            if (pasoEl) { pasoEl.classList.toggle('completo', completa); }
        });
    }

    todosCampos.forEach(function (c) {
        c.addEventListener('input', actualizarProgreso);
        c.addEventListener('change', actualizarProgreso);
    });
    actualizarProgreso();

    /* --- Medidor visual simple de fuerza de contraseña --- */
    var passInput = document.getElementById('txtPassword');
    var fuerza = document.querySelectorAll('#fuerzaClave span');

    passInput.addEventListener('input', function () {
        var val = passInput.value;
        var puntos = 0;
        if (val.length >= 6) { puntos++; }
        if (val.length >= 10 || (/[A-Z]/.test(val) && /[0-9]/.test(val))) { puntos++; }
        if (val.length >= 10 && /[A-Z]/.test(val) && /[0-9]/.test(val) && /[^A-Za-z0-9]/.test(val)) { puntos++; }

        fuerza.forEach(function (barra, i) {
            barra.classList.toggle('activa', i < puntos);
            barra.classList.remove('debil', 'media', 'fuerte');
            if (i < puntos) {
                barra.classList.add(puntos === 1 ? 'debil' : puntos === 2 ? 'media' : 'fuerte');
            }
        });
    });
})();
</script>

</body>
</html>
