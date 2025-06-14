<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Estudiante</title>
    <link rel="stylesheet" href="css/registro.css">
</head>
<body>
    <div class="registro-container">
        <h2>📚 Registro de Estudiante</h2>
        <form action="RegistroServlet" method="post" class="formulario-registro">
            <label for="nombre">👤 Nombre completo:</label>
            <input type="text" name="nombre" id="nombre" required>

            <label for="correo">📧 Correo electrónico:</label>
            <input type="email" name="correo" id="correo" required>

            <label for="clave">🔒 Contraseña:</label>
            <input type="password" name="clave" id="clave" required>

            <label for="dni">🪪 DNI:</label>
            <input type="text" name="dni" id="dni" maxlength="20" required>

            <label for="fecha_nacimiento">🎂 Fecha de nacimiento:</label>
            <input type="date" name="fecha_nacimiento" id="fecha_nacimiento" required>

            <label for="grado">🎓 Grado:</label>
            <select name="grado" required>
                <option value="">--Selecciona--</option>
                <option>1</option>
                <option>2</option>
                <option>3</option>
                <option>4</option>
                <option>5</option>
                <option>6</option>
            </select>
            <p>
            <label for="nivel">🏫 Nivel:</label>
            <select name="nivel" required>
                <option value="">--Selecciona--</option>
                <option>Primaria</option>
                <option>Secundaria</option>
            </select>
            <p>
            <input type="hidden" name="rol" value="estudiante">

            <button type="submit">✅ Registrarse</button>
        </form>
        <p class="volver"><a href="index.jsp">⬅️ Volver al inicio</a></p>
    </div>
</body>
</html>
