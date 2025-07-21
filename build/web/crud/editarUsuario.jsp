<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="modelo.Usuario" %>
<%@ page import="dao.UsuarioDAO" %>
<%@ page session="true" %>

<%
    if (session.getAttribute("rol") == null || !"admin".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    Usuario u = UsuarioDAO.buscarPorId(id); // Este método debe existir en UsuarioDAO
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
    <header>
        Plataforma Educativa - Admin
    </header>

    <div class="container">
        <div class="panel">
            <h2>✏️ Editar Usuario</h2>

            <form action="../UsuarioServlet" method="post" class="formulario-registro">
                <input type="hidden" name="accion" value="editar">
                <input type="hidden" name="id_usuario" value="<%= u.getId_usuario() %>">

                <label for="nombre">Nombre:</label>
                <input type="text" name="nombre" value="<%= u.getNombre() %>" required>

                <label for="correo">Correo:</label>
                <input type="email" name="correo" value="<%= u.getCorreo() %>" required>

                <label for="clave">Contraseña:</label>
                <input type="password" name="clave" placeholder="Opcional">

                <label for="dni">DNI:</label>
                <input type="text" name="dni" value="<%= u.getDni() %>" required>

                <label for="fecha_nacimiento">Fecha de nacimiento:</label>
                <input type="date" name="fecha_nacimiento" value="<%= u.getFecha_nacimiento() %>" required>

                <label for="grado">Grado:</label>
                <input type="text" name="grado" value="<%= u.getGrado() %>" required>

                <label for="nivel">Nivel:</label>
                <select name="nivel" required>
                    <option value="Primaria" <%= "Primaria".equals(u.getNivel()) ? "selected" : "" %>>Primaria</option>
                    <option value="Secundaria" <%= "Secundaria".equals(u.getNivel()) ? "selected" : "" %>>Secundaria</option>
                </select>

                <label for="rol">Rol:</label>
                <select name="rol" required>
                    <option value="estudiante" <%= u.getRol().equals("estudiante") ? "selected" : "" %>>Estudiante</option>
                    <option value="docente" <%= u.getRol().equals("docente") ? "selected" : "" %>>Docente</option>
                    <option value="admin" <%= u.getRol().equals("admin") ? "selected" : "" %>>Administrador</option>
                </select>

                <button type="submit">💾 Guardar cambios</button>
            </form>


            <div class="volver">
                <a href="usuarios.jsp">⬅️ Volver</a>
            </div>
        </div>
    </div>

    <footer>
        Plataforma Educativa - IEP San Vicente de Motupe © 2025
    </footer>
</body>

</html>
