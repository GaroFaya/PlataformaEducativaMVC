package controlador;

import dao.UsuarioDAO;
import modelo.Usuario;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class RecuperarClaveServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String correo = request.getParameter("correo");
        String dni = request.getParameter("dni");
        String fecha = request.getParameter("fecha_nacimiento");
        String nuevaClave = request.getParameter("clave");

        // Buscar usuario por esos 3 datos
        Usuario u = UsuarioDAO.buscarPorCorreoDniNacimiento(correo, dni, fecha);

        if (u != null) {
            String claveEncriptada = UsuarioDAO.encriptarSHA256(nuevaClave);
            u.setClave(claveEncriptada);
            UsuarioDAO.actualizarClave(u);
            response.sendRedirect("login.jsp?clave=actualizada");
        } else {
            response.sendRedirect("recuperarClave.jsp?error=datos_incorrectos");
        }
    }
}
