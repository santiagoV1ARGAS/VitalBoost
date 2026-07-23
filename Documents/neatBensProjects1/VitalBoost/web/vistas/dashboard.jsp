<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<c:if test="${empty usuarioLogueado}">
    <c:redirect url="/vistas/login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>VitalBoost - Dashboard</title>

    <link rel="stylesheet" href="${ctx}/css/dashboard.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap"
          rel="stylesheet">
</head>

<body>

<header>

    <h1>VITALBOOST</h1>

    <div class="user-info">

        <span>
            Bienvenido,
            <strong>${usuarioLogueado.nombre_completo}</strong>
        </span>

        <nav>
            <a href="${ctx}/ServletCerrarSesion" class="btn-salir">
                Cerrar Sesión
            </a>
        </nav>

    </div>

</header>

<main>

    <!-- HERO -->
    <section class="hero">

        <h2>Cuidamos de ti hoy</h2>

        <p>
            Accede a tus servicios de salud de forma rápida y segura.
        </p>

    </section>

    <!-- GRID -->
    <section class="grid-container">

        <!-- SIGNOS VITALES -->
        <div class="card">
            <h3>Signos Vitales</h3>
            <p>Consulta tu historial de presión y ritmo cardíaco.</p>

            <a href="${ctx}/vistas/paciente/signos_vitales.jsp">
                REVISAR
            </a>
        </div>

        <!-- MEDICAMENTOS -->
        <div class="card">
            <h3>Medicamentos</h3>
            <p>Gestiona tus dosis diarias y recordatorios.</p>

            <a href="${ctx}/vistas/paciente/medicamentos.jsp">
                VER LISTA
            </a>
        </div>

        <!-- TRIAJE -->
        <div class="card">
            <h3>Ayuda Online</h3>
            <p>Realiza un triaje rápido si te sientes mal.</p>

            <a href="${ctx}/vistas/paciente/triaje.jsp">
                AYUDA AHORA
            </a>
        </div>

    </section>

</main>

<footer>

    <p>"Tu salud es nuestra prioridad número uno"</p>

</footer>

</body>

</html>