<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Recuperar contraseña</title>
    <link rel="stylesheet" href="css/registro.css">
</head>
<body>
    <div class="registro-container">
        <h2>🔐 Recuperar Contraseña</h2>
        <form action="RecuperarClaveServlet" method="post" class="formulario-registro">

            <label for="correo">📧 Correo registrado:</label>
            <input type="email" name="correo" required>

            <label for="dni">🆔 DNI:</label>
            <input type="text" name="dni" maxlength="20" required>

            <label for="fecha_nacimiento">📅 Fecha de nacimiento:</label>
            <input type="date" name="fecha_nacimiento" required>

            <label for="clave">🔑 Nueva contraseña:</label>
            <input type="password" name="clave" required>

            <button type="submit">✅ Cambiar contraseña</button>
        </form>

        <p class="volver"><a href="login.jsp">⬅️ Volver al login</a></p>
    </div>
</body>
</html>
