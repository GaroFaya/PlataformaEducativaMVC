<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("rol") == null || !"docente".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    Connection con = dao.Conexion.conectar();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM cursos WHERE id_curso = ?");
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();

    String nombre = "", descripcion = "", fecha_inicio = "";
    if (rs.next()) {
        nombre = rs.getString("nombre");
        descripcion = rs.getString("descripcion");
        fecha_inicio = rs.getString("fecha_inicio");
    }
    rs.close();
    ps.close();
    con.close();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Curso</title>
    <link rel="stylesheet" href="css/docente.css">
    <style>
        .formulario-curso {
            max-width: 600px;
            margin: auto;
            display: flex;
            flex-direction: column;
            gap: 15px;
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .formulario-curso label {
            font-weight: bold;
            color: #2c3e50;
        }

        .formulario-curso input,
        .formulario-curso textarea {
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
            width: 100%;
        }

        .formulario-curso button {
            padding: 12px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .formulario-curso button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>

<header>✏️ Editar Curso</header>

<div class="container">
    <form action="../EditarCursoServlet" method="post" class="formulario-curso">
        <input type="hidden" name="id" value="<%= id %>">

        <label>Nombre del curso:</label>
        <input type="text" name="nombre" value="<%= nombre %>" required>

        <label>Descripción:</label>
        <textarea name="descripcion" rows="4" required><%= descripcion %></textarea>

        <label>Fecha de inicio:</label>
        <input type="date" name="fecha_inicio" value="<%= fecha_inicio %>" required>

        <button type="submit">💾 Guardar Cambios</button>
        <a href="misCursos.jsp">⬅️ Cancelar</a>
    </form>
</div>

<footer>
    Plataforma Educativa - IEP San Vicente de Motupe © 2025
</footer>

</body>
</html>
