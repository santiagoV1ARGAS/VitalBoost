<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Términos y Condiciones - VitalBoost</title>
    <link rel="stylesheet" href="${ctx}/css/global.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f4f7fb;
            color: #1e293b;
            padding: 3rem 1.5rem;
        }
        .terminos-container {
            max-width: 760px;
            margin: 0 auto;
            background: #fff;
            padding: 2.5rem;
            border-radius: 20px;
            box-shadow: 0 10px 35px rgba(0,0,0,0.08);
        }
        .terminos-container h1 {
            margin-bottom: 0.5rem;
        }
        .terminos-container .fecha {
            color: #64748b;
            font-size: 0.9rem;
            margin-bottom: 2rem;
        }
        .terminos-container h2 {
            font-size: 1.1rem;
            margin-top: 1.8rem;
            margin-bottom: 0.6rem;
            color: #2563eb;
        }
        .terminos-container p {
            line-height: 1.7;
            color: #334155;
        }
        .terminos-container a.volver {
            display: inline-block;
            margin-top: 2.5rem;
            color: #2563eb;
            font-weight: 600;
            text-decoration: none;
        }
        .terminos-container a.volver:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<%@ include file="/includes/loader.jspf" %>

    <div class="terminos-container">

        <h1>Términos y Condiciones de Uso</h1>
        <p class="fecha">Última actualización: 2026</p>

        <p>
            Al registrarte o iniciar sesión en VitalBoost aceptas los siguientes
            términos, los cuales rigen el uso de la plataforma y el tratamiento
            de tu información médica.
        </p>

        <h2>1. Naturaleza del servicio</h2>
        <p>
            VitalBoost es una plataforma que centraliza información médica básica
            (tipo de sangre, alergias y datos de contacto de emergencia) para
            facilitar la atención en situaciones críticas. No reemplaza el
            criterio ni el diagnóstico de un profesional de la salud.
        </p>

        <h2>2. Tratamiento de datos personales</h2>
        <p>
            Tus datos médicos son sensibles y se almacenan de forma segura. Solo
            se muestran a personal médico autorizado o a través de tu código QR
            de emergencia, con el fin exclusivo de brindarte atención oportuna.
        </p>

        <h2>3. Responsabilidad del usuario</h2>
        <p>
            Eres responsable de mantener actualizada tu información médica.
            VitalBoost no se hace responsable por decisiones clínicas tomadas
            a partir de datos desactualizados o incompletos.
        </p>

        <h2>4. Acceso de emergencia</h2>
        <p>
            La información básica de tu hoja de vida médica puede ser consultada
            sin necesidad de contraseña mediante tu código QR, pensado para
            situaciones donde no puedas comunicarte por ti mismo.
        </p>

        <h2>5. Aceptación</h2>
        <p>
            El uso continuo de la plataforma implica la aceptación de estos
            términos y de las actualizaciones que se realicen sobre ellos.
        </p>

        <a class="volver" href="javascript:window.close();">Cerrar</a>

    </div>

</body>
</html>
