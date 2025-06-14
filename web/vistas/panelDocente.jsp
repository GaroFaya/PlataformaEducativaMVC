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

            <a href="#">⬆️ Subir Videos</a>
            <a href="#">📈 Ver Reportes</a>
            <a href="#">📚 Mis Cursos</a>
            <a href="../CerrarSesionServlet">🚪 Cerrar Sesión</a>
        </div>
    </div>

    <footer>
        Plataforma Educativa - IEP San Vicente de Motupe © 2025
    </footer>
</body>
</html>
