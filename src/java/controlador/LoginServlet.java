package controlador;

import dao.Conexion;
import java.io.IOException;
import java.security.MessageDigest;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {

    public static String encriptarSHA256(String texto) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(texto.getBytes("UTF-8"));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");

        try (Connection con = Conexion.conectar()) {
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM usuarios WHERE correo = ? AND clave = ?"
            );
            ps.setString(1, correo);
            ps.setString(2, encriptarSHA256(clave));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession sesion = request.getSession();
                sesion.setAttribute("id_usuario", rs.getInt("id_usuario"));
                sesion.setAttribute("nombre", rs.getString("nombre"));
                sesion.setAttribute("rol", rs.getString("rol"));

                // ✅ NUEVO: Guardar grado y nivel del estudiante (útiles para filtrar cursos/videos)
                sesion.setAttribute("grado", rs.getString("grado"));
                sesion.setAttribute("nivel", rs.getString("nivel"));

                String rol = rs.getString("rol");
                if ("estudiante".equalsIgnoreCase(rol)) {
                    response.sendRedirect("vistas/panelEstudiante.jsp");
                } else if ("docente".equalsIgnoreCase(rol)) {
                    response.sendRedirect("vistas/panelDocente.jsp");
                } else if ("admin".equalsIgnoreCase(rol)) {
                    response.sendRedirect("crud/index.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=rol_desconocido");
                }
            } else {
                response.sendRedirect("login.jsp?error=credenciales");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=conexion");
        }
    }
}
