<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("rol") == null || !"docente".equals(session.getAttribute("rol"))) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int idDocente = (int) session.getAttribute("id_usuario");
    String filtroGrado = request.getParameter("grado");
    String filtroCurso = request.getParameter("curso");
    String filtroNivel = request.getParameter("nivel");

    Connection con = dao.Conexion.conectar();

    // Obtener grados, niveles y cursos para los filtros
    PreparedStatement gradosStmt = con.prepareStatement(
        "SELECT DISTINCT grado FROM usuarios WHERE rol = 'estudiante' AND grado IS NOT NULL ORDER BY grado");
    ResultSet gradosRs = gradosStmt.executeQuery();

    PreparedStatement nivelesStmt = con.prepareStatement(
        "SELECT DISTINCT nivel FROM usuarios WHERE rol = 'estudiante' AND nivel IS NOT NULL ORDER BY nivel");
    ResultSet nivelesRs = nivelesStmt.executeQuery();

    PreparedStatement cursosStmt = con.prepareStatement(
        "SELECT id_curso, nombre FROM cursos ORDER BY nombre");
    ResultSet cursosRs = cursosStmt.executeQuery();

    // Consulta principal mejorada para mostrar todos los cursos
    String sql = "SELECT u.id_usuario, u.nombre, u.correo, u.grado, u.nivel, " +
                "GROUP_CONCAT(DISTINCT c.nombre ORDER BY c.nombre SEPARATOR ', ') AS cursos, " +
                "COUNT(DISTINCT p.id_progreso) AS actividades, " +
                "COALESCE(AVG(p.porcentaje), 0) AS progreso " +
                "FROM usuarios u " +
                "LEFT JOIN progreso p ON u.id_usuario = p.id_estudiante " +
                "LEFT JOIN videos v ON p.id_video = v.id_video " +
                "LEFT JOIN cursos c ON v.id_curso = c.id_curso " +
                "WHERE u.rol = 'estudiante' ";

    if (filtroGrado != null && !filtroGrado.isEmpty()) {
        sql += " AND u.grado = ?";
    }
    if (filtroNivel != null && !filtroNivel.isEmpty()) {
        sql += " AND u.nivel = ?";
    }
    if (filtroCurso != null && !filtroCurso.isEmpty()) {
        sql += " AND c.id_curso = ?";
    }

    sql += " GROUP BY u.id_usuario, u.nombre, u.correo, u.grado, u.nivel " +
           "ORDER BY u.nivel, u.grado, u.nombre";

    PreparedStatement ps = con.prepareStatement(sql);

    int paramIndex = 1;
    if (filtroGrado != null && !filtroGrado.isEmpty()) {
        ps.setString(paramIndex++, filtroGrado);
    }
    if (filtroNivel != null && !filtroNivel.isEmpty()) {
        ps.setString(paramIndex++, filtroNivel);
    }
    if (filtroCurso != null && !filtroCurso.isEmpty()) {
        ps.setInt(paramIndex++, Integer.parseInt(filtroCurso));
    }

    ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>📊 Reportes de Estudiantes</title>
    <link rel="stylesheet" href="css/docente.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        header {
            background-color: #4CAF50;
            color: white;
            padding: 15px 20px;
            font-size: 1.5em;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .container {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .filter-form {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .filter-row {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 15px;
        }
        .filter-group {
            flex: 1;
            min-width: 200px;
        }
        .filter-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        .filter-group select {
            width: 100%;
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ddd;
            background-color: white;
        }
        .filter-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }
        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        .btn-filter {
            background-color: #4CAF50;
            color: white;
        }
        .btn-reset {
            background-color: #f44336;
            color: white;
        }
        .btn-back {
            background-color: #2196F3;
            color: white;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
            padding: 10px 15px;
        }
        .report-table {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f9fa;
            position: sticky;
            top: 0;
            font-weight: bold;
            color: #333;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .progress-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .progress-bar {
            width: 100px;
            height: 20px;
            background-color: #f1f1f1;
            border-radius: 5px;
            overflow: hidden;
        }
        .progress-fill {
            height: 100%;
            background-color: #4CAF50;
            border-radius: 5px;
        }
        .no-results {
            text-align: center;
            padding: 20px;
            color: #666;
            font-style: italic;
        }
        footer {
            text-align: center;
            padding: 15px;
            margin-top: 20px;
            color: #666;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <header>📈 Reportes de Estudiantes</header>
    <div class="container">
        <form method="get" action="verReportes.jsp" class="filter-form">
            <div class="filter-row">
                <div class="filter-group">
                    <label for="grado">Grado:</label>
                    <select name="grado" id="grado">
                        <option value="">-- Todos los grados --</option>
                        <% while (gradosRs.next()) { 
                            String grado = gradosRs.getString("grado");
                            String selected = (grado.equals(filtroGrado)) ? "selected" : "";
                        %>
                            <option value="<%= grado %>" <%= selected %>><%= grado %></option>
                        <% } %>
                    </select>
                </div>

                <div class="filter-group">
                    <label for="nivel">Nivel:</label>
                    <select name="nivel" id="nivel">
                        <option value="">-- Todos los niveles --</option>
                        <% while (nivelesRs.next()) { 
                            String nivel = nivelesRs.getString("nivel");
                            String selected = (nivel.equals(filtroNivel)) ? "selected" : "";
                        %>
                            <option value="<%= nivel %>" <%= selected %>><%= nivel %></option>
                        <% } %>
                    </select>
                </div>

                <div class="filter-group">
                    <label for="curso">Curso:</label>
                    <select name="curso" id="curso">
                        <option value="">-- Todos los cursos --</option>
                        <% while (cursosRs.next()) { 
                            String cursoId = cursosRs.getString("id_curso");
                            String cursoNombre = cursosRs.getString("nombre");
                            String selected = (cursoId.equals(filtroCurso)) ? "selected" : "";
                        %>
                            <option value="<%= cursoId %>" <%= selected %>><%= cursoNombre %></option>
                        <% } %>
                    </select>
                </div>
            </div>

            <div class="filter-actions">
                <button type="submit" class="btn btn-filter">🔍 Filtrar</button>
                <a href="verReportes.jsp" class="btn btn-reset">🔄 Limpiar</a>
            </div>
        </form>

        <div class="report-table">
            <table>
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Correo</th>
                        <th>Grado</th>
                        <th>Nivel</th>
                        <th>Cursos</th>
                        <th>Actividades</th>
                        <th>Progreso</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (!rs.isBeforeFirst()) { %>
                        <tr>
                            <td colspan="7" class="no-results">No se encontraron estudiantes con los filtros aplicados</td>
                        </tr>
                    <% } else { 
                        while (rs.next()) {
                            int progreso = (int) Math.round(rs.getDouble("progreso"));
                            String cursos = rs.getString("cursos");
                    %>
                        <tr>
                            <td><%= rs.getString("nombre") %></td>
                            <td><%= rs.getString("correo") %></td>
                            <td><%= rs.getString("grado") %></td>
                            <td><%= rs.getString("nivel") %></td>
                            <td><%= cursos != null ? cursos : "Sin cursos" %></td>
                            <td><%= rs.getInt("actividades") %></td>
                            <td>
                                <div class="progress-container">
                                    <div class="progress-bar">
                                        <div class="progress-fill" style="width: <%= progreso %>%"></div>
                                    </div>
                                    <span><%= progreso %>%</span>
                                </div>
                            </td>
                        </tr>
                    <% } 
                    } %>
                </tbody>
            </table>
        </div>

        <a href="panelDocente.jsp" class="btn-back">⬅️ Volver al Panel</a>
    </div>

    <footer>Plataforma Educativa - IEP San Vicente de Motupe © 2025</footer>
</body>
</html>
<%
    // Cerrar todos los recursos
    if (gradosRs != null) gradosRs.close();
    if (gradosStmt != null) gradosStmt.close();
    if (nivelesRs != null) nivelesRs.close();
    if (nivelesStmt != null) nivelesStmt.close();
    if (cursosRs != null) cursosRs.close();
    if (cursosStmt != null) cursosStmt.close();
    if (rs != null) rs.close();
    if (ps != null) ps.close();
    if (con != null) con.close();
%>