<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("rol") == null || !"estudiante".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int idEstudiante = (int) session.getAttribute("id_usuario");

    Connection con = dao.Conexion.conectar();

    // Consulta modificada para unir las tablas y obtener información relevante
    String query = "SELECT p.id_progreso, p.porcentaje, p.ultima_vista, " +
                   "v.titulo AS video_titulo, c.nombre AS curso_nombre " +
                   "FROM progreso p " +
                   "JOIN videos v ON p.id_video = v.id_video " +
                   "JOIN cursos c ON v.id_curso = c.id_curso " +
                   "WHERE p.id_estudiante = ? " +
                   "ORDER BY p.ultima_vista DESC";
    
    PreparedStatement ps = con.prepareStatement(query);
    ps.setInt(1, idEstudiante);

    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Mi Progreso</title>
    <link rel="stylesheet" href="css/estudiante.css">
    <style>
        .progress-bar {
            width: 100%;
            background-color: #f1f1f1;
            border-radius: 5px;
            margin: 5px 0;
        }
        .progress {
            height: 20px;
            border-radius: 5px;
            background-color: #4CAF50;
            text-align: center;
            line-height: 20px;
            color: white;
        }
    </style>
</head>
<body>
<header>📊 Mi Progreso</header>
<div class="container">
    <% if (!rs.isBeforeFirst()) { %>
        <p>No hay registros de progreso todavía.</p>
    <% } else { %>
        <table border="1">
            <tr>
                <th>Curso</th>
                <th>Video</th>
                <th>Progreso</th>
                <th>Última Visualización</th>
            </tr>
            <% while (rs.next()) { %>
            <tr>
                <td><%= rs.getString("curso_nombre") %></td>
                <td><%= rs.getString("video_titulo") %></td>
                <td>
                    <div class="progress-bar">
                        <div class="progress" style="width: <%= rs.getFloat("porcentaje") %>%">
                            <%= rs.getFloat("porcentaje") %>%
                        </div>
                    </div>
                </td>
                <td><%= rs.getDate("ultima_vista") %></td>
            </tr>
            <% } %>
        </table>
    <% } %>
    <a href="panelEstudiante.jsp">⬅️ Volver</a>
</div>
</body>
</html>
<%
    rs.close();
    ps.close();
    con.close();
%>