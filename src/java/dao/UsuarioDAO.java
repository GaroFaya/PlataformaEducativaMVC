package dao;

import modelo.Usuario;
import java.sql.*;
import java.util.*;
import java.security.MessageDigest;



public class UsuarioDAO {

    // Obtener lista de todos los usuarios
    public static List<Usuario> obtenerUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        try (Connection con = Conexion.conectar()) {
            String sql = "SELECT * FROM usuarios";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setNombre(rs.getString("nombre"));
                u.setCorreo(rs.getString("correo"));
                u.setRol(rs.getString("rol"));
                u.setDni(rs.getString("dni"));
                u.setFecha_nacimiento(rs.getDate("fecha_nacimiento"));
                u.setGrado(rs.getString("grado"));
                u.setNivel(rs.getString("nivel"));
                lista.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }


    

    // Actualizar usuario existente
    public static void actualizarUsuario(Usuario u) {
        try (Connection con = Conexion.conectar()) {
            String sql = "UPDATE usuarios SET nombre=?, correo=?, clave=?, rol=?, dni=?, fecha_nacimiento=?, grado=?, nivel=? WHERE id_usuario=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getCorreo());
            ps.setString(3, u.getClave());
            ps.setString(4, u.getRol());
            ps.setString(5, u.getDni());
            ps.setDate(6, u.getFecha_nacimiento());
            ps.setString(7, u.getGrado());
            ps.setString(8, u.getNivel());
            ps.setInt(9, u.getId_usuario());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    // Buscar usuario por ID (para editar)
    public static Usuario buscarPorId(int id) {
        Usuario u = new Usuario();
        try (Connection con = Conexion.conectar()) {
            String sql = "SELECT * FROM usuarios WHERE id_usuario = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u.setId_usuario(rs.getInt("id_usuario"));
                u.setNombre(rs.getString("nombre"));
                u.setCorreo(rs.getString("correo"));
                u.setClave(rs.getString("clave"));
                u.setRol(rs.getString("rol"));
                u.setDni(rs.getString("dni"));
                u.setFecha_nacimiento(rs.getDate("fecha_nacimiento"));
                u.setGrado(rs.getString("grado"));
                u.setNivel(rs.getString("nivel"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }


    // Eliminar usuario por ID
    public static void eliminarUsuario(int id) {
        try (Connection con = Conexion.conectar()) {
            String sql = "DELETE FROM usuarios WHERE id_usuario = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static Usuario buscarPorCorreo(String correo) {
    try (Connection con = Conexion.conectar()) {
        String sql = "SELECT * FROM usuarios WHERE correo = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, correo);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Usuario u = new Usuario();
            u.setId_usuario(rs.getInt("id_usuario"));
            u.setNombre(rs.getString("nombre"));
            u.setCorreo(rs.getString("correo"));
            return u;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}

    public static void actualizarClave(Usuario u) {
    try (Connection con = Conexion.conectar()) {
        String sql = "UPDATE usuarios SET clave=? WHERE id_usuario=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, u.getClave());
        ps.setInt(2, u.getId_usuario());
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}


    
    public static void insertarUsuario(Usuario u) {
    try (Connection con = Conexion.conectar()) {
        String sql = "INSERT INTO usuarios (nombre, correo, clave, rol, dni, fecha_nacimiento, grado, nivel) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, u.getNombre());
        ps.setString(2, u.getCorreo());
        ps.setString(3, u.getClave());
        ps.setString(4, u.getRol());
        ps.setString(5, u.getDni());
        ps.setDate(6, u.getFecha_nacimiento());  // ✅ tipo java.sql.Date
        ps.setString(7, u.getGrado());
        ps.setString(8, u.getNivel());

        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}


    // Insertar nuevo usuario
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
    
    public static String obtenerClavePorId(int id) {
        String clave = "";
        try (Connection con = Conexion.conectar()) {
            String sql = "SELECT clave FROM usuarios WHERE id_usuario = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                clave = rs.getString("clave");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return clave;
    }
    
    public static Usuario buscarPorCorreoDniNacimiento(String correo, String dni, String fechaNacimiento) {
    Usuario u = null;
    try (Connection con = Conexion.conectar()) {
        String sql = "SELECT * FROM usuarios WHERE correo=? AND dni=? AND fecha_nacimiento=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, correo);
        ps.setString(2, dni);
        ps.setDate(3, java.sql.Date.valueOf(fechaNacimiento));
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            u = new Usuario();
            u.setId_usuario(rs.getInt("id_usuario"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return u;
}


}