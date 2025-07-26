<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("rol") == null || !"docente".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Crear Curso</title>
    <link rel="stylesheet" href="css/docente.css">
    <style>
        .formulario-curso {
            max-width: 500px;
            margin: auto;
            padding: 20px;
            background: #f4f4f4;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
        }

        .formulario-curso label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .formulario-curso input,
        .formulario-curso textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .formulario-curso button {
            background: #2c7;
            border: none;
            padding: 10px 20px;
            color: white;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
        }

        .formulario-curso a {
            margin-left: 10px;
            color: #555;
            text-decoration: none;
        }

        .formulario-curso a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <header>🆕 Crear Curso</header>

    <div class="container">
        <form action="../CrearCursoServlet" method="post" class="formulario-curso">
            <label for="nombre">Nombre del Curso:</label>
            <input type="text" id="nombre" name="nombre" required>

            <label for="descripcion">Descripción:</label>
            <textarea id="descripcion" name="descripcion" rows="4" required></textarea>

            <label for="fecha_inicio">Fecha de Inicio:</label>
            <input type="date" id="fecha_inicio" name="fecha_inicio" required>

            <button type="submit">💾 Guardar Curso</button>
            <a href="panelDocente.jsp">⬅️ Cancelar</a>
        </form>
    </div>

    <footer>Plataforma Educativa © 2025</footer>
</body>
</html>
