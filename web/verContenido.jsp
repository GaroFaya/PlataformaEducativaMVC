<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="modelo.Contenido" %>
<%@ page import="dao.ContenidoDAO" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>

<%
    if (session.getAttribute("rol") == null || !"estudiante".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String grado = (String) session.getAttribute("grado");
    String nivel = (String) session.getAttribute("nivel");

    List<Contenido> lista = ContenidoDAO.obtenerPorGradoNivel(grado, nivel);
%>

<html>
<head>
    <title>Contenido Disponible</title>
    <link rel="stylesheet" href="css/estudiante.css">
</head>
<body>
    <h2>📚 Contenido Educativo</h2>

    <%
        if (lista.isEmpty()) {
    %>
        <p>No hay contenido disponible para tu grado y nivel.</p>
    <%
        } else {
            for (Contenido c : lista) {
    %>
        <div class="contenido-card">
            <h3><%= c.getTitulo() %></h3>
            <p><strong>Curso:</strong> <%= c.getNombreCurso() %></p>
            <p><%= c.getDescripcion() %></p>
            <p><strong>Publicado:</strong> <%= c.getFecha_publicacion() %></p>

            <% if (c.getLink() != null && !c.getLink().isEmpty()) { %>
                <p><a href="<%= c.getLink() %>" target="_blank">🔗 Ver Enlace</a></p>
            <% } %>

            <% if (c.getArchivo() != null && !c.getArchivo().isEmpty()) { %>
                <p><a href="archivos/<%= c.getArchivo() %>" target="_blank">📄 Ver archivo</a></p>
            <% } %>
        </div>
    <%
            }
        }
    %>
</body>
</html>
