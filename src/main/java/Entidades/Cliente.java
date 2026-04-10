package Entidades;

public class Cliente {
public int id_cliente;
public String nombre;
public String dni;
public String telefono;
public int estado;
public Cliente() {}
public Cliente(int id_cliente, String nombre, String dni, String telefono, int estado) {
	this.id_cliente = id_cliente;
	this.nombre = nombre;
	this.dni = dni;
	this.telefono = telefono;
	this.estado = estado;
}
public int getId_cliente() {
	return id_cliente;
}
public void setId_cliente(int id_cliente) {
	this.id_cliente = id_cliente;
}
public String getNombre() {
	return nombre;
}
public void setNombre(String nombre) {
	this.nombre = nombre;
}
public String getDni() {
	return dni;
}
public void setDni(String dni) {
	this.dni = dni;
}
public String getTelefono() {
	return telefono;
}
public void setTelefono(String telefono) {
	this.telefono = telefono;
}
public int getEstado() {
	return estado;
}
public void setEstado(int estado) {
	this.estado = estado;
}

}
