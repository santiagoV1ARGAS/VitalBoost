
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>VitalBoost</title>

    <link rel="stylesheet" href="${ctx}/css/index.css">
    <link rel="stylesheet" href="${ctx}/css/global.css">

</head>

<body>

<%@ include file="/includes/loader.jspf" %>

    <div class="scroll-progress"></div>

    <header class="navbar">

        <div class="logo">
            <div class="logo-icono">
                <svg viewBox="0 0 24 24" fill="none" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M20.8 6.6c-1.8-3.4-6.2-4.2-8.8-1.6l-.9.9-.9-.9C7.6 2.4 3.2 3.2 1.4 6.6c-1.5 2.9-.7 6.4 1.9 9l7.7 7.6 7.7-7.6c2.6-2.6 3.4-6.1 1.9-9z"/><path d="M6 12h3l1.5-3 2 6 1.5-3H18"/></svg>
            </div>
            <h1>Vital<span>Boost</span></h1>
        </div>

        <nav>
            <a href="#inicio">Inicio</a>
            <a href="#paciente">Paciente</a>
            <a href="#beneficios">Beneficios</a>
            <a href="#seguridad">Seguridad</a>
            <a href="#contacto">Contacto</a>
        </nav>

        <div class="acciones">

            <a href="${ctx}/ServletLogin" class="btn-login">
                Iniciar Sesión
            </a>

            <a href="${ctx}/ServletRegistro" class="btn-login">
                Registrarse
            </a>

        </div>

    </header>


    <section class="hero" id="inicio">

        <div class="hero-texto">

            <div class="hero-badge">
                <span class="punto"></span>
                Disponible las 24 horas, todos los días
            </div>

            <h2>
                Tu historial médico
                <span>siempre disponible</span>
            </h2>

            <p>
                VitalBoost te permite acceder rápidamente a información médica
                importante en situaciones de emergencia de forma segura,
                moderna y confiable.
            </p>

            <div class="hero-botones">

                <a href="${ctx}/ServletRegistro" class="btn-principal">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><line x1="19" y1="8" x2="19" y2="14"/><line x1="16" y1="11" x2="22" y2="11"/></svg>
                    Registrarse
                </a>

                <a href="${ctx}/ServletLogin" class="btn-secundario">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"/><polyline points="10 17 15 12 10 7"/><line x1="15" y1="12" x2="3" y2="12"/></svg>
                    Iniciar Sesión
                </a>

            </div>

            <div class="hero-stats">
                <div>
                    <div class="stat-num" data-fin="100" data-sufijo="%">0%</div>
                    <div class="stat-label">Datos protegidos</div>
                </div>
                <div>
                    <div class="stat-num" data-fin="24" data-sufijo="/7">0/7</div>
                    <div class="stat-label">Acceso en emergencias</div>
                </div>
                <div>
                    <div class="stat-num" data-fin="2" data-sufijo=" min">0 min</div>
                    <div class="stat-label">Registro promedio</div>
                </div>
            </div>

        </div>


        <div class="hero-card">

            <div class="card">
                <div class="card-icono">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg>
                </div>
                <div>
                    <h3>Acceso Rápido</h3>
                    <p>
                        Consulta datos médicos esenciales en segundos.
                    </p>
                </div>
            </div>

            <div class="card">
                <div class="card-icono">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/><path d="M9 12l2 2 4-4"/></svg>
                </div>
                <div>
                    <h3>Seguridad</h3>
                    <p>
                        Información protegida y disponible cuando más la necesitas.
                    </p>
                </div>
            </div>

            <div class="card">
                <div class="card-icono">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="4" width="20" height="16" rx="2"/><path d="M2 9h20"/><path d="M8 4v2"/><path d="M16 4v2"/></svg>
                </div>
                <div>
                    <h3>Disponibilidad</h3>
                    <p>
                        Compatible con cualquier dispositivo.
                    </p>
                </div>
            </div>

        </div>

    </section>


    <section class="beneficios" id="paciente">

        <div class="seccion-encabezado reveal">
            <span class="seccion-tag">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"><path d="M20.8 6.6c-1.8-3.4-6.2-4.2-8.8-1.6l-.9.9-.9-.9C7.6 2.4 3.2 3.2 1.4 6.6c-1.5 2.9-.7 6.4 1.9 9l7.7 7.6 7.7-7.6c2.6-2.6 3.4-6.1 1.9-9z"/></svg>
                Para pacientes
            </span>
            <h2>¿Eres paciente?</h2>
            <p>En tres pasos simples tu información médica queda lista para cualquier emergencia.</p>
        </div>

        <div class="contenedor-beneficios">

            <div class="beneficio">
                <div class="beneficio-numero">1</div>
                <h3>Regístrate</h3>
                <p>
                    Crea tu perfil con tus datos, tipo de sangre y alergias.
                    Solo te toma un par de minutos.
                </p>
            </div>

            <div class="beneficio">
                <div class="beneficio-numero">2</div>
                <h3>Recibe tu código QR</h3>
                <p>
                    Al terminar tu registro generamos tu código QR de
                    emergencia. Guárdalo en tu billetera o celular.
                </p>
            </div>

            <div class="beneficio">
                <div class="beneficio-numero">3</div>
                <h3>Listo para emergencias</h3>
                <p>
                    No necesitas iniciar sesión: cualquier persona puede
                    escanear tu QR y ver tu hoja de vida médica al instante.
                </p>
            </div>

        </div>

    </section>


    <section class="beneficios" id="beneficios" style="background:var(--ib-azul-50)">

        <div class="seccion-encabezado reveal">
            <span class="seccion-tag">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"><polygon points="12 2 15 9 22 9.5 17 14.5 18.5 22 12 18 5.5 22 7 14.5 2 9.5 9 9 12 2"/></svg>
                Ventajas
            </span>
            <h2>¿Por qué usar VitalBoost?</h2>
            <p>Todo lo que necesitas para gestionar tu salud en un solo lugar.</p>
        </div>

        <div class="contenedor-beneficios">

            <div class="beneficio">
                <div class="beneficio-icono">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16v12H7l-3 3V4z"/><path d="M8 9h8M8 13h5"/></svg>
                </div>
                <h3>Historial Médico</h3>
                <p>
                    Centraliza toda tu información médica en un solo lugar.
                </p>
            </div>

            <div class="beneficio">
                <div class="beneficio-icono">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 21s-7.5-4.6-10-9.3C.4 8.1 2.3 4.5 6 4c2.1-.3 4 .8 6 3 2-2.2 3.9-3.3 6-3 3.7.5 5.6 4.1 4 7.7C19.5 16.4 12 21 12 21z"/><path d="M8 12h2l1.5-2.5L13 15l1.2-3H16"/></svg>
                </div>
                <h3>Emergencias</h3>
                <p>
                    Facilita la atención médica en situaciones críticas.
                </p>
            </div>

            <div class="beneficio">
                <div class="beneficio-icono">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 21H4a1 1 0 0 1-1-1V3"/><path d="M20 7l-5.5 5.5-3-3L4 17"/></svg>
                </div>
                <h3>Gestión Fácil</h3>
                <p>
                    Actualiza y consulta tus datos fácilmente.
                </p>
            </div>

        </div>

    </section>


    <section class="seguridad" id="seguridad">

        <div class="seguridad-info reveal">

            <div class="seguridad-icono">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/><path d="M9 12l2 2 4-4"/></svg>
            </div>

            <h2>Protección y confianza</h2>

            <p>
                Nuestro sistema está diseñado para proteger la privacidad
                de tus datos médicos y brindar acceso rápido únicamente
                a usuarios autorizados.
            </p>

        </div>

        <div class="seguridad-grid reveal">

            <div class="seguridad-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="11" width="18" height="10" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                <h4>Datos cifrados</h4>
                <p>Tu información se guarda de forma segura en todo momento.</p>
            </div>

            <div class="seguridad-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.9"/><path d="M16 3.1a4 4 0 0 1 0 7.8"/></svg>
                <h4>Acceso autorizado</h4>
                <p>Solo tú y quien necesite ayudarte en una emergencia acceden.</p>
            </div>

            <div class="seguridad-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                <h4>Disponible siempre</h4>
                <p>Consulta tu información médica en cualquier momento.</p>
            </div>

            <div class="seguridad-item">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="4" width="16" height="16" rx="2"/><path d="M9 9h.01M15 9h.01M9 15h6M4 4l4 4M20 4l-4 4M4 20l4-4M20 20l-4-4"/></svg>
                <h4>Código QR único</h4>
                <p>Cada paciente cuenta con un identificador exclusivo.</p>
            </div>

        </div>

    </section>


    <footer id="contacto">

        <div class="footer-contenido">

            <div class="footer-marca">
                <div class="logo-icono">
                    <svg viewBox="0 0 24 24" fill="none" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M20.8 6.6c-1.8-3.4-6.2-4.2-8.8-1.6l-.9.9-.9-.9C7.6 2.4 3.2 3.2 1.4 6.6c-1.5 2.9-.7 6.4 1.9 9l7.7 7.6 7.7-7.6c2.6-2.6 3.4-6.1 1.9-9z"/></svg>
                </div>
                VitalBoost
            </div>

            <div class="footer-social">
                <a href="#inicio" aria-label="Facebook">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"/></svg>
                </a>
                <a href="#inicio" aria-label="Instagram">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="2" width="20" height="20" rx="5"/><circle cx="12" cy="12" r="4"/><line x1="17.5" y1="6.5" x2="17.5" y2="6.5"/></svg>
                </a>
                <a href="#inicio" aria-label="Correo">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="4" width="20" height="16" rx="2"/><path d="M22 6l-10 7L2 6"/></svg>
                </a>
            </div>

        </div>

        <div class="linea">
            <p>
                © 2026 VitalBoost - Sistema de Historial Médico
            </p>
        </div>

    </footer>

    <button class="volver-arriba" aria-label="Volver arriba">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="19" x2="12" y2="5"/><polyline points="5 12 12 5 19 12"/></svg>
    </button>

    <script src="${ctx}/js/index.js"></script>

</body>
</html>
