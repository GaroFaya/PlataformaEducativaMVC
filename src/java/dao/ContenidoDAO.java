package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.Contenido;


public class ContenidoDAO {
    public static List<Contenido> obtenerPorDocente(String nombreDocente) {
    List<Contenido> lista = new ArrayList<>();
    try (Connection con = Conexion.conectar()) {
        String sql = "SELECT c.*, cu.nombre AS nombreCurso FROM contenidos c " +
                     "JOIN cursos cu ON c.curso_id = cu.id_curso " +
                     "WHERE c.docente = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, nombreDocente);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Contenido c = new Contenido();
            c.setId_contenido(rs.getInt("id_contenido"));
            c.setTitulo(rs.getString("titulo"));
            c.setDescripcion(rs.getString("descripcion"));
            c.setCurso_id(rs.getInt("curso_id"));
            c.setGrado(rs.getString("grado"));
            c.setNivel(rs.getString("nivel"));
            c.setArchivo(rs.getString("archivo"));
            c.setLink(rs.getString("link"));
            c.setFecha_publicacion(rs.getDate("fecha_publicacion"));
            c.setNombreCurso(rs.getString("nombreCurso"));
            lista.add(c);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return lista;
}


}
