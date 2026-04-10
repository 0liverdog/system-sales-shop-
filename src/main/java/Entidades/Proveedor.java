package Entidades;

public class Proveedor {
public int id_proveedor;
public String nombre;
public String ruc;
public String telefono;
public int estado;

public Proveedor() {}

public Proveedor(int id_proveedor, String nombre, String ruc, String telefono, int estado) {
	this.id_proveedor = id_proveedor;
	this.nombre = nombre;
	this.ruc = ruc;
	this.telefono = telefono;
	this.estado = estado;
}

public int getId_proveedor() {
	return id_proveedor;
}

public void setId_proveedor(int id_proveedor) {
	this.id_proveedor = id_proveedor;
}

public String getNombre() {
	return nombre;
}

public void setNombre(String nombre) {
	this.nombre = nombre;
}

public String getRuc() {
	return ruc;
}

public void setRuc(String ruc) {
	this.ruc = ruc;
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
