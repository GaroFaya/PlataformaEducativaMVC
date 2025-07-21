package controlador;

import dao.UsuarioDAO;
import modelo.Usuario;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.*;
import javax.servlet.http.*;

public class UsuarioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            UsuarioDAO.eliminarUsuario(id);
            response.sendRedirect("crud/usuarios.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("crear".equals(accion)) {
            Usuario u = new Usuario();
            u.setNombre(request.getParameter("nombre"));
            u.setCorreo(request.getParameter("correo"));
            u.setClave(UsuarioDAO.encriptarSHA256(request.getParameter("clave"))); // Encriptado
            u.setRol(request.getParameter("rol"));

            // NUEVOS CAMPOS
            u.setDni(request.getParameter("dni"));
            u.setGrado(request.getParameter("grado"));
            u.setNivel(request.getParameter("nivel"));

            String fecha = request.getParameter("fecha_nacimiento");
            if (fecha != null && !fecha.isEmpty()) {
                u.setFecha_nacimiento(java.sql.Date.valueOf(fecha));
            }

            UsuarioDAO.insertarUsuario(u);
            response.sendRedirect("crud/usuarios.jsp");
            
        } else if ("editar".equals(accion)) {
            Usuario u = new Usuario();
            u.setId_usuario(Integer.parseInt(request.getParameter("id_usuario")));
            u.setNombre(request.getParameter("nombre"));
            u.setCorreo(request.getParameter("correo"));

            String nuevaClave = request.getParameter("clave");
            if (nuevaClave == null || nuevaClave.isEmpty()) {
                u.setClave(UsuarioDAO.obtenerClavePorId(u.getId_usuario()));
            } else {
                u.setClave(UsuarioDAO.encriptarSHA256(nuevaClave));
            }

            u.setRol(request.getParameter("rol"));
            u.setDni(request.getParameter("dni"));
            u.setFecha_nacimiento(java.sql.Date.valueOf(request.getParameter("fecha_nacimiento")));
            u.setGrado(request.getParameter("grado"));
            u.setNivel(request.getParameter("nivel"));

            UsuarioDAO.actualizarUsuario(u);
            response.sendRedirect("crud/usuarios.jsp");
        }


    }
}
