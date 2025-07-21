package controlador;

import java.io.*;
import java.nio.file.*;
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
        int cursoId = Integer.parseInt(request.getParameter("curso_id"));

        Part archivo = request.getPart("archivo");
        String nombreArchivo = Paths.get(archivo.getSubmittedFileName()).getFileName().toString();

        // ✅ Guardar en carpeta interna del proyecto
        String carpetaMateriales = getServletContext().getRealPath("/materiales");
        File directorio = new File(carpetaMateriales);
        if (!directorio.exists()) {
            directorio.mkdirs();
        }

        String rutaArchivo = carpetaMateriales + File.separator + nombreArchivo;
        archivo.write(rutaArchivo);

        // Guardar en base de datos
        try (Connection con = dao.Conexion.conectar()) {
            String sql = "INSERT INTO contenidos (titulo, descripcion, archivo, curso_id, grado, fecha_publicacion) VALUES (?, ?, ?, ?, ?, CURDATE())";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, titulo);
            ps.setString(2, descripcion);
            ps.setString(3, nombreArchivo);
            ps.setInt(4, cursoId);
            ps.setString(5, grado);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("vistas/panelDocente.jsp?subido=ok");
    }
}
