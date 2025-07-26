package controlador;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@MultipartConfig
public class ContenidoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String grado = request.getParameter("grado");
        String nivel = request.getParameter("nivel");
        String link = request.getParameter("link");
        int cursoId = Integer.parseInt(request.getParameter("curso_id"));

        // ✅ Obtener el nombre del docente desde la sesión
        String docente = (String) request.getSession().getAttribute("nombre");

        // Insertar en base de datos
        try (Connection con = dao.Conexion.conectar()) {
            String sql = "INSERT INTO contenidos (titulo, descripcion, link, curso_id, grado, nivel, docente, fecha_publicacion) VALUES (?, ?, ?, ?, ?, ?, ?, CURDATE())";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, titulo);
            ps.setString(2, descripcion);
            ps.setString(3, link);
            ps.setInt(4, cursoId);
            ps.setString(5, grado);
            ps.setString(6, nivel);
            ps.setString(7, docente);  // 👈 Aquí se guarda quién lo subió
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("vistas/panelDocente.jsp?subido=ok");
    }
}
