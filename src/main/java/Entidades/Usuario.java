package Entidades;

public class Usuario {
public int id_usuario;
public String username;
public String password;
public String rol;
public int estado;
public Usuario() {}
public Usuario(int id_usuario, String username, String password, String rol, int estado) {
	this.id_usuario = id_usuario;
	this.username = username;
	this.password = password;
	this.rol = rol;
	this.estado = estado;
}
public int getId_usuario() {
	return id_usuario;
}
public void setId_usuario(int id_usuario) {
	this.id_usuario = id_usuario;
}
public String getUsername() {
	return username;
}
public void setUsername(String username) {
	this.username = username;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}
public String getRol() {
	return rol;
}
public void setRol(String rol) {
	this.rol = rol;
}
public int getEstado() {
	return estado;
}
public void setEstado(int estado) {
	this.estado = estado;
}

}
