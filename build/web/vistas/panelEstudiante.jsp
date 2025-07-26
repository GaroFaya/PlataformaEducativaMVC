<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("rol") == null || !"estudiante".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Panel del Estudiante</title>
    <link rel="stylesheet" href="css/estudiante.css">
</head>
<body>
    <header>
        Bienvenido al Panel del Estudiante
    </header>

    <div class="container">
        <div class="panel">
            <h2>Hola, <%= session.getAttribute("nombre") %> 👋</h2>
            <p>Accede a tus recursos disponibles:</p>

            <a href="verCursosEstudiante.jsp">📚 Ver Cursos</a>
            <a href="verVideosEstudiante.jsp">🎥 Ver Videos</a>
            <a href="verProgreso.jsp">📊 Ver Progreso</a>
            <a href="../CerrarSesionServlet">🚪 Cerrar Sesión</a>

        </div>
    </div>

    <footer>
        Plataforma Educativa - IEP San Vicente de Motupe © 2025
    </footer>S
</body>
</html>
