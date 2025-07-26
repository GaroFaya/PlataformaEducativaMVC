<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("rol") == null || !"docente".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String titulo = (String) request.getAttribute("titulo");
    String descripcion = (String) request.getAttribute("descripcion");
    String link = (String) request.getAttribute("link");
    String grado = (String) request.getAttribute("grado");
    String nivel = (String) request.getAttribute("nivel");
    int id = (int) request.getAttribute("id");

    int cursoId = 0;
    Object cursoIdObj = request.getAttribute("curso_id");
    if (cursoIdObj != null) {
        cursoId = Integer.parseInt(cursoIdObj.toString());
    }

    ResultSet cursos = (ResultSet) request.getAttribute("cursosRs");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Contenido</title>
    <link rel="stylesheet" href="css/docente.css">
    <style>
        .formulario-contenido {
            max-width: 500px;
            margin: auto;
            display: flex;
            flex-direction: column;
        }
        .formulario-contenido label {
            margin-top: 10px;
            font-weight: bold;
        }
        .formulario-contenido input,
        .formulario-contenido textarea,
        .formulario-contenido select {
            padding: 8px;
            font-size: 16px;
            margin-top: 5px;
        }
        .formulario-contenido button {
            margin-top: 15px;
            padding: 10px;
            font-size: 16px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
        }
        .formulario-contenido a {
            margin-top: 10px;
            text-align: center;
            display: block;
            text-decoration: none;
            color: #555;
        }
    </style>
</head>
<body>
    <header>✏️ Editar Video</header>

    <div class="container">
        <form action="./EditarContenidoServlet" method="post" class="formulario-contenido">
            <input type="hidden" name="id_contenido" value="<%= id %>">

            <label>Título:</label>
            <input type="text" name="titulo" value="<%= titulo %>" required>

            <label>Descripción:</label>
            <textarea name="descripcion" rows="4" required><%= descripcion %></textarea>

            <label>Enlace del Video:</label>
            <input type="url" name="link" value="<%= link %>" required>

            <label>Curso:</label>
            <select name="curso_id" required>
                <% while (cursos.next()) {
                    int idCurso = cursos.getInt("id_curso");
                    String nombreCurso = cursos.getString("nombre");
                    String selected = (idCurso == cursoId) ? "selected" : "";
                %>
                    <option value="<%= idCurso %>" <%= selected %>><%= nombreCurso %></option>
                <% } %>
            </select>

            <label>Grado:</label>
            <select name="grado" required>
                <option <%= grado.equals("1°") ? "selected" : "" %>>1°</option>
                <option <%= grado.equals("2°") ? "selected" : "" %>>2°</option>
                <option <%= grado.equals("3°") ? "selected" : "" %>>3°</option>
                <option <%= grado.equals("4°") ? "selected" : "" %>>4°</option>
                <option <%= grado.equals("5°") ? "selected" : "" %>>5°</option>
                <option <%= grado.equals("6°") ? "selected" : "" %>>6°</option>
            </select>

            <label>Nivel:</label>
            <select name="nivel" required>
                <option <%= nivel.equals("Primaria") ? "selected" : "" %>>Primaria</option>
                <option <%= nivel.equals("Secundaria") ? "selected" : "" %>>Secundaria</option>
            </select>

            <button type="submit">💾 Guardar Cambios</button>
            <a href="vistas/misCursos.jsp">⬅️ Cancelar</a>
        </form>
    </div>

    <footer>Plataforma Educativa © 2025</footer>
</body>
</html>
