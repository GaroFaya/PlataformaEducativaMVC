package modelo;

import java.sql.Date;

public class Usuario {
    private int id_usuario;
    private String nombre;
    private String correo;
    private String clave;
    private String rol;
    private String dni;
    private Date fecha_nacimiento;
    private String grado;
    private String nivel;

    // Getters
    public int getId_usuario() {
        return id_usuario;
    }

    public String getNombre() {
        return nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public String getClave() {
        return clave;
    }

    public String getRol() {
        return rol;
    }

    public String getDni() {
        return dni;
    }

    public Date getFecha_nacimiento() {
        return fecha_nacimiento;
    }

    public String getGrado() {
        return grado;
    }

    public String getNivel() {
        return nivel;
    }

    // Setters
    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public void setFecha_nacimiento(Date fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    public void setGrado(String grado) {
        this.grado = grado;
    }

    public void setNivel(String nivel) {
        this.nivel = nivel;
    }
}
