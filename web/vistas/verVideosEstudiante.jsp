<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("rol") == null || !"estudiante".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String nivel = (String) session.getAttribute("nivel");
    String grado = (String) session.getAttribute("grado");

    Connection con = dao.Conexion.conectar();
    PreparedStatement ps = con.prepareStatement(
        "SELECT c.titulo, c.descripcion, c.link, cu.nombre AS nombreCurso " +
        "FROM contenidos c JOIN cursos cu ON c.curso_id = cu.id_curso " +
        "WHERE c.nivel = ? AND c.grado = ? AND c.link IS NOT NULL"
    );
    ps.setString(1, nivel);
    ps.setString(2, grado);

    ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Mis Videos</title>
    <link rel="stylesheet" href="css/estudiante.css">
    <style>
        .video-card {
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 15px;
            margin: 20px auto;
            width: 80%;
            max-width: 600px;
            background: #f9f9f9;
        }
        .video-card iframe {
            width: 100%;
            height: 315px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<header>🎥 Videos del Curso</header>

<div class="container">
<%
    boolean hayVideos = false;
    while (rs.next()) {
        hayVideos = true;
        String link = rs.getString("link");
        if (link != null && !link.trim().isEmpty()) {
%>
    <div class="video-card">
        <h4><%= rs.getString("titulo") %></h4>
        <p><%= rs.getString("descripcion") %></p>
        <iframe src="<%= link.replace("watch?v=", "embed/") %>" frameborder="0" allowfullscreen></iframe>
        <p><strong>Curso:</strong> <%= rs.getString("nombreCurso") %></p>
    </div>
<%
        }
    }

    if (!hayVideos) {
%>
    <p style="text-align: center;">⚠️ No hay videos disponibles aún para tu grado y nivel.</p>
<%
    }

    rs.close();
    ps.close();
    con.close();
%>
    <div style="text-align: center; margin-top: 20px;">
        <a href="panelEstudiante.jsp">⬅️ Volver</a>
    </div>
</div>

</body>
</html>
