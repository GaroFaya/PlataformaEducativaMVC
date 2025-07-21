<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="modelo.Usuario" %>
<%@ page import="dao.UsuarioDAO" %>
<%@ page import="java.util.*" %>
<%@ page session="true" %>

<%@ page contentType="text/html; charset=UTF-8" %>


<%
    if (session.getAttribute("rol") == null || !"admin".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
        return;
    }

    List<Usuario> listaUsuarios = UsuarioDAO.obtenerUsuarios();

%>

<html>
<head>
    <title>Gestión de Usuarios</title>
    <link rel="stylesheet" href="css/admin.css">


</head>
<body>
    <h2>Usuarios Registrados</h2>
    <a href="index.jsp">← Volver al Panel</a>
    <table border="1" cellpadding="10">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Correo</th>
            <th>DNI</th>
            <th>Fecha Nac.</th>
            <th>Grado</th>
            <th>Nivel</th>
            <th>Rol</th>
            <th>Acciones</th>
        </tr>
        <%
            for (Usuario u : listaUsuarios) {
        %>
        <tr>
            <td><%= u.getId_usuario() %></td>
            <td><%= u.getNombre() %></td>
            <td><%= u.getCorreo() %></td>
            <td><%= u.getDni() %></td>
            <td><%= u.getFecha_nacimiento() %></td>
            <td><%= u.getGrado() %></td>
            <td><%= u.getNivel() %></td>
            <td><%= u.getRol() %></td>
            <td>
                <a href="editarUsuario.jsp?id=<%= u.getId_usuario() %>">✏️ Editar</a> |
                <a href="../UsuarioServlet?accion=eliminar&id=<%= u.getId_usuario() %>">🗑 Eliminar</a>
            </td>
        </tr>
        <% } %>
    </table>
    <br>
    <a href="nuevoUsuario.jsp">➕ Crear nuevo usuario</a>
</body>
</html>
