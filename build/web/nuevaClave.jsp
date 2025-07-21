<%@ page import="modelo.Usuario" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    Usuario usuario = (Usuario) request.getAttribute("usuario");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Establecer nueva contraseña</title>
    <link rel="stylesheet" href="css/registro.css">
</head>
<body>
    <div class="registro-container">
        <h2>🔑 Establecer Nueva Contraseña</h2>
        <form action="ActualizarClaveServlet" method="post">
            <input type="hidden" name="id_usuario" value="<%= usuario.getId_usuario() %>">
            <label>Nueva contraseña:</label>
            <input type="password" name="clave" required>
            <button type="submit">Guardar nueva contraseña</button>
        </form>
    </div>
</body>
</html>
