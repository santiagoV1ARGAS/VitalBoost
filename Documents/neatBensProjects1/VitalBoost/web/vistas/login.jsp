<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión - VitalBoost</title>

    <link rel="stylesheet" href="${ctx}/css/login.css">
    <link rel="stylesheet" href="${ctx}/css/global.css">
</head>

<body>

<%@ include file="/includes/loader.jspf" %>

<main class="main-container">

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
                Disponible las 24 horas, todos los días
            </div>

            <h1>Bienvenido de nuevo a <span>tu historial médico</span></h1>

            <p>Inicia sesión para consultar y gestionar tu información médica de forma rápida, segura y confiable.</p>

            <div class="left-features">

                <div class="left-feature">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="11" width="18" height="10" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                    <span>Datos cifrados y protegidos</span>
                </div>

                <div class="left-feature">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/><path d="M9 12l2 2 4-4"/></svg>
                    <span>Acceso solo a usuarios autorizados</span>
                </div>

                <div class="left-feature">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                    <span>Disponible las 24 horas</span>
                </div>

            </div>

        </div>

    </section>

    <section class="right-panel">

        <div class="login-card">

            <a href="${ctx}/index.jsp" class="back-link back-link-top">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><line x1="19" y1="12" x2="5" y2="12"/><polyline points="12 19 5 12 12 5"/></svg>
                Volver al inicio
            </a>

            <div class="login-header">
                <h2>Iniciar Sesión</h2>
                <p>Ingresa tus credenciales para continuar</p>
            </div>

            <form action="${ctx}/ServletLogin" method="POST">

                <div class="form-group">
                    <label for="txtEmail">Correo Electrónico</label>

                    <input type="email"
                           id="txtEmail"
                           name="txtEmail"
                           placeholder="nombre@ejemplo.com"
                           value="${txtEmailOld}">

                    <c:if test="${not empty errorEmail}">
                        <small class="msg error">${errorEmail}</small>
                    </c:if>
                </div>

                <div class="form-group">
                    <label for="txtPassword">Contraseña</label>

                    <input type="password"
                           id="txtPassword"
                           name="txtPassword"
                           placeholder="••••••••">

                    <c:if test="${not empty errorPassword}">
                        <small class="msg error">${errorPassword}</small>
                    </c:if>
                </div>

                <div class="form-group">
                    <label for="txtRol">Ingresar como</label>

                    <select id="txtRol" name="txtRol">
                        <option value="">Seleccione un rol</option>
                        <c:forEach var="rol" items="${listaRoles}">
                            <option value="${rol.id_rol}">${rol.nombre_rol}</option>
                        </c:forEach>
                    </select>

                    <c:if test="${not empty errorRol}">
                        <small class="msg error">${errorRol}</small>
                    </c:if>
                </div>

                <div class="form-group form-check">
                    <label class="check-label">
                        <input type="checkbox"
                               id="chkTerminos"
                               name="chkTerminos"
                               value="1"
                               ${not empty chkTerminosOld ? 'checked' : ''}>
                        Acepto los
                        <a href="${ctx}/vistas/terminosCondiciones.jsp" target="_blank">términos y condiciones</a>
                        de VitalBoost
                    </label>

                    <c:if test="${not empty errorTerminos}">
                        <small class="msg error">${errorTerminos}</small>
                    </c:if>
                </div>

                <button type="submit" name="accion" value="Ingresar" class="btn-ingresar">
                    Iniciar Sesión
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"/><polyline points="10 17 15 12 10 7"/><line x1="15" y1="12" x2="3" y2="12"/></svg>
                </button>

            </form>

            <div class="footer-link" style="margin-top: 20px;">
                <p>¿Eres paciente?</p>
                <a href="${ctx}/ServletRegistro">Regístrate y obtén tu código QR de emergencia</a>
            </div>

        </div>

    </section>

</main>

</body>
</html>
