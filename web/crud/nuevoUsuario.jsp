<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("rol") == null || !"admin".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nuevo Usuario</title>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
    <header>➕ Crear Nuevo Usuario</header>
    <div class="container">
        <div class="panel">
            <form action="../UsuarioServlet" method="post" class="formulario-registro">
                <input type="hidden" name="accion" value="crear">

                <label>👤 Nombre:</label>
                <input type="text" name="nombre" required>

                <label>📧 Correo:</label>
                <input type="email" name="correo" required>

                <label>🔒 Clave:</label>
                <input type="password" name="clave" required>

                <label>🆔 DNI:</label>
                <input type="text" name="dni" maxlength="20" required>

                <label>📅 Fecha de nacimiento:</label>
                <input type="date" name="fecha_nacimiento" required>

                <label>🎓 Grado:</label>
                <input type="text" name="grado" required>

                <label>🏫 Nivel:</label>
                <select name="nivel" required>
                    <option value="Primaria">Primaria</option>
                    <option value="Secundaria">Secundaria</option>
                </select>

                <label>🔰 Rol:</label>
                <select name="rol" required>
                    <option value="estudiante">Estudiante</option>
                    <option value="docente">Docente</option>
                    <option value="admin">Administrador</option>
                </select>

                <button type="submit">💾 Guardar Usuario</button>
            </form>
            <br>
            <a href="usuarios.jsp">⬅️ Volver a la lista</a>
        </div>
    </div>
</body>
</html>
