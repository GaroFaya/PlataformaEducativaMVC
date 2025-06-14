package controlador;

import dao.UsuarioDAO;
import modelo.Usuario;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class ActualizarClaveServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id_usuario"));
        String nuevaClave = request.getParameter("clave");

        Usuario u = new Usuario();
        u.setId_usuario(id);
        u.setClave(UsuarioDAO.encriptarSHA256(nuevaClave));

        UsuarioDAO.actualizarClave(u);  // llama al método con objeto Usuario
        response.sendRedirect("login.jsp?clave=cambiada");
    }
}
