
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>VitalBoost</title>

    <link rel="stylesheet" href="${ctx}/css/index.css">

</head>

<body>

    <header class="navbar">

        <div class="logo">
            <h1>VitalBoost</h1>
        </div>

        <nav>
            <a href="#inicio">Inicio</a>
            <a href="#beneficios">Beneficios</a>
            <a href="#seguridad">Seguridad</a>
            <a href="#contacto">Contacto</a>
        </nav>

        <div class="acciones">

            <a href="${ctx}/vistas/login.jsp" class="btn-login">
                Iniciar Sesión
            </a>

        </div>

    </header>


    <section class="hero" id="inicio">

        <div class="hero-texto">

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

                <a href="${ctx}/vistas/login.jsp" class="btn-principal">
                    Ingresar Ahora
                </a>

                <!-- ========================= -->
                <!-- CAMBIO CORRECTO MVC -->
                <!-- ========================= -->

                <a href="${ctx}/ServletRegistro" class="btn-secundario">
                    Crear Cuenta
                </a>

            </div>

        </div>


        <div class="hero-card">

            <div class="card">

                <h3>Acceso Rápido</h3>

                <p>
                    Consulta datos médicos esenciales en segundos.
                </p>

            </div>

            <div class="card">

                <h3>Seguridad</h3>

                <p>
                    Información protegida y disponible cuando más la necesitas.
                </p>

            </div>

            <div class="card">

                <h3>Disponibilidad</h3>

                <p>
                    Compatible con cualquier dispositivo.
                </p>

            </div>

        </div>

    </section>


    <section class="beneficios" id="beneficios">

        <h2>¿Por qué usar VitalBoost?</h2>

        <div class="contenedor-beneficios">

            <div class="beneficio">

                <h3>Historial Médico</h3>

                <p>
                    Centraliza toda tu información médica en un solo lugar.
                </p>

            </div>

            <div class="beneficio">

                <h3>Emergencias</h3>

                <p>
                    Facilita la atención médica en situaciones críticas.
                </p>

            </div>

            <div class="beneficio">

                <h3>Gestión Fácil</h3>

                <p>
                    Actualiza y consulta tus datos fácilmente.
                </p>

            </div>

        </div>

    </section>


    <section class="seguridad" id="seguridad">

        <div class="seguridad-info">

            <h2>Protección y confianza</h2>

            <p>
                Nuestro sistema está diseñado para proteger la privacidad
                de tus datos médicos y brindar acceso rápido únicamente
                a usuarios autorizados.
            </p>

        </div>

    </section>


    <footer id="contacto">

        <p>
            © 2026 VitalBoost - Sistema de Historial Médico
        </p>

    </footer>

</body>
</html>