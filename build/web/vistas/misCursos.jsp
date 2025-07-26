<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    if (session.getAttribute("rol") == null || !"docente".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
    }

    String docenteActual = (String) session.getAttribute("nombre");

    String filtroGrado = request.getParameter("grado");
    String filtroCurso = request.getParameter("curso");
    String filtroNivel = request.getParameter("nivel");

    Connection con = dao.Conexion.conectar();

    String query = "SELECT c.id_contenido, c.titulo, c.descripcion, c.link, c.grado, c.nivel, c.curso_id, c.docente, cu.nombre AS nombreCurso " +
                   "FROM contenidos c JOIN cursos cu ON c.curso_id = cu.id_curso WHERE c.link IS NOT NULL ";

    if (filtroGrado != null && !filtroGrado.isEmpty()) {
        query += "AND c.grado = ? ";
    }
    if (filtroCurso != null && !filtroCurso.isEmpty()) {
        query += "AND cu.id_curso = ? ";
    }
    if (filtroNivel != null && !filtroNivel.isEmpty()) {
        query += "AND c.nivel = ? ";
    }

    query += "ORDER BY c.grado, c.curso_id, c.fecha_publicacion DESC";

    PreparedStatement ps = con.prepareStatement(query);

    int index = 1;
    if (filtroGrado != null && !filtroGrado.isEmpty()) {
        ps.setString(index++, filtroGrado);
    }
    if (filtroCurso != null && !filtroCurso.isEmpty()) {
        ps.setInt(index++, Integer.parseInt(filtroCurso));
    }
    if (filtroNivel != null && !filtroNivel.isEmpty()) {
        ps.setString(index++, filtroNivel);
    }

    ResultSet rs = ps.executeQuery();

    PreparedStatement psCursos = con.prepareStatement("SELECT id_curso, nombre FROM cursos ORDER BY nombre");
    ResultSet cursos = psCursos.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Mis Cursos</title>
    <link rel="stylesheet" href="css/docente.css">
    <style>
        .video-card {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 10px;
            margin: 10px;
            width: 300px;
            background: #f9f9f9;
            display: inline-block;
            vertical-align: top;
        }

        .video-card iframe {
            width: 100%;
            height: 170px;
        }

        .filtros {
            margin: 20px;
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .filtros form {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }

        .video-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .video-card button {
            margin-top: 10px;
            padding: 5px 10px;
        }

        select {
            padding: 5px;
            border-radius: 5px;
        }

        button {
            padding: 7px 12px;
        }
    </style>
</head>
<body>
<header>🎓 Mis Cursos</header>

<div class="container">
    <div class="filtros">
        <form method="get">
            <label>Nivel:</label>
            <select name="nivel">
                <option value="">Todos</option>
                <option value="Primaria" <%= "Primaria".equals(filtroNivel) ? "selected" : "" %>>Primaria</option>
                <option value="Secundaria" <%= "Secundaria".equals(filtroNivel) ? "selected" : "" %>>Secundaria</option>
            </select>

            <label>Grado:</label>
            <select name="grado">
                <option value="">Todos</option>
                <%
                    for (int i = 1; i <= 6; i++) {
                        String selected = (filtroGrado != null && filtroGrado.equals(String.valueOf(i))) ? "selected" : "";
                %>
                <option value="<%= i %>" <%= selected %>><%= i %>°</option>
                <% } %>
            </select>


            <label>Curso:</label>
            <select name="curso">
                <option value="">Todos</option>
                <%
                    while (cursos.next()) {
                        int idCurso = cursos.getInt("id_curso");
                        String nombreCurso = cursos.getString("nombre");
                        String selected = (filtroCurso != null && filtroCurso.equals(String.valueOf(idCurso))) ? "selected" : "";
                %>
                <option value="<%= idCurso %>" <%= selected %>><%= nombreCurso %></option>
                <% } %>
            </select>

            <button type="submit">🔍 Filtrar</button>
            <a href="misCursos.jsp"><button type="button">🔄 Limpiar</button></a>
        </form>
    </div>

    <div class="video-container">
    <%
        while (rs.next()) {
            String titulo = rs.getString("titulo");
            String descripcion = rs.getString("descripcion");
            String link = rs.getString("link");
            int idContenido = rs.getInt("id_contenido");
            String docente = rs.getString("docente");
            String nombreCurso = rs.getString("nombreCurso");
    %>
        <div class="video-card">
            <h4><%= titulo %></h4>
            <p><%= descripcion %></p>
            <iframe src="<%= link.replace("watch?v=", "embed/") %>" frameborder="0" allowfullscreen></iframe>
            <p><strong>Curso:</strong> <%= nombreCurso %></p>
            <p><strong>Grado:</strong> <%= rs.getString("grado") %></p>
            <p><strong>Nivel:</strong> <%= rs.getString("nivel") %></p>
            
            <% if (docente != null && docente.equals(docenteActual)) { %>
                <form action="../EditarContenidoServlet" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="<%= idContenido %>">
                    <button>✏️ Editar</button>
                </form>


                <form action="../EliminarContenidoServlet" method="post" style="display:inline;" onsubmit="return confirm('¿Seguro que deseas eliminar este contenido?');">
                    <input type="hidden" name="id" value="<%= idContenido %>">
                    <button>🗑️ Eliminar</button>
                </form>
            <% } %>
        </div>
    <% } %>
    </div>

<%
    rs.close();
    ps.close();
    cursos.close();
    psCursos.close();
    con.close();
%>
</div>
<center><a href="panelDocente.jsp">⬅️ Volver al panel</a></center>>
<footer>
    Plataforma Educativa - IEP San Vicente de Motupe © 2025
</footer>
</body>
</html>
