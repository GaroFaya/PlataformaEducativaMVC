<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="modelo.Contenido" %>
<%@ page import="dao.ContenidoDAO" %>
<%@ page session="true" %>
<%@ page import="java.util.List" %>

<%
    if (session.getAttribute("rol") == null || !"docente".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String docente = (String) session.getAttribute("nombre");
    List<Contenido> lista = ContenidoDAO.obtenerPorDocente(docente);
%>

<html>
<head>
    <title>Mis Contenidos</title>
    <link rel="stylesheet" href="css/docente.css">
</head>
<body>
    <h2>📚 Mis Contenidos Publicados</h2>
    <table border="1" width="100%">
        <tr>
            <th>Título</th><th>Curso</th><th>Grado</th><th>Nivel</th><th>Acciones</th>
        </tr>
        <%
            for (Contenido c : lista) {
        %>
        <tr>
            <td><%= c.getTitulo() %></td>
            <td><%= c.getNombreCurso() %></td>
            <td><%= c.getGrado() %></td>
            <td><%= c.getNivel() %></td>
            <td>
                <a href="editarContenido.jsp?id=<%= c.getId_contenido() %>">✏️ Editar</a>
                <a href="../ContenidoServlet?accion=eliminar&id=<%= c.getId_contenido() %>">🗑 Eliminar</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
