<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("rol") == null || !"docente".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Panel del Docente</title>
    <link rel="stylesheet" href="css/docente.css">
</head>
<body>
    <header>
        Panel del Docente
    </header>

    <div class="container">
        <div class="panel">
            <h2>Hola, <%= session.getAttribute("nombre") %> 👨‍🏫</h2>
            <p>Gestiona tu contenido educativo:</p>

            <!-- ✅ Botones de navegación -->
            <a href="crearCurso.jsp">🆕 Crear Curso</a>
            <a href="subirContenido.jsp">⬆️ Subir Video</a>
            <a href="verReportes.jsp">📈 Ver Reportes</a>
            <a href="misCursos.jsp">🎓 Mis Cursos</a>
            <a href="../CerrarSesionServlet">🚪 Cerrar Sesión</a>
        </div>
    </div>
    
    <div class="panel">
        <h3>📚 Cursos Creados:</h3>
        <%
            Connection conCursos = dao.Conexion.conectar();
            PreparedStatement psCursos = conCursos.prepareStatement("SELECT * FROM cursos ORDER BY fecha_inicio DESC");
            ResultSet rsCursos = psCursos.executeQuery();

            while (rsCursos.next()) {
                int idCurso = rsCursos.getInt("id_curso");
                String nombreCurso = rsCursos.getString("nombre");
                String descripcion = rsCursos.getString("descripcion");
                String fechaInicio = rsCursos.getString("fecha_inicio");
        %>
            <div style="border: 1px solid #ccc; padding: 10px; margin-bottom: 10px; background: #f9f9f9;">
                <strong><%= nombreCurso %></strong><br>
                <small><%= fechaInicio %></small>
                <p><%= descripcion %></p>

                <!-- Botón Editar -->
                <form action="editarCurso.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="<%= idCurso %>">
                    <button>✏️ Editar</button>
                </form>

                <!-- Botón Eliminar -->
                <form action="../EliminarCursoServlet" method="post" style="display:inline;" onsubmit="return confirm('¿Eliminar este curso?');">
                    <input type="hidden" name="id" value="<%= idCurso %>">
                    <button>🗑️ Eliminar</button>
                </form>
            </div>
        <%
            }
            rsCursos.close();
            psCursos.close();
            conCursos.close();
        %>
    </div>

    <footer>
        Plataforma Educativa - IEP San Vicente de Motupe © 2025
    </footer>
</body>
</html>
