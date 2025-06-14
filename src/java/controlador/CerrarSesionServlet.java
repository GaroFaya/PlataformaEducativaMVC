package controlador;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class CerrarSesionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false); // no crear nueva si no existe
        if (session != null) {
            session.invalidate(); // cerrar sesión
        }

        response.sendRedirect("login.jsp"); // volver al login
    }
}
