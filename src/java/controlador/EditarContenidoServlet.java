package controlador;

import dao.Conexion;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EditarContenidoServlet")
public class EditarContenidoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idContenido = Integer.parseInt(request.getParameter("id"));

        try (Connection con = Conexion.conectar()) {
            String sql = "SELECT * FROM contenidos WHERE id_contenido = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idContenido);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("id", rs.getInt("id_contenido"));
                request.setAttribute("titulo", rs.getString("titulo"));
                request.setAttribute("descripcion", rs.getString("descripcion"));
                request.setAttribute("link", rs.getString("link"));
                request.setAttribute("grado", rs.getString("grado"));
                request.setAttribute("nivel", rs.getString("nivel"));
                request.setAttribute("curso_id", rs.getInt("curso_id"));
            }

            // cargar cursos
            PreparedStatement psCursos = con.prepareStatement("SELECT id_curso, nombre FROM cursos");
            ResultSet cursos = psCursos.executeQuery();
            request.setAttribute("cursosRs", cursos);

            request.getRequestDispatcher("vistas/editarContenido.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("vistas/misCursos.jsp?error=sql");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id_contenido"));
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String link = request.getParameter("link");
        String grado = request.getParameter("grado");
        String nivel = request.getParameter("nivel");
        int cursoId = Integer.parseInt(request.getParameter("curso_id"));

        try (Connection con = Conexion.conectar()) {
            String sql = "UPDATE contenidos SET titulo=?, descripcion=?, link=?, grado=?, nivel=?, curso_id=? WHERE id_contenido=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, titulo);
            ps.setString(2, descripcion);
            ps.setString(3, link);
            ps.setString(4, grado);
            ps.setString(5, nivel);
            ps.setInt(6, cursoId);
            ps.setInt(7, id);

            ps.executeUpdate();
            response.sendRedirect("vistas/misCursos.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("vistas/misCursos.jsp?error=sql");
        }
    }
}
