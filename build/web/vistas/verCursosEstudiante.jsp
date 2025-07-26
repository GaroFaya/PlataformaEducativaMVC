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
        "SELECT cu.id_curso, cu.nombre AS nombre_curso, c.docente, c.grado, c.nivel " +
        "FROM cursos cu " +
        "JOIN contenidos c ON cu.id_curso = c.curso_id " +
        "WHERE c.nivel = ? AND c.grado = ? " +
        "GROUP BY cu.id_curso, cu.nombre, c.docente, c.grado, c.nivel"
    );
    ps.setString(1, nivel);
    ps.setString(2, grado);

    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <title>📚 Cursos Disponibles</title>
    <link rel="stylesheet" href="css/estudiante.css">
</head>
<body>
    <header>📚 Cursos para <%= grado %> de <%= nivel %></header>
    <div class="container">
        <%
            boolean hayCursos = false;
            while (rs.next()) {
                hayCursos = true;
        %>
            <div class="curso-card">
                <h3>📘 <%= rs.getString("nombre_curso") %></h3>
                <p><strong>Docente:</strong> <%= rs.getString("docente") %></p>
                <p><strong>Grado:</strong> <%= rs.getString("grado") %></p>
                <p><strong>Nivel:</strong> <%= rs.getString("nivel") %></p>
            </div>
        <%
            }
            if (!hayCursos) {
        %>
            <p>No hay cursos disponibles para tu grado y nivel actualmente.</p>
        <%
            }
            rs.close();
            ps.close();
            con.close();
        %>
    </div>
    <center><a href="panelEstudiante.jsp">⬅️ Volver al Panel</a></center>
    <footer>Plataforma Educativa © 2025</footer>
</body>
</html>
