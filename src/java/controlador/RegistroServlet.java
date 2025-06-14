package controlador;

import dao.UsuarioDAO;
import modelo.Usuario;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class RegistroServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // Obtener datos del formulario
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");
        String rol = request.getParameter("rol");

        String dni = request.getParameter("dni");
        String fecha = request.getParameter("fecha_nacimiento");
        String grado = request.getParameter("grado");
        String nivel = request.getParameter("nivel");

        // Convertir fecha a Date
        Date fechaNacimiento = Date.valueOf(fecha);

        // Crear objeto Usuario
        Usuario usuario = new Usuario();
        usuario.setNombre(nombre);
        usuario.setCorreo(correo);
        usuario.setClave(dao.UsuarioDAO.encriptarSHA256(clave)); // Si tienes este método implementado
        usuario.setRol(rol);
        usuario.setDni(dni);
        usuario.setFecha_nacimiento(fechaNacimiento);
        usuario.setGrado(grado);
        usuario.setNivel(nivel);

        // Guardar en base de datos
        UsuarioDAO.insertarUsuario(usuario);

        // Redirigir
        response.sendRedirect("login.jsp?registro=ok");
    }
}
