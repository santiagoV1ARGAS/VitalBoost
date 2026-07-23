<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - VitalBoost</title>

    <link rel="stylesheet" href="${ctx}/css/login.css">
</head>

<body>

<main class="main-container">

    <section class="left-panel">
        <div class="overlay"></div>

        <div class="left-content">
            <h1>VitalBoost</h1>
            <p>una historia que te puede salvar la vida</p>
        </div>
    </section>

    <section class="right-panel">

        <div class="login-card">

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
                        <option value="1">Administrador</option>
                        <option value="2">Paciente</option>
                    </select>

                    <c:if test="${not empty errorRol}">
                        <small class="msg error">${errorRol}</small>
                    </c:if>
                </div>

                <button type="submit" name="accion" value="Ingresar">
                    Iniciar Sesión
                </button>

            </form>

            <div style="text-align: center; margin: 15px 0; color: #aaa; font-size: 0.9rem;">ó</div>

            <div class="form-group">
                <a href="${ctx}/ServletLogin?accion=AccesoMedico" 
                   style="display: block; text-align: center; background-color: #dc3545; color: white; padding: 12px; border-radius: 6px; text-decoration: none; font-weight: bold; transition: background 0.3s;"
                   onmouseover="this.style.backgroundColor='#c82333'" 
                   onmouseout="this.style.backgroundColor='#dc3545'">
                   🚨 Acceso Médico Urgente
                </a>
            </div>

            <div class="footer-link" style="margin-top: 20px;">
                <p>¿No tienes cuenta?</p>
                <a href="${ctx}/ServletRegistro">Regístrate aquí</a>
            </div>

        </div>

    </section>

</main>

</body>
</html>