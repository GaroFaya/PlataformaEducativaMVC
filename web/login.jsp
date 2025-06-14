<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión | Plataforma Educativa</title>
    <link rel="stylesheet" href="css/estiloslogin.css">
</head>
<body class="login-body">
    <div class="login-box">
        <h2>Accede a tu cuenta</h2>
        <form method="post" action="LoginServlet">
            <div class="input-group">
                <label for="correo">Correo electrónico</label>
                <input type="text" name="correo" id="correo" required>
            </div>
            <div class="input-group">
                <label for="clave">Contraseña</label>
                <input type="password" name="clave" id="clave" required>
            </div>
            <button type="submit" class="btn-login">Ingresar</button>
        </form>
        <p class="login-footer">¿No tienes una cuenta? Contacta al administrador.</p>
    </div>
</body>
</html>