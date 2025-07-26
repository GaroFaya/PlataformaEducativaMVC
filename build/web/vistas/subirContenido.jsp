<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("rol") == null || !"docente".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
    }
%>

<%@ page import="java.sql.*" %>
<%
    Connection con = dao.Conexion.conectar();
    PreparedStatement ps = con.prepareStatement("SELECT id_curso, nombre FROM cursos ORDER BY nombre ASC");
    ResultSet cursosRs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Subir Contenido</title>
    <link rel="stylesheet" href="css/docente.css">
    <style>
        .formulario-contenido {
            max-width: 600px;
            margin: auto;
            display: flex;
            flex-direction: column;
            gap: 15px;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .formulario-contenido label {
            font-weight: bold;
            color: #2c3e50;
        }

        .formulario-contenido input,
        .formulario-contenido select,
        .formulario-contenido textarea {
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
            width: 100%;
            box-sizing: border-box;
        }

        .formulario-contenido button {
            padding: 12px;
            background-color: #27ae60;
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .formulario-contenido button:hover {
            background-color: #219150;
        }
    </style>
</head>
<body>
    <header>📥 Subir Contenido Educativo</header>

    <div class="container">
        <div class="panel">
            <h2>Hola, <%= session.getAttribute("nombre") %> 👨‍🏫</h2>
            <p>Agrega nuevo material por curso y grado:</p>

            <form action="../ContenidoServlet" method="post" class="formulario-contenido">
                <label>Título:</label>
                <input type="text" name="titulo" required>

                <label>Descripción:</label>
                <textarea name="descripcion" rows="4" required></textarea>

                <label>Curso:</label>
                <select name="curso_id" required>
                    <option value="">-- Selecciona --</option>
                    <%
                        while (cursosRs.next()) {
                            int idCurso = cursosRs.getInt("id_curso");
                            String nombreCurso = cursosRs.getString("nombre");
                    %>
                        <option value="<%= idCurso %>"><%= nombreCurso %></option>
                    <%
                        }
                        cursosRs.close();
                        ps.close();
                        con.close();
                    %>
                </select>


                <label>Grado:</label>
                <select name="grado" required>
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                    <option>4</option>
                    <option>5</option>
                    <option>6</option>
                </select>

                <label>Nivel:</label>
                <select name="nivel" required>
                    <option>Primaria</option>
                    <option>Secundaria</option>
                </select>

                <label>Enlace del video (YouTube, Drive, etc.):</label>
                <input type="url" name="link" placeholder="https://..." required>

                <button type="submit">📤 Publicar Contenido</button>
            </form>


            <br>
            <a href="panelDocente.jsp">⬅️ Volver al panel</a>
        </div>
    </div>

    <footer>
        Plataforma Educativa - IEP San Vicente de Motupe © 2025
    </footer>
</body>
</html>
