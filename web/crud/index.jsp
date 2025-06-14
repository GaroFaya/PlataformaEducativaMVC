<%@ page contentType="text/html; charset=UTF-8" %>

<%@ page session="true" %>
<%
    if (session.getAttribute("rol") == null || !"admin".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    
    <title>Panel de Administración</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
    <header>
        Panel del Administrador
    </header>

    <div class="container">
        <div class="panel">
            <h2>Gestión</h2>
            <a href="usuarios.jsp">👤 Usuarios</a>
            <a href="#">📚 Cursos</a>
            <a href="#">🎓 Roles</a>
            <a href="../CerrarSesionServlet">🚪 Cerrar Sesión</a>
        </div>
    </div>

    <footer>
        Plataforma Educativa - IEP San Vicente de Motupe © 2025
    </footer>
</body>
</html>
