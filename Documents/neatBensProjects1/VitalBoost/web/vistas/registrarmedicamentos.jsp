<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicamentos</title>

    <link rel="stylesheet" href="${ctx}/css/registrarmedicamento.css">
</head>

<body>

<div class="contenedor-admin">

    <!-- SIDEBAR -->
    <aside class="sidebar">

        <div class="logo">VitalBoost</div>

        <nav class="menu">
            <a href="${ctx}/Servletlistarusuario?accion=listar">Dashboard</a>
            <a href="${ctx}/vistas/configuracion.jsp" class="activo">Configuración Sistema</a>
        </nav>

    </aside>

    <main class="contenido">

        <!-- FORMULARIO -->
        <div class="contenedor-formulario">

            <div class="card-formulario">

                <h1>
                    ${medEditar != null ? 'Editar Medicamento' : 'Registrar Medicamento'}
                </h1>

                <form action="${ctx}/Servletregistrarmedicamentos" method="POST">

                    <c:if test="${medEditar != null}">
                        <input type="hidden" name="idMedicamento" value="${medEditar.id_medicamento}">
                    </c:if>

                    <input type="hidden" name="accion"
                           value="${medEditar != null ? 'actualizar' : 'guardar'}">

                    <div class="grupo-formulario">
                        <label>Nombre Común</label>
                        <input type="text" name="txtNombreComun"
                               value="${medEditar.nombre_comun}" required>
                    </div>

                    <div class="grupo-formulario">
                        <label>Uso Para</label>
                        <input type="text" name="txtUsoPara"
                               value="${medEditar.uso_para}" required>
                    </div>

                    <div class="grupo-formulario">
                        <label>Indicaciones</label>
                        <input type="text" name="txtIndicaciones"
                               value="${medEditar.indicaciones}" required>
                    </div>

                    <div class="grupo-formulario">
                        <label>Contraindicaciones</label>
                        <input type="text" name="txtContraindicaciones"
                               value="${medEditar.contraindicaciones}">
                    </div>

                    <div class="grupo-formulario">
                        <label>Advertencia Crítica</label>
                        <input type="text" name="txtAdvertencia"
                               value="${medEditar.advertencia_critica}">
                    </div>

                    <button type="submit" class="btn-guardar">
                        ${medEditar != null ? 'Actualizar' : 'Registrar'}
                    </button>

                </form>

            </div>
        </div>

        <!-- TABLA -->
        <div class="tabla-roles">

            <h2>Medicamentos Registrados</h2>

            <table>

                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Uso</th>
                        <th>Indicaciones</th>
                        <th>Acción</th>
                    </tr>
                </thead>

                <tbody>

                    <c:forEach var="m" items="${listaMedicamentos}">

                        <tr>
                            <td>${m.id_medicamento}</td>
                            <td>${m.nombre_comun}</td>
                            <td>${m.uso_para}</td>
                            <td>${m.indicaciones}</td>

                            <td>
                                <a class="btn-editar"
                                   href="${ctx}/Servletregistrarmedicamentos?accion=editar&id=${m.id_medicamento}">
                                    Editar
                                </a>

                                <a class="btn-eliminar"
                                   href="javascript:void(0);"
                                   onclick="confirmarEliminar('${ctx}/Servletregistrarmedicamentos?accion=eliminar&id=${m.id_medicamento}')">
                                    Eliminar
                                </a>
                            </td>
                        </tr>

                    </c:forEach>

                </tbody>

            </table>

        </div>

    </main>

</div>

<script>
    function confirmarEliminar(url) {
        if (confirm("¿Estás seguro de que deseas eliminar este medicamento?")) {
            window.location.href = url;
        }
    }
</script>

</body>
</html>